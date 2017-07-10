<!--#include virtual="/includes/connection.asp" -->
<!--#include virtual="/includes/errorHandler.asp" -->
<%
   'On Error Resume Next
   
   response.buffer = true

   	dim usr, myType, contactID, sqlContacts
    dim errConnSQL

sub main()
	getFormData
	call processData()
end sub

sub getFormData()
  usr = request.querystring("userid")
  myType = request.querystring("myType")  ' all, single, update
  contactID = request.querystring("contactID")
end sub

sub TrapIt()
	'response.write "TrapIt err: " & err.number & ": " & err.description & "<BR>"
	'response.write "TrapIt error: " & error.number & ": " & error.description & "<BR>"
	If Err.number <> 0 then
  		call TrapError(Err.description, err.number, usr, sqlContacts)
	End If
end sub


sub processData()
	on error resume next
	
   'err.raise 11
   
	set myConnSQL = server.createobject("ADODB.Connection")
	myConnSQL.Open strConnSQL
	call TrapIt()
	
	if myType = "all" then
	
		sqlContacts = "Select ID, First_Name, Last_Name, Company, Title, Address, Address2, City, myState, Zip, Country, Phone, mobile, Email, Email2, Fax, Iata, Notes  from Referrals_Contacts where RefUserID = " & usr & " order by last_name, first_name "
		'response.write sqlContacts & "<BR>"
		set rsContacts = myConnSQL.Execute(sqlContacts)
		call TrapIt()

		xmlContacts = "<?xml version='1.0' encoding='ISO-8859-1' ?><response><items>" '<code>0</code>
		
		While not rsContacts.eof
			id = rsContacts("id")
			first_name = rsContacts("first_name")
			last_name = rsContacts("last_name")
			company = rsContacts("company")
			myTitle = rsContacts("Title")
			address1 = rsContacts("address")
			address2 = rsContacts("address2")
			city = rsContacts("city")
			mystate = rsContacts("mystate")
			zip = rsContacts("zip")
			country = rsContacts("country")
			phone1 = rsContacts("phone")
			mobile = rsContacts("mobile")
			email1 = rsContacts("email")
			email2 = rsContacts("email2")
			fax = rsContacts("fax")
			iata = rsContacts("iata")
			notes = rsContacts("notes")
			
			
			
			'hotel = brand & " - " & property_name & " (" & property_code & ")"
			
			xmlContacts = xmlContacts & "<item>"
				xmlContacts = xmlContacts & "<code>0</code>"
				xmlContacts = xmlContacts & "<id>" & id & "</id>"
				xmlContacts = xmlContacts & "<first_name>" & first_name & "</first_name>"
				xmlContacts = xmlContacts & "<last_name>" & last_name & "</last_name>"
				xmlContacts = xmlContacts & "<company>" & company & "</company>"
				xmlContacts = xmlContacts & "<myTitle>" & myTitle & "</myTitle>"
				xmlContacts = xmlContacts & "<address1>" & address1 & "</address1>"
				xmlContacts = xmlContacts & "<address2>" & address2 & "</address2>"
				xmlContacts = xmlContacts & "<city>" & city & "</city>"
				xmlContacts = xmlContacts & "<state>" & mystate & "</state>"
				xmlContacts = xmlContacts & "<zip>" & zip & "</zip>"
				xmlContacts = xmlContacts & "<country>" & country & "</country>"
				xmlContacts = xmlContacts & "<phone>" & phone1 & "</phone>"
				xmlContacts = xmlContacts & "<mobile>" & mobile & "</mobile>"
				xmlContacts = xmlContacts & "<email1>" & email1 & "</email1>"
				xmlContacts = xmlContacts & "<email2>" & email2 & "</email2>"
				xmlContacts = xmlContacts & "<fax>" & fax & "</fax>"
				xmlContacts = xmlContacts & "<iata>" & iata & "</iata>"
				xmlContacts = xmlContacts & "<notes>" & notes & "</notes>"
			xmlContacts = xmlContacts & "</item>"
		
			rsContacts.movenext
		wend
		if rsContacts.eof and rsContacts.bof then
			xmlContacts = xmlContacts & "<item>"
				xmlContacts = xmlContacts & "<code>0</code>"
				xmlContacts = xmlContacts & "<id>0</id>"
				xmlContacts = xmlContacts & "<first_name></first_name>"
				xmlContacts = xmlContacts & "<last_name></last_name>"
				xmlContacts = xmlContacts & "<company></company>"
				xmlContacts = xmlContacts & "<myTitle></myTitle>"
				xmlContacts = xmlContacts & "<address1></address1>"
				xmlContacts = xmlContacts & "<address2></address2>"
				xmlContacts = xmlContacts & "<city></city>"
				xmlContacts = xmlContacts & "<state></state>"
				xmlContacts = xmlContacts & "<zip></zip>"
				xmlContacts = xmlContacts & "<country></country>"
				xmlContacts = xmlContacts & "<phone1></phone1>"
				xmlContacts = xmlContacts & "<mobile></mobile>"
				xmlContacts = xmlContacts & "<email1></email1>"
				xmlContacts = xmlContacts & "<email2></email2>"
				xmlContacts = xmlContacts & "<fax></fax>"
				xmlContacts = xmlContacts & "<iata></iata>"
				xmlContacts = xmlContacts & "<notes></notes>"
			xmlContacts = xmlContacts & "</item>"
		end if
		rsContacts.close
		set rsContacts = nothing
		call TrapIt()
		
		xmlContacts = xmlContacts & "</items></response>"
	
	
	
	
	elseif myType = "single" then
	
		sqlContacts = "Select ID, First_Name, Last_Name, Company, Title, Address, Address2, City, myState, Zip, Country, Phone, mobile, Email, Email2, Fax, Iata, Notes  from Referrals_Contacts where ID = " & contactID 
		set rsContacts = myConnSQL.Execute(sqlContacts)
		call TrapIt()

		xmlContacts = "<?xml version='1.0' encoding='ISO-8859-1' ?><response><items>"
		
		if not rsContacts.eof then
			'id = rsContacts("id")
			first_name = rsContacts("first_name")
			last_name = rsContacts("last_name")
			company = rsContacts("company")
			myTitle = rsContacts("Title")
			address1 = rsContacts("address")
			address2 = rsContacts("address2")
			city = rsContacts("city")
			mystate = rsContacts("mystate")
			zip = rsContacts("zip")
			country = rsContacts("country")
			phone1 = rsContacts("phone")
			mobile = rsContacts("mobile")
			email1 = rsContacts("email")
			email2 = rsContacts("email2")
			fax = rsContacts("fax")
			iata = rsContacts("iata")
			notes = rsContacts("notes")
			
			xmlContacts = xmlContacts & "<item>"
				xmlContacts = xmlContacts & "<code>0</code>"
				xmlContacts = xmlContacts & "<id>" & contactID & "</id>"
				xmlContacts = xmlContacts & "<first_name>" & first_name & "</first_name>"
				xmlContacts = xmlContacts & "<last_name>" & last_name & "</last_name>"
				xmlContacts = xmlContacts & "<company>" & company & "</company>"
				xmlContacts = xmlContacts & "<myTitle>" & myTitle & "</myTitle>"
				xmlContacts = xmlContacts & "<address1>" & address1 & "</address1>"
				xmlContacts = xmlContacts & "<address2>" & address2 & "</address2>"
				xmlContacts = xmlContacts & "<city>" & city & "</city>"
				xmlContacts = xmlContacts & "<state>" & mystate & "</state>"
				xmlContacts = xmlContacts & "<zip>" & zip & "</zip>"
				xmlContacts = xmlContacts & "<country>" & country & "</country>"
				xmlContacts = xmlContacts & "<phone1>" & phone1 & "</phone1>"
				xmlContacts = xmlContacts & "<mobile>" & mobile & "</mobile>"
				xmlContacts = xmlContacts & "<email1>" & email1 & "</email1>"
				xmlContacts = xmlContacts & "<email2>" & email2 & "</email2>"
				xmlContacts = xmlContacts & "<fax>" & fax & "</fax>"
				xmlContacts = xmlContacts & "<iata>" & iata & "</iata>"
				xmlContacts = xmlContacts & "<notes>" & notes & "</notes>"
			xmlContacts = xmlContacts & "</item>"
		
		else
			xmlContacts = xmlContacts & "<item>"
				xmlContacts = xmlContacts & "<code>0</code>"
				xmlContacts = xmlContacts & "<id>" & contactID & "</id>"
				xmlContacts = xmlContacts & "<first_name></first_name>"
				xmlContacts = xmlContacts & "<last_name></last_name>"
				xmlContacts = xmlContacts & "<company></company>"
				xmlContacts = xmlContacts & "<myTitle></myTitle>"
				xmlContacts = xmlContacts & "<address1></address1>"
				xmlContacts = xmlContacts & "<address2></address2>"
				xmlContacts = xmlContacts & "<city></city>"
				xmlContacts = xmlContacts & "<state></state>"
				xmlContacts = xmlContacts & "<zip></zip>"
				xmlContacts = xmlContacts & "<country></country>"
				xmlContacts = xmlContacts & "<phone1></phone1>"
				xmlContacts = xmlContacts & "<mobile></mobile>"
				xmlContacts = xmlContacts & "<email1></email1>"
				xmlContacts = xmlContacts & "<email2></email2>"
				xmlContacts = xmlContacts & "<fax></fax>"
				xmlContacts = xmlContacts & "<iata></iata>"
				xmlContacts = xmlContacts & "<notes></notes>"
			xmlContacts = xmlContacts & "</item>"
		end if
		rsContacts.close
		set rsContacts = nothing
		call TrapIt()
		
		xmlContacts = xmlContacts & "</items></response>"
	
	
	elseif myType = "update" then
	
	
			'contactID = 1
			
			
			first_name = replace(request.form("first"),"'","")
			last_name = replace(request.form("last"),"'","")
			company = replace(request.form("company"),"'","")
			myTitle = replace(request.form("title"),"'","")
			address1 = replace(request.form("address1"),"'","")
			address2 = replace(request.form("address2"),"'","")
			city = replace(request.form("city"),"'","")
			mystate = request.form("state")
			zip = request.form("zip")
			country = request.form("country")
			phone1 = replace(request.form("phone"),"'","")
			mobile = replace(request.form("mobile"),"'","")
			email1 = replace(request.form("email1"),"'","")
			email2 = replace(request.form("email2"),"'","")
			fax = replace(request.form("fax"),"'","")
			iata = replace(request.form("iata"),"'","")
			notes = replace(request.form("notes"),"'","")
	'response.write "Error2: " & err.description & "<BR>" 

				if contactID <> 0 then  ' Existing contact, so update
					sql = "update Referrals_Contacts "
					sql = sql & " set First_Name = '" & first_Name & "', last_name='" & last_name & "', "
					sql = sql & " Company='" & company & "',Title='" & myTitle & "',address='" & address1 & "', "
					sql = sql & " address2='" & address2 & "',city='" & city & "',mystate='" & mystate & "',"
					sql = sql & " zip='" & zip & "',country='" & country & "',phone='" & phone1 & "',mobile='" & mobile & "', "
					sql = sql & " fax='" & fax & "',email='" & email1 & "',email2='" & email2 & "', "
					sql = sql & "iata='" & iata & "',notes='" & notes & "' where ID = " & contactID
	'response.write contactID & "<BR>" & sql
	'response.end 
					set rsUpdate = myConnSQL.Execute(sql)
					set rsUpdate = nothing
					'call TrapIt()
	'response.write "Update Error: " & err.number & " " & err.description & "<BR>" 
	'response.End()
				else  ' New Contact, so insert
					sql = sql & "Insert into Referrals_Contacts "
					sql = sql & "(RefUserID, First_Name, Last_Name, Company, Title, Address, Address2,"
					sql = sql & "City, myState, Zip, Country, Phone, Mobile, Fax, Email,Email2, IATA, Notes) "
					sql = sql & "Values "
					sql = sql & "(" & usr & ",'" & first_Name & "','" & last_name & "','" & company & "',"
					sql = sql & "'" & myTitle & "','" & address1 & "','" & address2 & "','" & city & "','" & myState & "',"
					sql = sql & "'" & zip & "','" & country & "','" & phone1 & "','" & mobile & "','" & fax & "','" & email1 & "','" & email2 & "','" & iata & "','" & notes & "') " ';
	'response.write contactID & "<BR>" & sql
	'response.end 
					set rsUpdate = myConnSQL.Execute(sql)
					set rsUpdate = nothing
					'call TrapIt()
	'response.write "Insert Error: " & err.description & "<BR>" 
				end if

				xmlContacts = "<?xml version='1.0' encoding='ISO-8859-1' ?><response><items><item>"
				xmlContacts = xmlContacts & "<code>0</code>"
				xmlContacts = xmlContacts & "</item></items></response>"
				
	elseif myType = "delete" then
		sql = "delete from Referrals_Contacts where ID = " & contactID
		set rsUpdate = myConnSQL.Execute(sql)
		set rsUpdate = nothing
		'call TrapIt()
		
				xmlContacts = "<?xml version='1.0' encoding='ISO-8859-1' ?><response><items><item>"
				xmlContacts = xmlContacts & "<code>0</code>"
				xmlContacts = xmlContacts & "</item></items></response>"
				
	end if
		
		

	response.write xmlContacts
end sub
	
main()

%>


