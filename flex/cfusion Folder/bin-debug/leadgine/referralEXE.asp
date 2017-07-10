<!--#include virtual="/includes/connection.asp" -->
<!--#include virtual="/includes/errorHandler.asp" -->
<%
   'On Error Resume Next
   
   response.buffer = true

   dim company, evt, usr, refhotel, estNum, firstname, lastname, contactTitle, address, address2, city, mystate, country, zipcode, emailAddress
   dim phone, fax, estDecisionDate, commissionable, commPercent, iata, estRate, referralType, startDate, numDays
   dim mysingle, mydouble, totalrms, totalrmrev, comments, requests
   dim myDate, singleRooms, doubleRooms, contactID
   dim starttime, endtime, functiontype, ppl, setup, fbcomments
   dim hotels
   dim rs, sql
   
   'err.raise 11

sub main()
	getFormData
	call processData()
end sub

sub getFormData()

	contactID=request.QueryString("contactID")
	if contactID <> "" then
		contactID = cdbl(contactID)  ' This means this is an existing contact, so update
	else
		contactID = 0  ' This means that this is a new contact that must be inserted into db
	end if

	company=request.QueryString("org")
	evt=request.QueryString("evt")
	usr=request.QueryString("userid")
	refhotel=request.QueryString("refhotel")
	estNum=request.QueryString("estNum")
	firstname=request.QueryString("contactname")
	lastname=request.QueryString("contactname")
	contactTitle=request.QueryString("contactTitle")
	address=request.QueryString("address")
	address2=request.QueryString("address2")
	city=request.QueryString("city")
	mystate=request.QueryString("state")
	country=request.QueryString("country")
	zipcode=request.QueryString("zipcode")
	emailAddress=request.QueryString("emailAddress")
	phone=request.QueryString("phone")
	fax=request.QueryString("fax")
	estDecisionDate=request.QueryString("estDecisionDate")
	commissionable=request.QueryString("commissionable")
	commPercent=request.QueryString("commPercent")
	iata=request.QueryString("iata")
	estRate=request.QueryString("estRate")
	referralType=request.QueryString("referralType")
	startDate= request.QueryString("startDate")
	
	numDays=request.QueryString("numDays")
	
	myDate = request.QueryString("myDate")
	singleRooms = request.QueryString("singleRooms")
	doubleRooms = request.QueryString("doubleRooms")

	totalrms=request.QueryString("totalrms")
	totalrmrev=request.QueryString("totalrmrev")
	
	starttime = request.QueryString("doubleRooms")
	endtime = request.QueryString("doubleRooms")
	functiontype = request.QueryString("doubleRooms")
	setup = request.QueryString("doubleRooms")
	ppl = request.QueryString("doubleRooms")
	fbcomments = request.QueryString("doubleRooms")

	comments=request.QueryString("comments")
	requests=request.QueryString("requests")
	
	hotels=request.QueryString("hotels")
	
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
	
	'****This needs to be done so that a separate record is created for each hotel receiving the lead
	'so each hotel can submit their own unique status.
	
	if myDate <> "" then
		arrDate = split(myDate, ",")
	end if
	if singleRooms <> "" then
		arrsingle = split(singleRooms, ",")
	end if
	if doubleRooms <> "" then
		arrdouble = split(doubleRooms, ",")
	end if
	
	
	if startTime <> "" then
		arrstartTime = split(startTime, ",")
	end if
	if endTime <> "" then
		arrendTime = split(endTime, ",")
	end if
	if functionType <> "" then
		arrfunctionType = split(functionType, ",")
	end if
	if ppl <> "" then
		arrppl = split(ppl, ",")
	end if
	if setup <> "" then
		arrsetup = split(setup, ",")
	end if
	if fbcomments <> "" then
		arrfbcomments = split(fbcomments, ",")
	end if
	
	
	if hotels <> "" then
		arrhotels = split(hotels, ",")
	end if


	call TrapIt()
	
	
	if contactID <> 0 then  ' Existing contact, so update
		sql = "update Referrals_Contacts "
		sql = sql & " set First_Name = '" & firstName & "', last_name='" & lastname & "', "
		sql = sql & " Company='" & company & "',Title='" & contactTitle & "',address='" & address & "', "
		sql = sql & " address2='" & address2 & "',city='" & city & "',mystate='" & mystate & "',"
		sql = sql & " zip='" & zipcode & "',country='" & country & "',phone='" & phone & "',"
		sql = sql & " fax='" & fax & "',email='" & email & "') where ID = " & contactID
		set rsUpdate = myConnSQL.Execute(sql)
		set rsUpdate = nothing
		call TrapIt()

	else  ' New Contact, so insert
		sql = "SET NOCOUNT ON; "
		sql = sql & "Insert into Referrals_Contacts "
		sql = sql & "(RefUserID, First_Name, Last_Name, Company, Title, Address, Address2,"
		sql = sql & "City, State, Zip, Country, Phone, Fax, Email) "
		sql = sql & "Values "
		sql = sql & "(" & usr & ",'" & firstName & "','" & lastname & "','" & company & "',"
		sql = sql & "'" & contactTitle & "','" & address & "','" & address2 & "','" & city & "','" & myState & "',"
		sql = sql & "'" & zipcode & "','" & country & "','" & phone & "','" & fax & "','" & emailAddress & "'); "
		sql = sql & "SELECT @@IDENTITY AS NewID; "
		set rsUpdate = myConnSQL.Execute(sql)
		if not rsUpdate.eof then
			contactID = rsUpdate("NewID")
		else
			contactID = 0
		end if
		set rsUpdate = nothing
		call TrapIt()
	end if
	
	
	sql = "SET NOCOUNT ON; "
	sql = sql & "Insert into Referrals "
	sql = sql & "(Contact_ID, Company, myEvent, Decision_Date, Attendees, Commissionable, Commission, IATA,"
	sql = sql & "Rate, Special_Comments, Requests, RefHotel, RefUserID, Arrival, TotalRooms, RmRevenue,"
	sql = sql & "myStatus, Nights) "
	sql = sql & "Values "
	sql = sql & "(" & contactID & ",'" & company & "','" & evt & "','" & estDecisionDate & "'," & estNum & "," & commissionable & ","
	sql = sql & "'" & commPercent & "','" & iata & "'," & estrate & ",'" & comments & "','" & requests & "'," 
	sql = sql & "'" & refhotel & "'," & usr & ",'" & startDate & "'," & totalrms & "," & totalrmrev & ",'PEND'," & numdays & "); "
	sql = sql & "SELECT @@IDENTITY AS NewID; "
	
	'response.write sql
	'response.End()
	
	'Checked_Out, CheckOut_Date, Definite_Date,"
	'sql = sql & "Definite_Person, Rejection_Reason, Final_Comments, Approved, Approval_Person,"
	'sql = sql & "Check_Cut, Bonus, Sent_Date, Winning_Hotel, Working_UserID, Extended_Stay, 
	
	
	set rsUpdate = myConnSQL.Execute(sql)
	if not rsUpdate.eof then
		referralID = rsUpdate("NewID")
	else
		referralID = 0
	end if
	set rsUpdate = nothing
	call TrapIt()
	
	
	for i = 0 to numDays-1
		sql = "Insert into Referrals_Rooms "
		sql = sql & "(Referral_ID, myDate, Single_Rooms, Double_Rooms) "
		sql = sql & "Values "
		sql = sql & "(" & referralID & ",'" & arrDate(i) & "'," & arrsingle(i) & "," & arrdouble(i) & ") "
		set rsUpdate = myConnSQL.Execute(sql)
		set rsUpdate = nothing
		call TrapIt()
	next
	
	myConnSQL.Close
	set myConnSQL = nothing
	call TrapIt()
	
	
	for i = 0 to numDays-1
		sql = "Insert into Referrals_Events "
		sql = sql & "(Referral_ID, myDate, Start_Time, End_Time, Function_Type, Ppl, Setup, FBComments) "
		sql = sql & "Values "
		sql = sql & "(" & referralID & ",'" & arrDate(i) & "','" & arrstartTime(i) & "','" & arrendTime(i) & "',"
		sql = sql & "'" & arrfuntionType(i) & "','" & arrppl(i) & "','" & arrsetup(i) & "','" & arrfbcomments(i) & "') "
		set rsUpdate = myConnSQL.Execute(sql)
		set rsUpdate = nothing
		call TrapIt()
	next
	
	for i = 0 to ubound(arrhotels)
		sql = "Insert into Referrals_Hotels "
		sql = sql & "(Referral_ID, Property_ID) "
		sql = sql & "Values "
		sql = sql & "(" & referralID & ",'" & arrHotels(i) & "') "
		set rsUpdate = myConnSQL.Execute(sql)
		set rsUpdate = nothing
		call TrapIt()
	next
	
	
	
	
	myConnSQL.Close
	set myConnSQL = nothing
	call TrapIt()
	
end sub

main()

%>


