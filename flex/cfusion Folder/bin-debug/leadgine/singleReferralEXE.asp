<!--#include virtual="/includes/connection.asp" -->
<!--#include virtual="/includes/errorHandler.asp" -->
<%
   'On Error Resume Next
   
   response.buffer = true

   dim refid, sqlLeads
   
   'err.raise 11

sub main()
	getFormData
	call processData()
end sub

sub getFormData()
  refid = request.querystring("id")
  if refid = "" then refid = 0
end sub

sub TrapIt()
	If Err.number <> 0 then
  		call TrapError(Err.description, err.number, usr, sqlLeads)
	End If
end sub


sub processData()
	'on error resume next

	set myConnSQL = server.createobject("ADODB.Connection")
	myConnSQL.Open strConnSQL
	call TrapIt()
	
		sqlLeads = "Select Contact_ID, Company,myEvent,Decision_Date, Attendees, Commissionable, Commission, IATA, Rate, Special_Comments, Requests, RefUserID, RefHotel, Arrival, Sent_Date, TotalRooms, RmRevenue,RentalRevenue,CateringRevenue, Bonus, myStatus, Checked_Out, CheckOut_Date, Definite_Date, Definite_Person, Rejection_Reason, Final_Comments, Approved, Approval_Person, Check_Cut, Winning_Hotel, Working_UserID, Extended_Stay, Nights from Referrals where ID = " & refid
		set rsLeads = myConnSQL.Execute(sqlLeads)
		call TrapIt()

		xmlLeads = "<?xml version='1.0' encoding='ISO-8859-1' ?><response><items>"
		if not rsLeads.eof then
			myStatus = rsLeads("myStatus")
