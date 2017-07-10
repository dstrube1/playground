<!--#include virtual="/includes/connection.asp" -->
<!--#include virtual="/includes/errorHandler.asp" -->
<%
   'On Error Resume Next
   
   response.buffer = true

   	dim clientid, sqlHotels, usr, hotel
   
   'err.raise 11

sub main()
	getFormData
	call processData()
end sub

sub getFormData()
  clientid = request.querystring("clientid")
  usr = request.querystring("userid")
  hotel = request.querystring("hotel")
  'if clientid = "" then clientid = 1
end sub

sub TrapIt()
	If Err.number <> 0 then
  		call TrapError(Err.description, err.number, usr, sqlHotels)
	End If
end sub


sub processData()
	on error resume next

	set myConnSQL = server.createobject("ADODB.Connection")
	myConnSQL.Open strConnSQL
	call TrapIt()

		xmlHotels = "<?xml version='1.0' encoding='ISO-8859-1' ?><response><items>"

		sqlMyHotel = "Select property_ID, brand, property_name, property_code, address1, address2, city, mystate, zip, country, description, lat_coordinates, long_coordinates, photo from Properties where Property_ID = " & hotel & " and inactive=0 order by brand, property_name "
		set rsMyHotel = myConnSQL.Execute(sqlMyHotel)
		if not rsMyHotel.eof then
			id = rsMyHotel("property_id")
			brand = rsMyHotel("brand")
			property_name = rsMyHotel("property_name")
			property_code = rsMyHotel("property_code")
			address1 = rsMyHotel("address1")
			address2 = rsMyHotel("address2")
			city = rsMyHotel("city")
			mystate = rsMyHotel("mystate")
			zip = rsMyHotel("zip")
			country = rsMyHotel("country")
			descr = rsMyHotel("description")
			lat = rsMyHotel("lat_coordinates")
			lon = rsMyHotel("long_coordinates")
			photo = rsMyHotel("photo")
			
			xmlHotels = xmlHotels & "<item>"
				xmlHotels = xmlHotels & "<code>0</code>"
				xmlHotels = xmlHotels & "<id>" & id & "</id>"
				xmlHotels = xmlHotels & "<brand>" & brand & "</brand>"
				xmlHotels = xmlHotels & "<property_name>" & property_name & "</property_name>"
				xmlHotels = xmlHotels & "<property_code>" & property_code & "</property_code>"
				xmlHotels = xmlHotels & "<address1>" & address1 & "</address1>"
				xmlHotels = xmlHotels & "<address2>" & address2 & "</address2>"
				xmlHotels = xmlHotels & "<city>" & city & "</city>"
				xmlHotels = xmlHotels & "<state>" & mystate & "</state>"
				xmlHotels = xmlHotels & "<zip>" & zip & "</zip>"
				xmlHotels = xmlHotels & "<country>" & country & "</country>"
				xmlHotels = xmlHotels & "<description>" & descr & "</description>"
				xmlHotels = xmlHotels & "<lat_coordinates>" & lat & "</lat_coordinates>"
				xmlHotels = xmlHotels & "<long_coordinates>" & lon & "</long_coordinates>"
				xmlHotels = xmlHotels & "<photo>" & photo & "</photo>"
			xmlHotels = xmlHotels & "</item>"
		end if
		rsMyHotel.close
		set rsMyHotel = nothing
		
		
		sqlHotels = "Select property_ID, brand, property_name, property_code, address1, address2, city, mystate, zip, country, description, lat_coordinates, long_coordinates, photo from Properties where Client_ID = " & clientid & " and Property_ID <> " & hotel & " and inactive=0 and myState='GA' order by brand, property_name "
		set rsHotels = myConnSQL.Execute(sqlHotels)
	
		call TrapIt()
		
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
			
			'hotel = brand & " - " & property_name & " (" & property_code & ")"
			
			xmlHotels = xmlHotels & "<item>"
				xmlHotels = xmlHotels & "<code>0</code>"
				xmlHotels = xmlHotels & "<id>" & id & "</id>"
				xmlHotels = xmlHotels & "<brand>" & brand & "</brand>"
				xmlHotels = xmlHotels & "<property_name>" & property_name & "</property_name>"
				xmlHotels = xmlHotels & "<property_code>" & property_code & "</property_code>"
				xmlHotels = xmlHotels & "<address1>" & address1 & "</address1>"
				xmlHotels = xmlHotels & "<address2>" & address2 & "</address2>"
				xmlHotels = xmlHotels & "<city>" & city & "</city>"
				xmlHotels = xmlHotels & "<state>" & mystate & "</state>"
				xmlHotels = xmlHotels & "<zip>" & zip & "</zip>"
				xmlHotels = xmlHotels & "<country>" & country & "</country>"
				xmlHotels = xmlHotels & "<description>" & descr & "</description>"
				xmlHotels = xmlHotels & "<lat_coordinates>" & lat & "</lat_coordinates>"
				xmlHotels = xmlHotels & "<long_coordinates>" & lon & "</long_coordinates>"
				xmlHotels = xmlHotels & "<photo>" & photo & "</photo>"
			xmlHotels = xmlHotels & "</item>"
		
			rsHotels.movenext
		wend
		if rsHotels.eof and rsHotels.bof then
			xmlHotels = xmlHotels & "<item>"
				xmlHotels = xmlHotels & "<code>0</code>"
				xmlHotels = xmlHotels & "<id>0</id>"
				xmlHotels = xmlHotels & "<brand></brand>"
				xmlHotels = xmlHotels & "<property_name></property_name>"
				xmlHotels = xmlHotels & "<property_code></property_code>"
				xmlHotels = xmlHotels & "<address1></address1>"
				xmlHotels = xmlHotels & "<address2></address2>"
				xmlHotels = xmlHotels & "<city></city>"
				xmlHotels = xmlHotels & "<state></state>"
				xmlHotels = xmlHotels & "<zip></zip>"
				xmlHotels = xmlHotels & "<country></country>"
				xmlHotels = xmlHotels & "<description></description>"
				xmlHotels = xmlHotels & "<lat_coordinates></lat_coordinates>"
				xmlHotels = xmlHotels & "<long_coordinates></long_coordinates>"
				xmlHotels = xmlHotels & "<photo></photo>"
			xmlHotels = xmlHotels & "</item>"
		end if
		rsHotels.close
		set rsHotels = nothing
		call TrapIt()
		
		xmlHotels = xmlHotels & "</items></response>"
		
		
		

	response.write xmlHotels
end sub
	
main()

%>


