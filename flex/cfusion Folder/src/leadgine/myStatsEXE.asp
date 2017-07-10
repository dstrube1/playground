<!--#include virtual="/includes/connection.asp" -->
<!--#include virtual="/includes/errorHandler.asp" -->
<%
   'On Error Resume Next
   
   response.buffer = true

   dim usr, myType,refhotel, clientid, sqlLeads
   
   'err.raise 11

sub main()
	getFormData
	call processData()
end sub

sub getFormData()
  usr = request.querystring("userid")
  refhotel = request.querystring("refhotel")
  clientid = request.querystring("clientID")
  'if usr = "" then usr = 1
  myType = request.querystring("myType")  ' hotel, company, or system
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
	
	if myType = "hotel" then

		xmlLeads = "<?xml version='1.0' encoding='ISO-8859-1' ?><response><items>"
		
		for x = 11 to 0 step -1
			myMonth = month(dateadd("m",-x,now())) 
			myYear = year(dateadd("m",-x,now()))
						
			sqlLeads = "Select Count(ID) as myCount from Referrals where RefUserID = " & usr & " and month(sent_date)=" & myMonth & " and year(sent_date)=" & myYear
			set rsLeads = myConnSQL.Execute(sqlLeads)
			call TrapIt()
			
			if not rsLeads.eof and vartype(rsLeads(0)) <> 1 then
				myMonthCount = rsLeads("myCount")
			else
				myMonthCount = 0
			end if

			rsLeads.close
			set rsLeads = nothing
			call TrapIt()
						
			sqlLeads = "Select count(distinct(refuserid)) as users, Count(ID) as myCount from Referrals where month(sent_date)=" & myMonth & " and year(sent_date)=" & myYear & " and refhotel = '" & refhotel & "' group by refuserid "
			set rsLeads = myConnSQL.Execute(sqlLeads)
			call TrapIt()
			
			if not rsLeads.eof and vartype(rsLeads(0)) <> 1 then
				hotelCount = rsLeads("myCount")
				hotelUsers = rsLeads("users")
				if hotelUsers<>0 then
					hotelAvg = hotelCount/hotelUsers
				else
					hotelAvg = 0
				end if
			else
				hotelCount = 0
				hotelUsers = 1
				hotelAvg = 0
			end if

			rsLeads.close
			set rsLeads = nothing
			call TrapIt()

			
				xmlLeads = xmlLeads & "<item>"
					xmlLeads = xmlLeads & "<code>0</code>"
					xmlLeads = xmlLeads & "<myMonth>" & left(monthName(myMonth),3) & "</myMonth>"
					xmlLeads = xmlLeads & "<myCount>" & myMonthCount & "</myCount>"
					xmlLeads = xmlLeads & "<avg>" & hotelAvg & "</avg>"
				xmlLeads = xmlLeads & "</item>"

			
		next
		
			xmlLeads = xmlLeads & "</items></response>"
			
			
			
			
			
			
	elseif myType = "company" then
'if clientid="" then clientid = 1
		xmlLeads = "<?xml version='1.0' encoding='ISO-8859-1' ?><response><items>"
		
		for x = 11 to 0 step -1
			myMonth = month(dateadd("m",-x,now())) 
			myYear = year(dateadd("m",-x,now()))
						
			sqlLeads = "Select Count(ID) as myCount from Referrals where RefUserID = " & usr & " and month(sent_date)=" & myMonth & " and year(sent_date)=" & myYear
			set rsLeads = myConnSQL.Execute(sqlLeads)
			call TrapIt()
			
			if not rsLeads.eof and vartype(rsLeads(0)) <> 1 then
				myMonthCount = rsLeads("myCount")
			else
				myMonthCount = 0
			end if

			rsLeads.close
			set rsLeads = nothing
			call TrapIt()
						
			sqlLeads = "Select count(distinct(refuserid)) as users, Count(ID) as myCount from Referrals, Properties where Referrals.RefHotel = Properties.Property_Code and Properties.Client_ID = " & clientid & " and month(sent_date)=" & myMonth & " and year(sent_date)=" & myYear & " group by refuserid "
			'response.write sqlLeads
			'response.end
			set rsLeads = myConnSQL.Execute(sqlLeads)
			call TrapIt()
			
			if not rsLeads.eof and vartype(rsLeads(0)) <> 1 then
				hotelCount = rsLeads("myCount")
				hotelUsers = rsLeads("users")
				if hotelUsers<>0 then
					hotelAvg = hotelCount/hotelUsers
				else
					hotelAvg = 0
				end if
			else
				hotelCount = 0
				hotelUsers = 1
				hotelAvg = 0
			end if

			rsLeads.close
			set rsLeads = nothing
			call TrapIt()

			
				xmlLeads = xmlLeads & "<item>"
					xmlLeads = xmlLeads & "<code>0</code>"
					xmlLeads = xmlLeads & "<myMonth>" & left(monthName(myMonth),3) & "</myMonth>"
					xmlLeads = xmlLeads & "<myCount>" & myMonthCount & "</myCount>"
					xmlLeads = xmlLeads & "<avg>" & hotelAvg & "</avg>"
				xmlLeads = xmlLeads & "</item>"

			
		next
		
			xmlLeads = xmlLeads & "</items></response>"
		
		
		
		
	elseif myType = "system" then

		xmlLeads = "<?xml version='1.0' encoding='ISO-8859-1' ?><response><items>"
		
		for x = 11 to 0 step -1
			myMonth = month(dateadd("m",-x,now())) 
			myYear = year(dateadd("m",-x,now()))
						
			sqlLeads = "Select Count(ID) as myCount from Referrals where RefUserID = " & usr & " and month(sent_date)=" & myMonth & " and year(sent_date)=" & myYear
			set rsLeads = myConnSQL.Execute(sqlLeads)
			call TrapIt()
			
			if not rsLeads.eof and vartype(rsLeads(0)) <> 1 then
				myMonthCount = rsLeads("myCount")
			else
				myMonthCount = 0
			end if

			rsLeads.close
			set rsLeads = nothing
			call TrapIt()
						
			sqlLeads = "Select count(distinct(refuserid)) as users, Count(ID) as myCount from Referrals where month(sent_date)=" & myMonth & " and year(sent_date)=" & myYear & " group by refuserid "
			set rsLeads = myConnSQL.Execute(sqlLeads)
			call TrapIt()
			
			if not rsLeads.eof and vartype(rsLeads(0)) <> 1 then
				hotelCount = rsLeads("myCount")
				hotelUsers = rsLeads("users")
				if hotelUsers<>0 then
					hotelAvg = hotelCount/hotelUsers
				else
					hotelAvg = 0
				end if
			else
				hotelCount = 0
				hotelUsers = 1
				hotelAvg = 0
			end if

			rsLeads.close
			set rsLeads = nothing
			call TrapIt()

			
				xmlLeads = xmlLeads & "<item>"
					xmlLeads = xmlLeads & "<code>0</code>"
					xmlLeads = xmlLeads & "<myMonth>" & left(monthName(myMonth),3) & "</myMonth>"
					xmlLeads = xmlLeads & "<myCount>" & myMonthCount & "</myCount>"
					xmlLeads = xmlLeads & "<avg>" & hotelAvg & "</avg>"
				xmlLeads = xmlLeads & "</item>"

			
		next
		
			xmlLeads = xmlLeads & "</items></response>"
		
	end if
	

	response.write xmlLeads
end sub
	
main()

%>