'			select case myStatus
'				case "DEF"
'					myStatus = "Definite"
'				case "TENT"
'					myStatus = "Tentative"
'				case "PEND"
'					myStatus = "Pending"
'				case "REJ"
'					myStatus = "Rejected"
'				case "LOST"
'					myStatus = "Lost"
'			end select
			
			xmlLeads = xmlLeads & "<item>"
				xmlLeads = xmlLeads & "<code>0</code>"
				xmlLeads = xmlLeads & "<id>" & refid & "</id>"
				xmlLeads = xmlLeads & "<newOrExisting>1</newOrExisting>"
				xmlLeads = xmlLeads & "<contact_id>" & rsLeads("Contact_ID") & "</contact_id>"
				xmlLeads = xmlLeads & "<org>" & rsLeads("company") & "</org>"
				xmlLeads = xmlLeads & "<evt>" & rsLeads("myEvent") & "</evt>"
				xmlLeads = xmlLeads & "<estDecisionDate>" & rsLeads("Decision_Date") & "</estDecisionDate>"
				xmlLeads = xmlLeads & "<numGuests>" & rsLeads("Attendees") & "</numGuests>"
				xmlLeads = xmlLeads & "<rateType>" & rsLeads("Commissionable") & "</rateType>"
				xmlLeads = xmlLeads & "<commPercent>" & rsLeads("Commission") & "</commPercent>"
				xmlLeads = xmlLeads & "<IATA>" & rsLeads("IATA") & "</IATA>"
				xmlLeads = xmlLeads & "<rate>" & rsLeads("Rate") & "</rate>"
				
				xmlLeads = xmlLeads & "<roomRows>"
				sqlRooms = "Select id, myDate, single_rooms, double_rooms from Referrals_Rooms where Referral_ID = " & refid
				set rsRooms = myConnSQL.Execute(sqlRooms)
				while not rsRooms.eof
					xmlLeads = xmlLeads & "<roomRow>"
						xmlLeads = xmlLeads & "<roomID>" & rsRooms("id") & "</roomID>"
						xmlLeads = xmlLeads & "<roomDate>" & rsRooms("myDate") & "</roomDate>"
						xmlLeads = xmlLeads & "<singleCount>" & rsRooms("single_rooms") & "</singleCount>"
						xmlLeads = xmlLeads & "<doubleCount>" & rsRooms("double_rooms") & "</doubleCount>"
					xmlLeads = xmlLeads & "</roomRow>"
					rsRooms.movenext
				wend
				rsRooms.close
				set rsRooms = nothing
				xmlLeads = xmlLeads & "</roomRows>"


				xmlLeads = xmlLeads & "<functions>"
				sqlEvents = "Select id, myDate, start_time, end_time, function_type, ppl, setup, fbcomments from Referrals_Events where Referral_ID = " & refid
				set rsEvents = myConnSQL.Execute(sqlEvents)
				while not rsEvents.eof
					xmlLeads = xmlLeads & "<function><functionItems><functionItem>"
						xmlLeads = xmlLeads & "<functionID>" & rsEvents("id") & "</functionID>"
						xmlLeads = xmlLeads & "<functionDate>" & rsEvents("myDate") & "</functionDate>"
						xmlLeads = xmlLeads & "<startTime>" & rsEvents("start_Time") & "</startTime>"
						xmlLeads = xmlLeads & "<endTime>" & rsEvents("end_Time") & "</endTime>"
						xmlLeads = xmlLeads & "<functionDescription>" & rsEvents("function_type") & "</functionDescription>"
						xmlLeads = xmlLeads & "<numPeople>" & rsEvents("ppl") & "</numPeople>"
						xmlLeads = xmlLeads & "<setup>" & rsEvents("setup") & "</setup>"
						xmlLeads = xmlLeads & "<foodBevComments>" & rsEvents("fbcomments") & "</foodBevComments>"						
					xmlLeads = xmlLeads & "</functionItem></functionItems></function>"
					
					rsEvents.movenext
				wend
				rsEvents.close
				set rsEvents = nothing
				xmlLeads = xmlLeads & "</functions>"
				
				
				xmlLeads = xmlLeads & "<hotels>"
				sqlHotels = "Select Referrals_Hotels.id, Referrals_Hotels.Property_id, Referrals_Hotels.myStatus, Properties.Brand, Properties.Property_Name, Properties.Property_Code, Properties.city, properties.mystate from Referrals_Hotels, Properties where Properties.Property_ID = Referrals_Hotels.Property_id and Referral_ID = " & refid & " order by Properties.myState, Properties.brand, properties.property_name "
				set rsHotels = myConnSQL.Execute(sqlHotels)
				if not rsHotels.eof then
					xmlLeads = xmlLeads & "<myState id='" & rsHotels("myState") & "'>"
					xmlLeads = xmlLeads & "<brand id='" & rsHotels("brand") & "'>"
				end if
				while not rsHotels.eof
					brand = rsHotels("brand")
					myState = rsHotels("mystate")
					hotelName = rsHotels("brand") & " - " & rsHotels("Property_Name") & " (" & rsHotels("Property_Code") & "), " & rsHotels("City") & ", " & rsHotels("mystate")
					
					xmlLeads = xmlLeads & "<hotel>"
						'xmlLeads = xmlLeads & "<folderState>" & rsHotels("id") & "</folderState>"
						'xmlLeads = xmlLeads & "<isBranch>" & rsHotels("myDate") & "</isBranch>"
						'xmlLeads = xmlLeads & "<folderLabel>" & rsHotels("myState") & "</folderLabel>"
						xmlLeads = xmlLeads & "<hotelID>" & rsHotels("Property_id") & "</hotelID>"
						xmlLeads = xmlLeads & "<hotelName>" & hotelName & "</hotelName>"
					xmlLeads = xmlLeads & "</hotel>"
					
					rsHotels.movenext
					
					if not rsHotels.eof then
						if rsHotels("brand") <> brand then
							'xmlLeads = xmlLeads & "</brand><brand id='" & rsHotels("brand") & "'>"
							if rsHotels("myState") <> myState then
								xmlLeads = xmlLeads & "</brand></myState><myState id='" & rsHotels("myState") & "'><brand id='" & rsHotels("brand") & "'>"
								myState = rsHotels("myState")
							else
								xmlLeads = xmlLeads & "</brand><brand id='" & rsHotels("brand") & "'>"
							end if
							brand = rsHotels("brand")
						end if
						if rsHotels("myState") <> myState then
							xmlLeads = xmlLeads & "</brand></myState><myState id='" & rsHotels("myState") & "'><brand id='" & rsHotels("brand") & "'>"
							myState = rsHotels("myState")
						end if
					else
							xmlLeads = xmlLeads & "</brand></myState>"
					end if
				wend
				rsHotels.close
				set rsHotels = nothing
				
							'xmlLeads = xmlLeads & "</brand></myState>"
							
							
				xmlLeads = xmlLeads & "</hotels>"



				xmlLeads = xmlLeads & "<commentsText>" & rsLeads("Special_Comments") & "</commentsText>"
				xmlLeads = xmlLeads & "<requestsText>" & rsLeads("Requests") & "</requestsText>"
				xmlLeads = xmlLeads & "<userid>" & rsLeads("RefUserID") & "</userid>"
				xmlLeads = xmlLeads & "<hotelid>" & rsLeads("RefHotel") & "</hotelid>"
				xmlLeads = xmlLeads & "<checked_out>" & rsLeads("Checked_Out") & "</checked_out>"
				xmlLeads = xmlLeads & "<checked_out_date>" & rsLeads("CheckOut_Date") & "</checked_out_date>"
				xmlLeads = xmlLeads & "<definite_date>" & rsLeads("Definite_Date") & "</definite_date>"
				xmlLeads = xmlLeads & "<definite_person>" & rsLeads("Definite_Person") & "</definite_person>"
				xmlLeads = xmlLeads & "<rejection_reason>" & rsLeads("Rejection_Reason") & "</rejection_reason>"
				xmlLeads = xmlLeads & "<final_comments>" & rsLeads("Final_Comments") & "</final_comments>"
				xmlLeads = xmlLeads & "<approved>" & rsLeads("Approved") & "</approved>"
				xmlLeads = xmlLeads & "<approval_person>" & rsLeads("Approval_Person") & "</approval_person>"
				xmlLeads = xmlLeads & "<check_cut>" & rsLeads("Check_Cut") & "</check_cut>"
				xmlLeads = xmlLeads & "<winning_hotel>" & rsLeads("Winning_Hotel") & "</winning_hotel>"
				xmlLeads = xmlLeads & "<working_userID>" & rsLeads("Working_UserID") & "</working_userID>"
				xmlLeads = xmlLeads & "<extended_stay>" & rsLeads("Extended_Stay") & "</extended_stay>"
				xmlLeads = xmlLeads & "<nights>" & rsLeads("Nights") & "</nights>"
				xmlLeads = xmlLeads & "<arrival>" & rsLeads("arrival") & "</arrival>"
				xmlLeads = xmlLeads & "<totalrooms>" & rsLeads("totalrooms") & "</totalrooms>"
				xmlLeads = xmlLeads & "<roomRevenue>" & rsLeads("RmRevenue") & "</roomRevenue>"
				xmlLeads = xmlLeads & "<rentalRevenue>" & rsLeads("RentalRevenue") & "</rentalRevenue>"
				xmlLeads = xmlLeads & "<cateringRevenue>" & rsLeads("CateringRevenue") & "</cateringRevenue>"
				xmlLeads = xmlLeads & "<sentDate>" & rsLeads("Sent_Date") & "</sentDate>"
				xmlLeads = xmlLeads & "<myStatus>" & myStatus & "</myStatus>"
				xmlLeads = xmlLeads & "<bonus>" & rsLeads("bonus") & "</bonus>"
			xmlLeads = xmlLeads & "</item>"
		
		end if
		
		
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
		
	

	response.write xmlLeads
end sub
	
main()

%>


