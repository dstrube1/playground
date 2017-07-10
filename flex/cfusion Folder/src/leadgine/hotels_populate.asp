<!--#include file="../includes/connection.asp" -->

<%
response.buffer = true

set myConnSQL = server.createobject("ADODB.Connection")
myConnSQL.Open strConnSQL

Set Conn2 = Server.CreateObject("ADODB.Connection")
conn2.open "DSN=historytext" '*** USE THIS TYPE OF DATA CONNECTION FOR CSV FILES (HP2) ***

'88888888888888888 CHANGE TO APPROPRIATE FILENAME IN CSV FORMAT 8888888888888888
SQL = "Select * from [rmh_hotels4.csv] " 
'8888888888888888888888888888888888888888888888888888888888888888888888888888888

Set RS = Conn2.Execute(SQL)
for i = 1 to 1
	'rs.movenext
next 
dim loc
response.write "<h1>Actuals</h1>"
response.write "<table border=1>"
response.write "<tr><td>Location Number</td><td>Hotel Name</td></tr>"
i=1
while not rs.eof 'vartype(rs(1)) <> 1 '
	inn = rs(1)
	brand = rs(0)
	rooms = rs(5)
	hotel = replace(rs(2),"'","")
	hotel = replace(hotel,"/","")
	hotel = replace(hotel,"&","and")
	
	address = rs(14)
	address = replace(address,"/","")
	address = replace(address,"'","")
	address = replace(address,"&","and")

	city = rs(15)
	city = replace(city,"/","")
	city = replace(city,"'","")
	
	mystate = rs(16)
	zip = rs(17)
	phone = rs(18)
	'fax = rs(18)
	
	country = "US"
	inactive=0
	mgmt = rs(6)
	if mgmt <> "" then
		mgmt = replace(mgmt,"'","`")
	end if
			sqlSearch = "select * from Properties where Property_Code = '" & inn & "' "
			set rsSearch = myConnSQL.Execute(sqlSearch)
			if rsSearch.eof then
				sqlUpdate = "Insert into Properties (Property_Code,Brand,Property_Name,Address1,City,myState,Zip,Phone,Country,Rooms,Inactive) "
				sqlUpdate = sqlUpdate & " Values ('" & inn & "','" & brand & "','" & hotel & "','" & address & "','" & city & "','" & mystate & "','" & zip & "','" & phone & "','" & country & "'," & rooms & ",0) "
'88888888888888888888888888  UNCOMMENT BELOW WHEN READY TO UPDATE 88888888888888888888888
			set rsUpdate = myConnSQL.Execute(sqlUpdate)
			set rsUpdate = nothing
'8888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
			
			else
				sqlUpdate = "Update Properties set Brand='" & brand & "', property_name='" & hotel & "', Address1 = '" & address & "',City = '" & city & "',myState = '" & mystate & "', Zip = '" & zip & "',Phone = '" & phone & "' where Property_code = '" & inn & "' "
				
'88888888888888888888888888  UNCOMMENT BELOW WHEN READY TO UPDATE 88888888888888888888888
			set rsUpdate = myConnSQL.Execute(sqlUpdate)
			set rsUpdate = nothing
'8888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
			
			
			end if
			rsSearch.close
			set rsSearch = nothing
			response.write "<tr><td>" & inn & "</td><td>" & hotel & "</td></tr>"
			
		
	rs.movenext
wend
response.write "</table>"
response.end












































	set myConnSQL = server.createobject("ADODB.Connection")
	myConnSQL.Open strConnSQL
	
	set myConnSQL2 = server.createobject("ADODB.Connection")
	myConnSQL2.Open strConnSQL2
	
		sqlHotels = "Select property_ID, brand, property_name, property_code, address1, address2, city, mystate, zip, country, description, lat_coordinates, long_coordinates, photo from Properties where Client_ID = " & clientid & " order by brand, property_name "
		set rsHotels = myConnSQL.Execute(sqlHotels)
		
		While not rsHotels.eof
			id = rsHotels("property_id")
			brand = rsHotels("brand")
			property_name = rsHotels("property_name")
			property_code = rsHotels("property_code")
			address1 = rsHotels("address1")
			address2 = rsHotels("address2")
			city = rsHotels("city")
			mystate = rsHotels("mystate")
			zip = rsHotels("zip")
			country = rsHotels("country")
			descr = rsHotels("description")
			lat = rsHotels("lat_coordinates")
			lon = rsHotels("long_coordinates")
			photo = rsHotels("photo")
			
		
			rsHotels.movenext
		wend
		rsHotels.close
		set rsHotels = nothing

%>


