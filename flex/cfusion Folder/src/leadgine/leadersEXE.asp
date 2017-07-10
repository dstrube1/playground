<!--#include virtual="/includes/connection.asp" -->
<!--#include virtual="/includes/errorHandler.asp" -->
<%
   'On Error Resume Next
   
   response.buffer = true

   	dim usr, myType, clientID, sql
   
   'err.raise 11

sub main()
	getFormData
	call processData()
end sub

sub getFormData()
  usr = request.querystring("userID")
  clientID = request.querystring("clientID")
  myType = request.querystring("myType")    ' thisMonth, thisQuarter, thisYear
end sub

sub TrapIt()
	If Err.number <> 0 then
  		call TrapError(Err.description, err.number, usr, sql)
	End If
end sub


sub processData()
	on error resume next

	set myConnSQL = server.createobject("ADODB.Connection")
	myConnSQL.Open strConnSQL
	call TrapIt()
	
	if myType = "thisMonth" then
	
		sql = "select top 3 users.user_id, users.first_name, users.last_name,users.title, properties.property_id, properties.brand, properties.property_name, properties.city, properties.mystate, count(referrals.id) as myCount, sum(referrals.totalrooms) as rooms, sum(referrals.rmRevenue+referrals.cateringrevenue+referrals.rentalrevenue) as revenue from referrals, properties, users where referrals.refuserid=users.user_id and referrals.refhotel=properties.property_id and users.Property_id = properties.property_id and properties.client_id=" & clientID & " and month(sent_Date)=" & month(now()) & " and year(sent_Date)=" & year(now()) & " group by users.user_id, users.first_name, users.last_name, users.last_name,users.title, properties.property_id, properties.brand, properties.property_name, properties.city, properties.mystate order by myCount desc "
		
	elseif myType = "thisQuarter" then
	
	
		myMonth = month(now())
		if myMonth >=1 and myMonth <=3 then
			qMonth1 = 1
			qMonth2 = 3
		elseif myMonth >=4 and myMonth <=6 then
			qMonth1 = 4
			qMonth2 = 6
		elseif myMonth >=7 and myMonth <=9 then
			qMonth1 = 7
			qMonth2 = 9
		elseif myMonth >=10 and myMonth <=12 then
			qMonth1 = 10
			qMonth2 = 12
		end if

		sql = "select top 3 users.user_id, users.first_name, users.last_name,users.title, properties.property_id, properties.brand, properties.property_name, properties.city, properties.mystate, count(referrals.id) as myCount, sum(referrals.totalrooms) as rooms, sum(referrals.rmRevenue+referrals.cateringrevenue+referrals.rentalrevenue) as revenue from referrals, properties, users where referrals.refuserid=users.user_id and referrals.refhotel=properties.property_id and users.Property_id = properties.property_id and properties.client_id=" & clientID & " and month(sent_Date)>=" & qMonth1 & " and month(sent_Date)<=" & qMonth2 & " and year(sent_Date)=" & year(now()) & " group by users.user_id, users.first_name, users.last_name, users.last_name,users.title, properties.property_id, properties.brand, properties.property_name, properties.city, properties.mystate order by myCount desc "
	
	
	elseif myType = "thisYear" then
	
		sql = "select top 3 users.user_id, users.first_name, users.last_name,users.title, properties.property_id, properties.brand, properties.property_name, properties.city, properties.mystate, count(referrals.id) as myCount, sum(referrals.totalrooms) as rooms, sum(referrals.rmRevenue+referrals.cateringrevenue+referrals.rentalrevenue) as revenue from referrals, properties, users where referrals.refuserid=users.user_id and referrals.refhotel=properties.property_id and users.Property_id = properties.property_id and properties.client_id=" & clientID & " and year(sent_Date)=" & year(now()) & " group by users.user_id, users.first_name, users.last_name, users.last_name,users.title, properties.property_id, properties.brand, properties.property_name, properties.city, properties.mystate order by myCount desc "
	
	end if
	
		set rs = myConnSQL.Execute(sql)
	
		call TrapIt()

		xml = "<?xml version='1.0' encoding='ISO-8859-1' ?><response><items>"
		
		rank = 0 
		
		While not rs.eof
			rank = rank + 1
			id = rs("property_id")
			first_name = rs("first_name")
			last_name = rs("last_name")
			myTitle = rs("Title")
			hotel = rs("brand") & " - " & rs("property_name") & ", " & rs("city") & ", " & rs("mystate")
			myCount = rs("myCount")
			rooms = rs("rooms")
			revenue = rs("revenue")
			
			xml = xml & "<item>"
				xml = xml & "<code>0</code>"
				xml = xml & "<rank>" & rank & "</rank>"
				xml = xml & "<userid>" & userid & "</userid>"
				xml = xml & "<first_name>" & first_name & "</first_name>"
				xml = xml & "<last_name>" & last_name & "</last_name>"
				xml = xml & "<myTitle>" & myTitle & "</myTitle>"
				xml = xml & "<hotel>" & hotel & "</hotel>"
				xml = xml & "<referrals>" & myCount & "</referrals>"
				xml = xml & "<rooms>" & rooms & "</rooms>"
				xml = xml & "<revenue>" & revenue & "</revenue>"
			xml = xml & "</item>"
		
			rs.movenext
		wend
		if rs.eof and rs.bof then
			xml = xml & "<item>"
				xml = xml & "<code>0</code>"
				xml = xml & "<rank></rank>"
				xml = xml & "<userid></userid>"
				xml = xml & "<first_name></first_name>"
				xml = xml & "<last_name></last_name>"
				xml = xml & "<myTitle></myTitle>"
				xml = xml & "<hotel></hotel>"
				xml = xml & "<referrals></referrals>"
				xml = xml & "<rooms></rooms>"
				xml = xml & "<revenue></revenue>"
			xml = xml & "</item>"
		end if
		rs.close
		set rs = nothing
		call TrapIt()
		
		xml = xml & "</items></response>"

	response.write xml
end sub
	
main()

%>


