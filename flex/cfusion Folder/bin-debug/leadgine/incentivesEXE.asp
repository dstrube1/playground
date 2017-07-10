<!--#include virtual="/includes/connection.asp" -->
<!--#include virtual="/includes/errorHandler.asp" -->
<%
   'On Error Resume Next
   
   response.buffer = true

   	dim usr, myType, hotel, clientID, sql
   
   'err.raise 11

sub main()
	getFormData
	call processData()
end sub

sub getFormData()
  usr = request.querystring("userid")
  hotel = request.querystring("hotel")
  clientID = request.querystring("clientid")
  myType = request.querystring("myType")    ' myHotel, otherHotels, update, deactivate
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
	
	if myType = "myHotel" then
	
		sql = "select id, incentive_name, incentive, incentive_desc, from_date, to_date, Summary, Qualify, "
		sql = sql & " properties.brand, properties.property_name, properties.city, properties.mystate "
		sql = sql & " from referrals_incentives, properties where properties.property_id = referrals_incentives.property_id and referrals_incentives.property_ID=" & hotel & " and referrals_incentives.inactive=0 "
		set rs = myConnSQL.Execute(sql)
		call TrapIt()

		xml = "<?xml version='1.0' encoding='ISO-8859-1' ?><response><items>"
		While not rs.eof
			id = rs("id")
			incentive_name = rs("incentive_name")
			incentive = rs("incentive")
			incentive_desc = rs("incentive_desc")
			hotel = rs("brand") & " - " & rs("property_name") & ", " & rs("city") & ", " & rs("mystate")
			from_date = rs("from_date")
			to_date = rs("to_date")
			Summary = rs("Summary")
			Qualify = rs("Qualify")
			
			xml = xml & "<item>"
				xml = xml & "<code>0</code>"
				xml = xml & "<id>" & id & "</id>"
				xml = xml & "<incentive_name>" & incentive_name & "</incentive_name>"
				xml = xml & "<incentive>" & incentive & "</incentive>"
				xml = xml & "<incentive_desc>" & incentive_desc & "</incentive_desc>"
				xml = xml & "<hotel>" & hotel & "</hotel>"
				xml = xml & "<from_date>" & from_date & "</from_date>"
				xml = xml & "<to_date>" & to_date & "</to_date>"
				xml = xml & "<summary>" & Summary & "</summary>"
				xml = xml & "<qualify>" & Qualify & "</qualify>"
			xml = xml & "</item>"
		
			rs.movenext
		wend
		if rs.eof and rs.bof then
			xml = xml & "<item>"
				xml = xml & "<code>0</code>"
				xml = xml & "<id></id>"
				xml = xml & "<incentive_name></incentive_name>"
				xml = xml & "<incentive></incentive>"
				xml = xml & "<incentive_desc></incentive_desc>"
				xml = xml & "<hotel></hotel>"
				xml = xml & "<from_date></from_date>"
				xml = xml & "<to_date></to_date>"
				xml = xml & "<summary></summary>"
				xml = xml & "<qualify></qualify>"
			xml = xml & "</item>"
		end if
		rs.close
		set rs = nothing
		call TrapIt()
		
		xml = xml & "</items></response>"

	response.write xml
	
	elseif myType = "otherHotels" then
	
		sql = "select id, incentive_name, incentive, incentive_desc, from_date, to_date, Summary, Qualify, "
		sql = sql & " properties.brand, properties.property_name, properties.city, properties.mystate "
		sql = sql & " from referrals_incentives, properties where properties.property_id = referrals_incentives.property_id and referrals_incentives.property_ID <> " & hotel & " and properties.client_id=" & clientID & " and referrals_incentives.inactive=0 and properties.inactive=0 "
		set rs = myConnSQL.Execute(sql)
		call TrapIt()

		xml = "<?xml version='1.0' encoding='ISO-8859-1' ?><response><items>"
		While not rs.eof
			id = rs("id")
			incentive_name = rs("incentive_name")
			incentive = rs("incentive")
			incentive_desc = rs("incentive_desc")
			hotel = rs("brand") & " - " & rs("property_name") & ", " & rs("city") & ", " & rs("mystate")
			from_date = rs("from_date")
			to_date = rs("to_date")
			Summary = rs("Summary")
			Qualify = rs("Qualify")
			
			xml = xml & "<item>"
				xml = xml & "<code>0</code>"
				xml = xml & "<id>" & id & "</id>"
				xml = xml & "<incentive_name>" & incentive_name & "</incentive_name>"
				xml = xml & "<incentive>" & incentive & "</incentive>"
				xml = xml & "<incentive_desc>" & incentive_desc & "</incentive_desc>"
				xml = xml & "<hotel>" & hotel & "</hotel>"
				xml = xml & "<from_date>" & from_date & "</from_date>"
				xml = xml & "<to_date>" & to_date & "</to_date>"
				xml = xml & "<summary>" & Summary & "</summary>"
				xml = xml & "<qualify>" & Qualify & "</qualify>"
			xml = xml & "</item>"
		
			rs.movenext
		wend
		if rs.eof and rs.bof then
			xml = xml & "<item>"
				xml = xml & "<code>0</code>"
				xml = xml & "<id></id>"
				xml = xml & "<incentive_name></incentive_name>"
				xml = xml & "<incentive></incentive>"
				xml = xml & "<incentive_desc></incentive_desc>"
				xml = xml & "<hotel></hotel>"
				xml = xml & "<from_date></from_date>"
				xml = xml & "<to_date></to_date>"
				xml = xml & "<summary></summary>"
				xml = xml & "<qualify></qualify>"
			xml = xml & "</item>"
		end if
		rs.close
		set rs = nothing
		call TrapIt()
		
		xml = xml & "</items></response>"

	response.write xml
	
	elseif myType = "update" then
			id = request.querystring("id")
			incentive_name = replace(request.form("incentive_name"),"'","")
			incentive = request.form("incentive")
			incentive_desc = replace(request.form("incentive_desc"),"'","")
			from_date = request.form("from_date")
			to_date = request.form("to_date")
			summary = replace(request.form("summary"),"'","")
			qualify = replace(request.form("qualify"),"'","")
	'response.write "Error2: " & err.description & "<BR>" 

			if id <> 0 then  ' Existing incentive, so update
				sql = "update Referrals_Incentives "
				sql = sql & " set incentive_name = '" & incentive_name & "', incentive=" & incentive & ", "
				sql = sql & " incentive_desc='" & incentive_desc & "',from_date='" & from_date & "',to_date='" & to_date & "', "
				sql = sql & " summary='" & summary & "',qualify='" & qualify & "',User_ID=" & usr & ", Submitted='" & now() & "' "
				sql = sql & " where ID = " & ID
