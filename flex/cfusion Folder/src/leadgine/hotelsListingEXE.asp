<!--#include virtual="/includes/connection.asp" -->
<!--#include virtual="/includes/errorHandler.asp" -->
<%
   'On Error Resume Next
   
   response.buffer = true

   	dim clientid, sqlHotels
   
   'err.raise 11

sub main()
	getFormData
	call processData()
end sub

sub getFormData()
  clientid = request.querystring("clientid")
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
	
		sqlHotels = "Select property_ID, brand, property_name, property_code, address1, address2, city, mystate, zip, country, description, lat_coordinates, long_coordinates, photo from Properties where Client_ID = " & clientid & " and inactive=0 order by brand, property_name "
		set rsHotels = myConnSQL.Execute(sqlHotels)
	
		call TrapIt()

		xmlHotels = "<?xml version='1.0' encoding='ISO-8859-1' ?><response><items>"
		xmlHotels = xmlHotels & "<hotels>"
		
				if not rsHotels.eof then
					xmlHotels = xmlHotels & "<myState id='" & rsHotels("myState") & "'>"
					xmlHotels = xmlHotels & "<brand id='" & rsHotels("brand") & "'>"
				end if
				while not rsHotels.eof
					brand = rsHotels("brand")
					myState = rsHotels("mystate")
					hotelName = rsHotels("brand") & " - " & rsHotels("Property_Name") & " (" & rsHotels("Property_Code") & "), " & rsHotels("City") & ", " & rsHotels("mystate")
					
					xmlHotels = xmlHotels & "<hotel>"
						xmlHotels = xmlHotels & "<hotelID>" & rsHotels("Property_id") & "</hotelID>"
						xmlHotels = xmlHotels & "<hotelName>" & hotelName & "</hotelName>"
					xmlHotels = xmlHotels & "</hotel>"
					
					rsHotels.movenext
					
					if not rsHotels.eof then
						if rsHotels("brand") <> brand then
							if rsHotels("myState") <> myState then
								xmlHotels = xmlHotels & "</brand></myState><myState id='" & rsHotels("myState") & "'><brand id='" & rsHotels("brand") & "'>"
								myState = rsHotels("myState")
							else
								xmlHotels = xmlHotels & "</brand><brand id='" & rsHotels("brand") & "'>"
							end if
							brand = rsHotels("brand")
						end if
						if rsHotels("myState") <> myState then
							xmlHotels = xmlHotels & "</brand></myState><myState id='" & rsHotels("myState") & "'><brand id='" & rsHotels("brand") & "'>"
							myState = rsHotels("myState")
						end if
					else
							xmlHotels = xmlHotels & "</brand></myState>"
					end if
				wend
				rsHotels.close
				set rsHotels = nothing
							
				xmlHotels = xmlHotels & "</hotels>"


		call TrapIt()
		
		xmlHotels = xmlHotels & "</items></response>"
		
		
		

	response.write xmlHotels
end sub
	
main()

%>


