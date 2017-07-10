<!--#include virtual="/includes/connection.asp" -->
<!--#include virtual="/includes/errorHandler.asp" -->
<%
   'On Error Resume Next
   
   response.buffer = true

   dim usr, myType, hotel, sqlLeads
   
   'err.raise 11

sub main()
	getFormData
	call processData()
end sub

sub getFormData()
  usr = request.querystring("userid")
  'if usr = "" then usr = 1
  hotel = request.querystring("hotel")
  myType = request.querystring("myType")  ' table or chart
end sub

sub TrapIt()
	If Err.number <> 0 then
  		call TrapError(Err.description, err.number, usr, sqlLeads)
	End If
end sub


sub processData()
	on error resume next

	set myConnSQL = server.createobject("ADODB.Connection")
	myConnSQL.Open strConnSQL
	call TrapIt()
	
	if myType = "table" then
		sqlLeads = "Select ID,Company,myEvent,Arrival, Sent_Date,TotalRooms,RmRevenue + RentalRevenue + CateringRevenue as Revenue,Bonus,myStatus from Referrals where RefHotel = '" & hotel & "' order by Sent_Date,Company,myEvent "
		set rsLeads = myConnSQL.Execute(sqlLeads)
	
		call TrapIt()

		xmlLeads = "<?xml version='1.0' encoding='ISO-8859-1' ?><response><items>"
		
		While not rsLeads.eof
			myStatus = rsLeads("myStatus")
			select case myStatus
				case "DEF"
					myStatus = "Definite!"
				case "TENT"
					myStatus = "Tentative"
				case "PEND"
					myStatus = "Pending"
				case "REJ"
					myStatus = "Rejected"
				case "LOST"
					myStatus = "Lost"
			end select
			
			xmlLeads = xmlLeads & "<item>"
				xmlLeads = xmlLeads & "<code>0</code>"
				xmlLeads = xmlLeads & "<id>" & rsLeads("ID") & "</id>"
				xmlLeads = xmlLeads & "<company>" & rsLeads("company") & "</company>"
				xmlLeads = xmlLeads & "<myEvent>" & rsLeads("myEvent") & "</myEvent>"
				xmlLeads = xmlLeads & "<arrival>" & rsLeads("arrival") & "</arrival>"
				xmlLeads = xmlLeads & "<totalTotal>" & rsLeads("totalrooms") & "</totalTotal>"
				xmlLeads = xmlLeads & "<ttlRevenue>" & rsLeads("revenue") & "</ttlRevenue>"
				xmlLeads = xmlLeads & "<sentDate>" & rsLeads("Sent_Date") & "</sentDate>"
				xmlLeads = xmlLeads & "<myStatus>" & myStatus & "</myStatus>"
				xmlLeads = xmlLeads & "<bonus>" & rsLeads("bonus") & "</bonus>"
			xmlLeads = xmlLeads & "</item>"
		
			rsLeads.movenext
		wend
		if rsLeads.eof and rsLeads.bof then
			xmlLeads = xmlLeads & "<item>"
				xmlLeads = xmlLeads & "<code>0</code>"
				xmlLeads = xmlLeads & "<id>0</id>"
				xmlLeads = xmlLeads & "<company>No referrals.</company>"
				xmlLeads = xmlLeads & "<myEvent></myEvent>"
				xmlLeads = xmlLeads & "<date1></date1>"
				xmlLeads = xmlLeads & "<totalTotal></totalTotal>"
				xmlLeads = xmlLeads & "<ttlRevenue></ttlRevenue>"
				xmlLeads = xmlLeads & "<sentDate></sentDate>"
				xmlLeads = xmlLeads & "<workingHotel></workingHotel>"
				xmlLeads = xmlLeads & "<myStatus></myStatus>"
				xmlLeads = xmlLeads & "<bonus></bonus>"
			xmlLeads = xmlLeads & "</item>"
		end if
		rsLeads.close
		set rsLeads = nothing
		call TrapIt()
		
		xmlLeads = xmlLeads & "</items></response>"
		
		
		
		
	else  ' Chart
	
	
		xmlLeads = "<?xml version='1.0' encoding='ISO-8859-1' ?><response><items>"
		
		for x = 11 to 0 step -1
			myMonth = month(dateadd("m",-x,now())) 
			myYear = year(dateadd("m",-x,now()))
						
			sqlLeads = "Select Count(ID) as myCount from Referrals where RefHotel = '" & hotel & "' and month(sent_date)=" & myMonth & " and year(sent_date)=" & myYear
			set rsLeads = myConnSQL.Execute(sqlLeads)
			call TrapIt()
			
			if not rsLeads.eof and vartype(rsLeads(0)) <> 1 then
				myMonthCount = rsLeads("myCount")
				xmlLeads = xmlLeads & "<item>"
					xmlLeads = xmlLeads & "<code>0</code>"
					xmlLeads = xmlLeads & "<myMonth>" & left(monthName(myMonth),3) & "</myMonth>"
					xmlLeads = xmlLeads & "<myCount>" & myMonthCount & "</myCount>"
				xmlLeads = xmlLeads & "</item>"
			else
				xmlLeads = xmlLeads & "<item>"
					xmlLeads = xmlLeads & "<code>0</code>"
					xmlLeads = xmlLeads & "<myMonth>" & left(monthName(myMonth),3) & "</myMonth>"
					xmlLeads = xmlLeads & "<myCount>" & 0 & "</myCount>"
				xmlLeads = xmlLeads & "</item>"
			end if
			rsLeads.close
			set rsLeads = nothing
			call TrapIt()
			
		next
		
			xmlLeads = xmlLeads & "</items></response>"
		
	end if
	

	response.write xmlLeads
end sub
	
main()

%>