'response.write contactID & "<BR>" & sql
'response.end 
				set rsUpdate = myConnSQL.Execute(sql)
				set rsUpdate = nothing
				call TrapIt()
'response.write "Update Error: " & err.number & " " & err.description & "<BR>" 
'response.End()
			else  ' New Incentive, so insert
				sql = sql & "Insert into Referrals_Incentives "
				sql = sql & "(Incentive_name, Incentive, Incentive_Desc, from_date, To_Date, Summary, Qualify,"
				sql = sql & "User_ID, Property_ID) "
				sql = sql & "Values "
				sql = sql & "('" & incentive_name & "','" & incentive & "','" & incentive_desc & "','" & from_date & "',"
				sql = sql & "'" & to_date & "','" & summary & "','" & qualify & "'," & usr & "," & hotel & ") " 
				set rsUpdate = myConnSQL.Execute(sql)
				set rsUpdate = nothing
				call TrapIt()
			end if

				xml = "<?xml version='1.0' encoding='ISO-8859-1' ?> <response><items><item>"
				xml = xml & "<code>0</code>"
				xml = xml & "</item></items></response>"
				
		response.write xml
	
	elseif myType = "deactivate" then
			id = request.form("id")

			sql = "update Referrals_Incentives "
			sql = sql & " set inactive = 1 "
			sql = sql & " where ID = " & ID

			set rsUpdate = myConnSQL.Execute(sql)
			set rsUpdate = nothing

				xml = "<?xml version='1.0' encoding='ISO-8859-1' ?> <response><items><item>"
				xml = xml & "<code>0</code>"
				xml = xml & "</item></items></response>"
		
		response.write xml

	end if
	
end sub
	
main()

%>


