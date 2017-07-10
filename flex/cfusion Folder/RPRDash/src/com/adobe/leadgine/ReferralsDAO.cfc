<cfcomponent output="false">

	<cffunction name="read" output="false" access="public" returntype="com.adobe.leadgine.Referrals[]">
		<cfargument name="id" required="false">
		<cfargument name="param" required="false">
		<cfset var qRead="">
		<cfset var obj="">
		<cfset var ret = ArrayNew(1)>

		<cfquery name="qRead" datasource="revpar">
			select 	ID, Company, myEvent, Decision, Attendees, Contact, 
					myTitle, Address1, Address2, City, State, 
					Zip, Country, Email, Commissionable, Commission, 
					IATA, Rate, Phone, Fax, Date1, 
					Date2, Date3, Date4, Date5, Date6, 
					Date7, Single1, Single2, Single3, Single4, 
					Single5, Single6, Single7, SingleTotal, Double1, 
					Double2, Double3, Double4, Double5, Double6, 
					Double7, DoubleTotal, Total1, Total2, Total3, 
					Total4, Total5, Total6, Total7, TotalTotal, 
					Start1, Start2, Start3, Start4, Start5, 
					Start6, Start7, End1, End2, End3, 
					End4, End5, End6, End7, Func1, 
					Func2, Func3, Func4, Func5, Func6, 
					Func7, Ppl1, Ppl2, Ppl3, Ppl4, 
					Ppl5, Ppl6, Ppl7, Setup1, Setup2, 
					Setup3, Setup4, Setup5, Setup6, Setup7, 
					FBComments1, FBComments2, FBComments3, FBComments4, FBComments5, 
					FBComments6, FBComments7, CateringRev1, CateringRev2, CateringRev3, 
					CateringRev4, CateringRev5, CateringRev6, CateringRev7, CateringRevTtl, 
					RentRev1, RentRev2, RentRev3, RentRev4, RentRev5, 
					RentRev6, RentRev7, RentRevTtl, SpecialComments, Requests, 
					Hotels, RefHotel, RefUserID, RmRevenue, myStatus, 
					CheckedOut, CheckOutDate, DefiniteDate, Rejection, FinalComments, 
					Approved, CheckCut, BonusLead, Bonus, SentDate, 
					CheckReceived, WorkingHotel, DefPerson, ApprovPerson, Extended_Stay, 
					Nights, PrePayment, TtlPrePayment, LastPrePaymentDate, WorkingManagerID, 
					Hotelogic, LG, BizType, HotLeads, Prospect
					
			from dbo.Referrals
			<cfif structKeyExists(arguments, "id")>
				where ID = <cfqueryparam cfsqltype="CF_SQL_BIGINT" value="#arguments.id#" />
			<cfelseif structKeyExists(arguments, "param")>
				<!---
					adjust this where clause to fit your needs (based on what you want to filter by
					(ie if you wanted to filter by LastName, pass in what you want to filter by in
					the "param" attribute of the function and change "where fieldname" to
					"where LastName" below)

					by default, it will probably throw an error as invalid SQL
				--->
				<!--- where RefHotel = '<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.param#"/>' --->
			</cfif>
		</cfquery>

		<cfloop query="qRead">
			<cfscript>
				obj = createObject("component", "com.adobe.leadgine.Referrals").init();
				obj.setID(qRead.ID);
				obj.setCompany(qRead.Company);
				obj.setmyEvent(qRead.myEvent);
				obj.setDecision(qRead.Decision);
				obj.setAttendees(qRead.Attendees);
				obj.setContact(qRead.Contact);
				obj.setmyTitle(qRead.myTitle);
				obj.setAddress1(qRead.Address1);
				obj.setAddress2(qRead.Address2);
				obj.setCity(qRead.City);
				obj.setState(qRead.State);
				obj.setZip(qRead.Zip);
				obj.setCountry(qRead.Country);
				obj.setEmail(qRead.Email);
				obj.setCommissionable(qRead.Commissionable);
				obj.setCommission(qRead.Commission);
				obj.setIATA(qRead.IATA);
				obj.setRate(qRead.Rate);
				obj.setPhone(qRead.Phone);
				obj.setFax(qRead.Fax);
				obj.setDate1(qRead.Date1);
				obj.setDate2(qRead.Date2);
				obj.setDate3(qRead.Date3);
				obj.setDate4(qRead.Date4);
				obj.setDate5(qRead.Date5);
				obj.setDate6(qRead.Date6);
				obj.setDate7(qRead.Date7);
				obj.setSingle1(qRead.Single1);
				obj.setSingle2(qRead.Single2);
				obj.setSingle3(qRead.Single3);
				obj.setSingle4(qRead.Single4);
				obj.setSingle5(qRead.Single5);
				obj.setSingle6(qRead.Single6);
				obj.setSingle7(qRead.Single7);
				obj.setSingleTotal(qRead.SingleTotal);
				obj.setDouble1(qRead.Double1);
				obj.setDouble2(qRead.Double2);
				obj.setDouble3(qRead.Double3);
				obj.setDouble4(qRead.Double4);
				obj.setDouble5(qRead.Double5);
				obj.setDouble6(qRead.Double6);
				obj.setDouble7(qRead.Double7);
				obj.setDoubleTotal(qRead.DoubleTotal);
				obj.setTotal1(qRead.Total1);
				obj.setTotal2(qRead.Total2);
				obj.setTotal3(qRead.Total3);
				obj.setTotal4(qRead.Total4);
				obj.setTotal5(qRead.Total5);
				obj.setTotal6(qRead.Total6);
				obj.setTotal7(qRead.Total7);
				obj.setTotalTotal(qRead.TotalTotal);
				obj.setStart1(qRead.Start1);
				obj.setStart2(qRead.Start2);
				obj.setStart3(qRead.Start3);
				obj.setStart4(qRead.Start4);
				obj.setStart5(qRead.Start5);
				obj.setStart6(qRead.Start6);
				obj.setStart7(qRead.Start7);
				obj.setEnd1(qRead.End1);
				obj.setEnd2(qRead.End2);
				obj.setEnd3(qRead.End3);
				obj.setEnd4(qRead.End4);
				obj.setEnd5(qRead.End5);
				obj.setEnd6(qRead.End6);
				obj.setEnd7(qRead.End7);
				obj.setFunc1(qRead.Func1);
				obj.setFunc2(qRead.Func2);
				obj.setFunc3(qRead.Func3);
				obj.setFunc4(qRead.Func4);
				obj.setFunc5(qRead.Func5);
				obj.setFunc6(qRead.Func6);
				obj.setFunc7(qRead.Func7);
				obj.setPpl1(qRead.Ppl1);
				obj.setPpl2(qRead.Ppl2);
				obj.setPpl3(qRead.Ppl3);
				obj.setPpl4(qRead.Ppl4);
				obj.setPpl5(qRead.Ppl5);
				obj.setPpl6(qRead.Ppl6);
				obj.setPpl7(qRead.Ppl7);
				obj.setSetup1(qRead.Setup1);
				obj.setSetup2(qRead.Setup2);
				obj.setSetup3(qRead.Setup3);
				obj.setSetup4(qRead.Setup4);
				obj.setSetup5(qRead.Setup5);
				obj.setSetup6(qRead.Setup6);
				obj.setSetup7(qRead.Setup7);
				obj.setFBComments1(qRead.FBComments1);
				obj.setFBComments2(qRead.FBComments2);
				obj.setFBComments3(qRead.FBComments3);
				obj.setFBComments4(qRead.FBComments4);
				obj.setFBComments5(qRead.FBComments5);
				obj.setFBComments6(qRead.FBComments6);
				obj.setFBComments7(qRead.FBComments7);
				obj.setCateringRev1(qRead.CateringRev1);
				obj.setCateringRev2(qRead.CateringRev2);
				obj.setCateringRev3(qRead.CateringRev3);
				obj.setCateringRev4(qRead.CateringRev4);
				obj.setCateringRev5(qRead.CateringRev5);
				obj.setCateringRev6(qRead.CateringRev6);
				obj.setCateringRev7(qRead.CateringRev7);
				obj.setCateringRevTtl(qRead.CateringRevTtl);
				obj.setRentRev1(qRead.RentRev1);
				obj.setRentRev2(qRead.RentRev2);
				obj.setRentRev3(qRead.RentRev3);
				obj.setRentRev4(qRead.RentRev4);
				obj.setRentRev5(qRead.RentRev5);
				obj.setRentRev6(qRead.RentRev6);
				obj.setRentRev7(qRead.RentRev7);
				obj.setRentRevTtl(qRead.RentRevTtl);
				obj.setSpecialComments(qRead.SpecialComments);
				obj.setRequests(qRead.Requests);
				obj.setHotels(qRead.Hotels);
				obj.setRefHotel(qRead.RefHotel);
				obj.setRefUserID(qRead.RefUserID);
				obj.setRmRevenue(qRead.RmRevenue);
				obj.setmyStatus(qRead.myStatus);
				obj.setCheckedOut(qRead.CheckedOut);
				obj.setCheckOutDate(qRead.CheckOutDate);
				obj.setDefiniteDate(qRead.DefiniteDate);
				obj.setRejection(qRead.Rejection);
				obj.setFinalComments(qRead.FinalComments);
				obj.setApproved(qRead.Approved);
				obj.setCheckCut(qRead.CheckCut);
				obj.setBonusLead(qRead.BonusLead);
				obj.setBonus(qRead.Bonus);
				obj.setSentDate(qRead.SentDate);
				obj.setCheckReceived(qRead.CheckReceived);
				obj.setWorkingHotel(qRead.WorkingHotel);
				obj.setDefPerson(qRead.DefPerson);
				obj.setApprovPerson(qRead.ApprovPerson);
				obj.setExtended_Stay(qRead.Extended_Stay);
				obj.setNights(qRead.Nights);
				obj.setPrePayment(qRead.PrePayment);
				obj.setTtlPrePayment(qRead.TtlPrePayment);
				obj.setLastPrePaymentDate(qRead.LastPrePaymentDate);
				obj.setWorkingManagerID(qRead.WorkingManagerID);
				obj.setHotelogic(qRead.Hotelogic);
				obj.setLG(qRead.LG);
				obj.setBizType(qRead.BizType);
				obj.setHotLeads(qRead.HotLeads);
				obj.setProspect(qRead.Prospect);
				ArrayAppend(ret, obj);
			</cfscript>
		</cfloop>
		<cfreturn ret>
	</cffunction>



	<cffunction name="create" output="false" access="public">
		<cfargument name="bean" required="true" type="com.adobe.leadgine.Referrals">
		<cfset var qCreate="">

		<cfset var qGetId="">

		<cfset var local1=arguments.bean.getCompany()>
		<cfset var local2=arguments.bean.getmyEvent()>
		<cfset var local3=arguments.bean.getDecision()>
		<cfset var local4=arguments.bean.getAttendees()>
		<cfset var local5=arguments.bean.getContact()>
		<cfset var local6=arguments.bean.getmyTitle()>
		<cfset var local7=arguments.bean.getAddress1()>
		<cfset var local8=arguments.bean.getAddress2()>
		<cfset var local9=arguments.bean.getCity()>
		<cfset var local10=arguments.bean.getState()>
		<cfset var local11=arguments.bean.getZip()>
		<cfset var local12=arguments.bean.getCountry()>
		<cfset var local13=arguments.bean.getEmail()>
		<cfset var local14=arguments.bean.getCommissionable()>
		<cfset var local15=arguments.bean.getCommission()>
		<cfset var local16=arguments.bean.getIATA()>
		<cfset var local17=arguments.bean.getRate()>
		<cfset var local18=arguments.bean.getPhone()>
		<cfset var local19=arguments.bean.getFax()>
		<cfset var local20=arguments.bean.getDate1()>
		<cfset var local21=arguments.bean.getDate2()>
		<cfset var local22=arguments.bean.getDate3()>
		<cfset var local23=arguments.bean.getDate4()>
		<cfset var local24=arguments.bean.getDate5()>
		<cfset var local25=arguments.bean.getDate6()>
		<cfset var local26=arguments.bean.getDate7()>
		<cfset var local27=arguments.bean.getSingle1()>
		<cfset var local28=arguments.bean.getSingle2()>
		<cfset var local29=arguments.bean.getSingle3()>
		<cfset var local30=arguments.bean.getSingle4()>
		<cfset var local31=arguments.bean.getSingle5()>
		<cfset var local32=arguments.bean.getSingle6()>
		<cfset var local33=arguments.bean.getSingle7()>
		<cfset var local34=arguments.bean.getSingleTotal()>
		<cfset var local35=arguments.bean.getDouble1()>
		<cfset var local36=arguments.bean.getDouble2()>
		<cfset var local37=arguments.bean.getDouble3()>
		<cfset var local38=arguments.bean.getDouble4()>
		<cfset var local39=arguments.bean.getDouble5()>
		<cfset var local40=arguments.bean.getDouble6()>
		<cfset var local41=arguments.bean.getDouble7()>
		<cfset var local42=arguments.bean.getDoubleTotal()>
		<cfset var local43=arguments.bean.getTotal1()>
		<cfset var local44=arguments.bean.getTotal2()>
		<cfset var local45=arguments.bean.getTotal3()>
		<cfset var local46=arguments.bean.getTotal4()>
		<cfset var local47=arguments.bean.getTotal5()>
		<cfset var local48=arguments.bean.getTotal6()>
		<cfset var local49=arguments.bean.getTotal7()>
		<cfset var local50=arguments.bean.getTotalTotal()>
		<cfset var local51=arguments.bean.getStart1()>
		<cfset var local52=arguments.bean.getStart2()>
		<cfset var local53=arguments.bean.getStart3()>
		<cfset var local54=arguments.bean.getStart4()>
		<cfset var local55=arguments.bean.getStart5()>
		<cfset var local56=arguments.bean.getStart6()>
		<cfset var local57=arguments.bean.getStart7()>
		<cfset var local58=arguments.bean.getEnd1()>
		<cfset var local59=arguments.bean.getEnd2()>
		<cfset var local60=arguments.bean.getEnd3()>
		<cfset var local61=arguments.bean.getEnd4()>
		<cfset var local62=arguments.bean.getEnd5()>
		<cfset var local63=arguments.bean.getEnd6()>
		<cfset var local64=arguments.bean.getEnd7()>
		<cfset var local65=arguments.bean.getFunc1()>
		<cfset var local66=arguments.bean.getFunc2()>
		<cfset var local67=arguments.bean.getFunc3()>
		<cfset var local68=arguments.bean.getFunc4()>
		<cfset var local69=arguments.bean.getFunc5()>
		<cfset var local70=arguments.bean.getFunc6()>
		<cfset var local71=arguments.bean.getFunc7()>
		<cfset var local72=arguments.bean.getPpl1()>
		<cfset var local73=arguments.bean.getPpl2()>
		<cfset var local74=arguments.bean.getPpl3()>
		<cfset var local75=arguments.bean.getPpl4()>
		<cfset var local76=arguments.bean.getPpl5()>
		<cfset var local77=arguments.bean.getPpl6()>
		<cfset var local78=arguments.bean.getPpl7()>
		<cfset var local79=arguments.bean.getSetup1()>
		<cfset var local80=arguments.bean.getSetup2()>
		<cfset var local81=arguments.bean.getSetup3()>
		<cfset var local82=arguments.bean.getSetup4()>
		<cfset var local83=arguments.bean.getSetup5()>
		<cfset var local84=arguments.bean.getSetup6()>
		<cfset var local85=arguments.bean.getSetup7()>
		<cfset var local86=arguments.bean.getFBComments1()>
		<cfset var local87=arguments.bean.getFBComments2()>
		<cfset var local88=arguments.bean.getFBComments3()>
		<cfset var local89=arguments.bean.getFBComments4()>
		<cfset var local90=arguments.bean.getFBComments5()>
		<cfset var local91=arguments.bean.getFBComments6()>
		<cfset var local92=arguments.bean.getFBComments7()>
		<cfset var local93=arguments.bean.getCateringRev1()>
		<cfset var local94=arguments.bean.getCateringRev2()>
		<cfset var local95=arguments.bean.getCateringRev3()>
		<cfset var local96=arguments.bean.getCateringRev4()>
		<cfset var local97=arguments.bean.getCateringRev5()>
		<cfset var local98=arguments.bean.getCateringRev6()>
		<cfset var local99=arguments.bean.getCateringRev7()>
		<cfset var local100=arguments.bean.getCateringRevTtl()>
		<cfset var local101=arguments.bean.getRentRev1()>
		<cfset var local102=arguments.bean.getRentRev2()>
		<cfset var local103=arguments.bean.getRentRev3()>
		<cfset var local104=arguments.bean.getRentRev4()>
		<cfset var local105=arguments.bean.getRentRev5()>
		<cfset var local106=arguments.bean.getRentRev6()>
		<cfset var local107=arguments.bean.getRentRev7()>
		<cfset var local108=arguments.bean.getRentRevTtl()>
		<cfset var local109=arguments.bean.getSpecialComments()>
		<cfset var local110=arguments.bean.getRequests()>
		<cfset var local111=arguments.bean.getHotels()>
		<cfset var local112=arguments.bean.getRefHotel()>
		<cfset var local113=arguments.bean.getRefUserID()>
		<cfset var local114=arguments.bean.getRmRevenue()>
		<cfset var local115=arguments.bean.getmyStatus()>
		<cfset var local116=arguments.bean.getCheckedOut()>
		<cfset var local117=arguments.bean.getCheckOutDate()>
		<cfset var local118=arguments.bean.getDefiniteDate()>
		<cfset var local119=arguments.bean.getRejection()>
		<cfset var local120=arguments.bean.getFinalComments()>
		<cfset var local121=arguments.bean.getApproved()>
		<cfset var local122=arguments.bean.getCheckCut()>
		<cfset var local123=arguments.bean.getBonusLead()>
		<cfset var local124=arguments.bean.getBonus()>
		<cfset var local125=arguments.bean.getSentDate()>
		<cfset var local126=arguments.bean.getCheckReceived()>
		<cfset var local127=arguments.bean.getWorkingHotel()>
		<cfset var local128=arguments.bean.getDefPerson()>
		<cfset var local129=arguments.bean.getApprovPerson()>
		<cfset var local130=arguments.bean.getExtended_Stay()>
		<cfset var local131=arguments.bean.getNights()>
		<cfset var local132=arguments.bean.getPrePayment()>
		<cfset var local133=arguments.bean.getTtlPrePayment()>
		<cfset var local134=arguments.bean.getLastPrePaymentDate()>
		<cfset var local135=arguments.bean.getWorkingManagerID()>
		<cfset var local136=arguments.bean.getHotelogic()>
		<cfset var local137=arguments.bean.getLG()>
		<cfset var local138=arguments.bean.getBizType()>
		<cfset var local139=arguments.bean.getHotLeads()>
		<cfset var local140=arguments.bean.getProspect()>

		<cftransaction isolation="read_committed">
			<cfquery name="qCreate" datasource="revpar">
				insert into dbo.Referrals(Company, myEvent, Decision, Attendees, Contact, myTitle, Address1, Address2, City, State, Zip, Country, Email, Commissionable, Commission, IATA, Rate, Phone, Fax, Date1, Date2, Date3, Date4, Date5, Date6, Date7, Single1, Single2, Single3, Single4, Single5, Single6, Single7, SingleTotal, Double1, Double2, Double3, Double4, Double5, Double6, Double7, DoubleTotal, Total1, Total2, Total3, Total4, Total5, Total6, Total7, TotalTotal, Start1, Start2, Start3, Start4, Start5, Start6, Start7, End1, End2, End3, End4, End5, End6, End7, Func1, Func2, Func3, Func4, Func5, Func6, Func7, Ppl1, Ppl2, Ppl3, Ppl4, Ppl5, Ppl6, Ppl7, Setup1, Setup2, Setup3, Setup4, Setup5, Setup6, Setup7, FBComments1, FBComments2, FBComments3, FBComments4, FBComments5, FBComments6, FBComments7, CateringRev1, CateringRev2, CateringRev3, CateringRev4, CateringRev5, CateringRev6, CateringRev7, CateringRevTtl, RentRev1, RentRev2, RentRev3, RentRev4, RentRev5, RentRev6, RentRev7, RentRevTtl, SpecialComments, Requests, Hotels, RefHotel, RefUserID, RmRevenue, myStatus, CheckedOut, CheckOutDate, DefiniteDate, Rejection, FinalComments, Approved, CheckCut, BonusLead, Bonus, SentDate, CheckReceived, WorkingHotel, DefPerson, ApprovPerson, Extended_Stay, Nights, PrePayment, TtlPrePayment, LastPrePaymentDate, WorkingManagerID, Hotelogic, LG, BizType, HotLeads, Prospect)
				values (
					<cfqueryparam value="#local1#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local2#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local3#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local4#" cfsqltype="CF_SQL_INTEGER" null="#iif((local4 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local5#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local6#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local7#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local8#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local9#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local10#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local11#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local12#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local13#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local14#" cfsqltype="CF_SQL_BIT" null="#iif((local14 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local15#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local16#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local17#" cfsqltype="CF_SQL_FLOAT" null="#iif((local17 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local18#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local19#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local20#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local20 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local21#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local21 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local22#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local22 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local23#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local23 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local24#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local24 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local25#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local25 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local26#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local26 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local27#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local27 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local28#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local28 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local29#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local29 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local30#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local30 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local31#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local31 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local32#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local32 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local33#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local33 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local34#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local34 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local35#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local35 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local36#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local36 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local37#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local37 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local38#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local38 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local39#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local39 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local40#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local40 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local41#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local41 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local42#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local42 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local43#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local43 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local44#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local44 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local45#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local45 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local46#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local46 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local47#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local47 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local48#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local48 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local49#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local49 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local50#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local50 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local51#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local52#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local53#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local54#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local55#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local56#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local57#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local58#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local59#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local60#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local61#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local62#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local63#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local64#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local65#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local66#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local67#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local68#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local69#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local70#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local71#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local72#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local73#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local74#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local75#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local76#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local77#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local78#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local79#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local80#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local81#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local82#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local83#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local84#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local85#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local86#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local87#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local88#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local89#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local90#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local91#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local92#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local93#" cfsqltype="CF_SQL_FLOAT" null="#iif((local93 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local94#" cfsqltype="CF_SQL_FLOAT" null="#iif((local94 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local95#" cfsqltype="CF_SQL_FLOAT" null="#iif((local95 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local96#" cfsqltype="CF_SQL_FLOAT" null="#iif((local96 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local97#" cfsqltype="CF_SQL_FLOAT" null="#iif((local97 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local98#" cfsqltype="CF_SQL_FLOAT" null="#iif((local98 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local99#" cfsqltype="CF_SQL_FLOAT" null="#iif((local99 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local100#" cfsqltype="CF_SQL_FLOAT" null="#iif((local100 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local101#" cfsqltype="CF_SQL_FLOAT" null="#iif((local101 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local102#" cfsqltype="CF_SQL_FLOAT" null="#iif((local102 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local103#" cfsqltype="CF_SQL_FLOAT" null="#iif((local103 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local104#" cfsqltype="CF_SQL_FLOAT" null="#iif((local104 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local105#" cfsqltype="CF_SQL_FLOAT" null="#iif((local105 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local106#" cfsqltype="CF_SQL_FLOAT" null="#iif((local106 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local107#" cfsqltype="CF_SQL_FLOAT" null="#iif((local107 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local108#" cfsqltype="CF_SQL_FLOAT" null="#iif((local108 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local109#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local110#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local111#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local112#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local113#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local113 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local114#" cfsqltype="CF_SQL_FLOAT" null="#iif((local114 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local115#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local116#" cfsqltype="CF_SQL_BIT" null="#iif((local116 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local117#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local117 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local118#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local118 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local119#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local120#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local121#" cfsqltype="CF_SQL_BIT" null="#iif((local121 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local122#" cfsqltype="CF_SQL_BIT" null="#iif((local122 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local123#" cfsqltype="CF_SQL_BIT" null="#iif((local123 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local124#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local124 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local125#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local125 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local126#" cfsqltype="CF_SQL_BIT" null="#iif((local126 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local127#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local128#" cfsqltype="CF_SQL_INTEGER" null="#iif((local128 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local129#" cfsqltype="CF_SQL_INTEGER" null="#iif((local129 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local130#" cfsqltype="CF_SQL_BIT" null="#iif((local130 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local131#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local131 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local132#" cfsqltype="CF_SQL_FLOAT" null="#iif((local132 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local133#" cfsqltype="CF_SQL_FLOAT" null="#iif((local133 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local134#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local134 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local135#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local135 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local136#" cfsqltype="CF_SQL_BIT" null="#iif((local136 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local137#" cfsqltype="CF_SQL_INTEGER" null="#iif((local137 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local138#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local139#" cfsqltype="CF_SQL_BIT" null="#iif((local139 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local140#" cfsqltype="CF_SQL_BIT" null="#iif((local140 eq ""), de("yes"), de("no"))#" />
				)
			</cfquery>

			<!--- If your server has a better way to get the ID that is more reliable, use that instead --->
			<cfquery name="qGetID" datasource="revpar">
				select ID
				from dbo.Referrals
				where Company = <cfqueryparam value="#local1#" cfsqltype="CF_SQL_VARCHAR" />
				  and myEvent = <cfqueryparam value="#local2#" cfsqltype="CF_SQL_VARCHAR" />
				  and Decision = <cfqueryparam value="#local3#" cfsqltype="CF_SQL_VARCHAR" />
				  and Attendees = <cfqueryparam value="#local4#" cfsqltype="CF_SQL_INTEGER" null="#iif((local4 eq ""), de("yes"), de("no"))#" />
				  and Contact = <cfqueryparam value="#local5#" cfsqltype="CF_SQL_VARCHAR" />
				  and myTitle = <cfqueryparam value="#local6#" cfsqltype="CF_SQL_VARCHAR" />
				  and Address1 = <cfqueryparam value="#local7#" cfsqltype="CF_SQL_VARCHAR" />
				  and Address2 = <cfqueryparam value="#local8#" cfsqltype="CF_SQL_VARCHAR" />
				  and City = <cfqueryparam value="#local9#" cfsqltype="CF_SQL_VARCHAR" />
				  and State = <cfqueryparam value="#local10#" cfsqltype="CF_SQL_VARCHAR" />
				  and Zip = <cfqueryparam value="#local11#" cfsqltype="CF_SQL_VARCHAR" />
				  and Country = <cfqueryparam value="#local12#" cfsqltype="CF_SQL_VARCHAR" />
				  and Email = <cfqueryparam value="#local13#" cfsqltype="CF_SQL_VARCHAR" />
				  and Commissionable = <cfqueryparam value="#local14#" cfsqltype="CF_SQL_BIT" null="#iif((local14 eq ""), de("yes"), de("no"))#" />
				  and Commission = <cfqueryparam value="#local15#" cfsqltype="CF_SQL_VARCHAR" />
				  and IATA = <cfqueryparam value="#local16#" cfsqltype="CF_SQL_VARCHAR" />
				  and Rate = <cfqueryparam value="#local17#" cfsqltype="CF_SQL_FLOAT" null="#iif((local17 eq ""), de("yes"), de("no"))#" />
				  and Phone = <cfqueryparam value="#local18#" cfsqltype="CF_SQL_VARCHAR" />
				  and Fax = <cfqueryparam value="#local19#" cfsqltype="CF_SQL_VARCHAR" />
				  and Date1 = <cfqueryparam value="#local20#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local20 eq ""), de("yes"), de("no"))#" />
				  and Date2 = <cfqueryparam value="#local21#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local21 eq ""), de("yes"), de("no"))#" />
				  and Date3 = <cfqueryparam value="#local22#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local22 eq ""), de("yes"), de("no"))#" />
				  and Date4 = <cfqueryparam value="#local23#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local23 eq ""), de("yes"), de("no"))#" />
				  and Date5 = <cfqueryparam value="#local24#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local24 eq ""), de("yes"), de("no"))#" />
				  and Date6 = <cfqueryparam value="#local25#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local25 eq ""), de("yes"), de("no"))#" />
				  and Date7 = <cfqueryparam value="#local26#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local26 eq ""), de("yes"), de("no"))#" />
				  and Single1 = <cfqueryparam value="#local27#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local27 eq ""), de("yes"), de("no"))#" />
				  and Single2 = <cfqueryparam value="#local28#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local28 eq ""), de("yes"), de("no"))#" />
				  and Single3 = <cfqueryparam value="#local29#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local29 eq ""), de("yes"), de("no"))#" />
				  and Single4 = <cfqueryparam value="#local30#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local30 eq ""), de("yes"), de("no"))#" />
				  and Single5 = <cfqueryparam value="#local31#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local31 eq ""), de("yes"), de("no"))#" />
				  and Single6 = <cfqueryparam value="#local32#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local32 eq ""), de("yes"), de("no"))#" />
				  and Single7 = <cfqueryparam value="#local33#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local33 eq ""), de("yes"), de("no"))#" />
				  and SingleTotal = <cfqueryparam value="#local34#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local34 eq ""), de("yes"), de("no"))#" />
				  and Double1 = <cfqueryparam value="#local35#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local35 eq ""), de("yes"), de("no"))#" />
				  and Double2 = <cfqueryparam value="#local36#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local36 eq ""), de("yes"), de("no"))#" />
				  and Double3 = <cfqueryparam value="#local37#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local37 eq ""), de("yes"), de("no"))#" />
				  and Double4 = <cfqueryparam value="#local38#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local38 eq ""), de("yes"), de("no"))#" />
				  and Double5 = <cfqueryparam value="#local39#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local39 eq ""), de("yes"), de("no"))#" />
				  and Double6 = <cfqueryparam value="#local40#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local40 eq ""), de("yes"), de("no"))#" />
				  and Double7 = <cfqueryparam value="#local41#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local41 eq ""), de("yes"), de("no"))#" />
				  and DoubleTotal = <cfqueryparam value="#local42#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local42 eq ""), de("yes"), de("no"))#" />
				  and Total1 = <cfqueryparam value="#local43#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local43 eq ""), de("yes"), de("no"))#" />
				  and Total2 = <cfqueryparam value="#local44#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local44 eq ""), de("yes"), de("no"))#" />
				  and Total3 = <cfqueryparam value="#local45#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local45 eq ""), de("yes"), de("no"))#" />
				  and Total4 = <cfqueryparam value="#local46#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local46 eq ""), de("yes"), de("no"))#" />
				  and Total5 = <cfqueryparam value="#local47#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local47 eq ""), de("yes"), de("no"))#" />
				  and Total6 = <cfqueryparam value="#local48#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local48 eq ""), de("yes"), de("no"))#" />
				  and Total7 = <cfqueryparam value="#local49#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local49 eq ""), de("yes"), de("no"))#" />
				  and TotalTotal = <cfqueryparam value="#local50#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local50 eq ""), de("yes"), de("no"))#" />
				  and Start1 = <cfqueryparam value="#local51#" cfsqltype="CF_SQL_VARCHAR" />
				  and Start2 = <cfqueryparam value="#local52#" cfsqltype="CF_SQL_VARCHAR" />
				  and Start3 = <cfqueryparam value="#local53#" cfsqltype="CF_SQL_VARCHAR" />
				  and Start4 = <cfqueryparam value="#local54#" cfsqltype="CF_SQL_VARCHAR" />
				  and Start5 = <cfqueryparam value="#local55#" cfsqltype="CF_SQL_VARCHAR" />
				  and Start6 = <cfqueryparam value="#local56#" cfsqltype="CF_SQL_VARCHAR" />
				  and Start7 = <cfqueryparam value="#local57#" cfsqltype="CF_SQL_VARCHAR" />
				  and End1 = <cfqueryparam value="#local58#" cfsqltype="CF_SQL_VARCHAR" />
				  and End2 = <cfqueryparam value="#local59#" cfsqltype="CF_SQL_VARCHAR" />
				  and End3 = <cfqueryparam value="#local60#" cfsqltype="CF_SQL_VARCHAR" />
				  and End4 = <cfqueryparam value="#local61#" cfsqltype="CF_SQL_VARCHAR" />
				  and End5 = <cfqueryparam value="#local62#" cfsqltype="CF_SQL_VARCHAR" />
				  and End6 = <cfqueryparam value="#local63#" cfsqltype="CF_SQL_VARCHAR" />
				  and End7 = <cfqueryparam value="#local64#" cfsqltype="CF_SQL_VARCHAR" />
				  and Func1 = <cfqueryparam value="#local65#" cfsqltype="CF_SQL_VARCHAR" />
				  and Func2 = <cfqueryparam value="#local66#" cfsqltype="CF_SQL_VARCHAR" />
				  and Func3 = <cfqueryparam value="#local67#" cfsqltype="CF_SQL_VARCHAR" />
				  and Func4 = <cfqueryparam value="#local68#" cfsqltype="CF_SQL_VARCHAR" />
				  and Func5 = <cfqueryparam value="#local69#" cfsqltype="CF_SQL_VARCHAR" />
				  and Func6 = <cfqueryparam value="#local70#" cfsqltype="CF_SQL_VARCHAR" />
				  and Func7 = <cfqueryparam value="#local71#" cfsqltype="CF_SQL_VARCHAR" />
				  and Ppl1 = <cfqueryparam value="#local72#" cfsqltype="CF_SQL_VARCHAR" />
				  and Ppl2 = <cfqueryparam value="#local73#" cfsqltype="CF_SQL_VARCHAR" />
				  and Ppl3 = <cfqueryparam value="#local74#" cfsqltype="CF_SQL_VARCHAR" />
				  and Ppl4 = <cfqueryparam value="#local75#" cfsqltype="CF_SQL_VARCHAR" />
				  and Ppl5 = <cfqueryparam value="#local76#" cfsqltype="CF_SQL_VARCHAR" />
				  and Ppl6 = <cfqueryparam value="#local77#" cfsqltype="CF_SQL_VARCHAR" />
				  and Ppl7 = <cfqueryparam value="#local78#" cfsqltype="CF_SQL_VARCHAR" />
				  and Setup1 = <cfqueryparam value="#local79#" cfsqltype="CF_SQL_VARCHAR" />
				  and Setup2 = <cfqueryparam value="#local80#" cfsqltype="CF_SQL_VARCHAR" />
				  and Setup3 = <cfqueryparam value="#local81#" cfsqltype="CF_SQL_VARCHAR" />
				  and Setup4 = <cfqueryparam value="#local82#" cfsqltype="CF_SQL_VARCHAR" />
				  and Setup5 = <cfqueryparam value="#local83#" cfsqltype="CF_SQL_VARCHAR" />
				  and Setup6 = <cfqueryparam value="#local84#" cfsqltype="CF_SQL_VARCHAR" />
				  and Setup7 = <cfqueryparam value="#local85#" cfsqltype="CF_SQL_VARCHAR" />
				  and FBComments1 = <cfqueryparam value="#local86#" cfsqltype="CF_SQL_VARCHAR" />
				  and FBComments2 = <cfqueryparam value="#local87#" cfsqltype="CF_SQL_VARCHAR" />
				  and FBComments3 = <cfqueryparam value="#local88#" cfsqltype="CF_SQL_VARCHAR" />
				  and FBComments4 = <cfqueryparam value="#local89#" cfsqltype="CF_SQL_VARCHAR" />
				  and FBComments5 = <cfqueryparam value="#local90#" cfsqltype="CF_SQL_VARCHAR" />
				  and FBComments6 = <cfqueryparam value="#local91#" cfsqltype="CF_SQL_VARCHAR" />
				  and FBComments7 = <cfqueryparam value="#local92#" cfsqltype="CF_SQL_VARCHAR" />
				  and CateringRev1 = <cfqueryparam value="#local93#" cfsqltype="CF_SQL_FLOAT" null="#iif((local93 eq ""), de("yes"), de("no"))#" />
				  and CateringRev2 = <cfqueryparam value="#local94#" cfsqltype="CF_SQL_FLOAT" null="#iif((local94 eq ""), de("yes"), de("no"))#" />
				  and CateringRev3 = <cfqueryparam value="#local95#" cfsqltype="CF_SQL_FLOAT" null="#iif((local95 eq ""), de("yes"), de("no"))#" />
				  and CateringRev4 = <cfqueryparam value="#local96#" cfsqltype="CF_SQL_FLOAT" null="#iif((local96 eq ""), de("yes"), de("no"))#" />
				  and CateringRev5 = <cfqueryparam value="#local97#" cfsqltype="CF_SQL_FLOAT" null="#iif((local97 eq ""), de("yes"), de("no"))#" />
				  and CateringRev6 = <cfqueryparam value="#local98#" cfsqltype="CF_SQL_FLOAT" null="#iif((local98 eq ""), de("yes"), de("no"))#" />
				  and CateringRev7 = <cfqueryparam value="#local99#" cfsqltype="CF_SQL_FLOAT" null="#iif((local99 eq ""), de("yes"), de("no"))#" />
				  and CateringRevTtl = <cfqueryparam value="#local100#" cfsqltype="CF_SQL_FLOAT" null="#iif((local100 eq ""), de("yes"), de("no"))#" />
				  and RentRev1 = <cfqueryparam value="#local101#" cfsqltype="CF_SQL_FLOAT" null="#iif((local101 eq ""), de("yes"), de("no"))#" />
				  and RentRev2 = <cfqueryparam value="#local102#" cfsqltype="CF_SQL_FLOAT" null="#iif((local102 eq ""), de("yes"), de("no"))#" />
				  and RentRev3 = <cfqueryparam value="#local103#" cfsqltype="CF_SQL_FLOAT" null="#iif((local103 eq ""), de("yes"), de("no"))#" />
				  and RentRev4 = <cfqueryparam value="#local104#" cfsqltype="CF_SQL_FLOAT" null="#iif((local104 eq ""), de("yes"), de("no"))#" />
				  and RentRev5 = <cfqueryparam value="#local105#" cfsqltype="CF_SQL_FLOAT" null="#iif((local105 eq ""), de("yes"), de("no"))#" />
				  and RentRev6 = <cfqueryparam value="#local106#" cfsqltype="CF_SQL_FLOAT" null="#iif((local106 eq ""), de("yes"), de("no"))#" />
				  and RentRev7 = <cfqueryparam value="#local107#" cfsqltype="CF_SQL_FLOAT" null="#iif((local107 eq ""), de("yes"), de("no"))#" />
				  and RentRevTtl = <cfqueryparam value="#local108#" cfsqltype="CF_SQL_FLOAT" null="#iif((local108 eq ""), de("yes"), de("no"))#" />
				  and SpecialComments = <cfqueryparam value="#local109#" cfsqltype="CF_SQL_VARCHAR" />
				  and Requests = <cfqueryparam value="#local110#" cfsqltype="CF_SQL_VARCHAR" />
				  and Hotels = <cfqueryparam value="#local111#" cfsqltype="CF_SQL_VARCHAR" />
				  and RefHotel = <cfqueryparam value="#local112#" cfsqltype="CF_SQL_VARCHAR" />
				  and RefUserID = <cfqueryparam value="#local113#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local113 eq ""), de("yes"), de("no"))#" />
				  and RmRevenue = <cfqueryparam value="#local114#" cfsqltype="CF_SQL_FLOAT" null="#iif((local114 eq ""), de("yes"), de("no"))#" />
				  and myStatus = <cfqueryparam value="#local115#" cfsqltype="CF_SQL_VARCHAR" />
				  and CheckedOut = <cfqueryparam value="#local116#" cfsqltype="CF_SQL_BIT" null="#iif((local116 eq ""), de("yes"), de("no"))#" />
				  and CheckOutDate = <cfqueryparam value="#local117#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local117 eq ""), de("yes"), de("no"))#" />
				  and DefiniteDate = <cfqueryparam value="#local118#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local118 eq ""), de("yes"), de("no"))#" />
				  and Rejection = <cfqueryparam value="#local119#" cfsqltype="CF_SQL_VARCHAR" />
				  and FinalComments = <cfqueryparam value="#local120#" cfsqltype="CF_SQL_VARCHAR" />
				  and Approved = <cfqueryparam value="#local121#" cfsqltype="CF_SQL_BIT" null="#iif((local121 eq ""), de("yes"), de("no"))#" />
				  and CheckCut = <cfqueryparam value="#local122#" cfsqltype="CF_SQL_BIT" null="#iif((local122 eq ""), de("yes"), de("no"))#" />
				  and BonusLead = <cfqueryparam value="#local123#" cfsqltype="CF_SQL_BIT" null="#iif((local123 eq ""), de("yes"), de("no"))#" />
				  and Bonus = <cfqueryparam value="#local124#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local124 eq ""), de("yes"), de("no"))#" />
				  and SentDate = <cfqueryparam value="#local125#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local125 eq ""), de("yes"), de("no"))#" />
				  and CheckReceived = <cfqueryparam value="#local126#" cfsqltype="CF_SQL_BIT" null="#iif((local126 eq ""), de("yes"), de("no"))#" />
				  and WorkingHotel = <cfqueryparam value="#local127#" cfsqltype="CF_SQL_VARCHAR" />
				  and DefPerson = <cfqueryparam value="#local128#" cfsqltype="CF_SQL_INTEGER" null="#iif((local128 eq ""), de("yes"), de("no"))#" />
				  and ApprovPerson = <cfqueryparam value="#local129#" cfsqltype="CF_SQL_INTEGER" null="#iif((local129 eq ""), de("yes"), de("no"))#" />
				  and Extended_Stay = <cfqueryparam value="#local130#" cfsqltype="CF_SQL_BIT" null="#iif((local130 eq ""), de("yes"), de("no"))#" />
				  and Nights = <cfqueryparam value="#local131#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local131 eq ""), de("yes"), de("no"))#" />
				  and PrePayment = <cfqueryparam value="#local132#" cfsqltype="CF_SQL_FLOAT" null="#iif((local132 eq ""), de("yes"), de("no"))#" />
				  and TtlPrePayment = <cfqueryparam value="#local133#" cfsqltype="CF_SQL_FLOAT" null="#iif((local133 eq ""), de("yes"), de("no"))#" />
				  and LastPrePaymentDate = <cfqueryparam value="#local134#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local134 eq ""), de("yes"), de("no"))#" />
				  and WorkingManagerID = <cfqueryparam value="#local135#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local135 eq ""), de("yes"), de("no"))#" />
				  and Hotelogic = <cfqueryparam value="#local136#" cfsqltype="CF_SQL_BIT" null="#iif((local136 eq ""), de("yes"), de("no"))#" />
				  and LG = <cfqueryparam value="#local137#" cfsqltype="CF_SQL_INTEGER" null="#iif((local137 eq ""), de("yes"), de("no"))#" />
				  and BizType = <cfqueryparam value="#local138#" cfsqltype="CF_SQL_VARCHAR" />
				  and HotLeads = <cfqueryparam value="#local139#" cfsqltype="CF_SQL_BIT" null="#iif((local139 eq ""), de("yes"), de("no"))#" />
				  and Prospect = <cfqueryparam value="#local140#" cfsqltype="CF_SQL_BIT" null="#iif((local140 eq ""), de("yes"), de("no"))#" />
				order by ID desc
			</cfquery>
		</cftransaction>

		<cfscript>
			arguments.bean.setID(qGetID.ID);
		</cfscript>
		<cfreturn arguments.bean />
	</cffunction>



	<cffunction name="update" output="false" access="public">
		<cfargument name="oldBean" required="true" type="com.adobe.leadgine.Referrals">
		<cfargument name="newBean" required="true" type="com.adobe.leadgine.Referrals">
		<cfset var qUpdate="">

		<cfquery name="qUpdate" datasource="revpar" result="status">
			update dbo.Referrals
			set Company = <cfqueryparam value="#arguments.newBean.getCompany()#" cfsqltype="CF_SQL_VARCHAR" />,
				myEvent = <cfqueryparam value="#arguments.newBean.getmyEvent()#" cfsqltype="CF_SQL_VARCHAR" />,
				Decision = <cfqueryparam value="#arguments.newBean.getDecision()#" cfsqltype="CF_SQL_VARCHAR" />,
				Attendees = <cfqueryparam value="#arguments.newBean.getAttendees()#" cfsqltype="CF_SQL_INTEGER" null="#iif((arguments.newBean.getAttendees() eq ""), de("yes"), de("no"))#" />,
				Contact = <cfqueryparam value="#arguments.newBean.getContact()#" cfsqltype="CF_SQL_VARCHAR" />,
				myTitle = <cfqueryparam value="#arguments.newBean.getmyTitle()#" cfsqltype="CF_SQL_VARCHAR" />,
				Address1 = <cfqueryparam value="#arguments.newBean.getAddress1()#" cfsqltype="CF_SQL_VARCHAR" />,
				Address2 = <cfqueryparam value="#arguments.newBean.getAddress2()#" cfsqltype="CF_SQL_VARCHAR" />,
				City = <cfqueryparam value="#arguments.newBean.getCity()#" cfsqltype="CF_SQL_VARCHAR" />,
				State = <cfqueryparam value="#arguments.newBean.getState()#" cfsqltype="CF_SQL_VARCHAR" />,
				Zip = <cfqueryparam value="#arguments.newBean.getZip()#" cfsqltype="CF_SQL_VARCHAR" />,
				Country = <cfqueryparam value="#arguments.newBean.getCountry()#" cfsqltype="CF_SQL_VARCHAR" />,
				Email = <cfqueryparam value="#arguments.newBean.getEmail()#" cfsqltype="CF_SQL_VARCHAR" />,
				Commissionable = <cfqueryparam value="#arguments.newBean.getCommissionable()#" cfsqltype="CF_SQL_BIT" null="#iif((arguments.newBean.getCommissionable() eq ""), de("yes"), de("no"))#" />,
				Commission = <cfqueryparam value="#arguments.newBean.getCommission()#" cfsqltype="CF_SQL_VARCHAR" />,
				IATA = <cfqueryparam value="#arguments.newBean.getIATA()#" cfsqltype="CF_SQL_VARCHAR" />,
				Rate = <cfqueryparam value="#arguments.newBean.getRate()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getRate() eq ""), de("yes"), de("no"))#" />,
				Phone = <cfqueryparam value="#arguments.newBean.getPhone()#" cfsqltype="CF_SQL_VARCHAR" />,
				Fax = <cfqueryparam value="#arguments.newBean.getFax()#" cfsqltype="CF_SQL_VARCHAR" />,
				Date1 = <cfqueryparam value="#arguments.newBean.getDate1()#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((arguments.newBean.getDate1() eq ""), de("yes"), de("no"))#" />,
				Date2 = <cfqueryparam value="#arguments.newBean.getDate2()#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((arguments.newBean.getDate2() eq ""), de("yes"), de("no"))#" />,
				Date3 = <cfqueryparam value="#arguments.newBean.getDate3()#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((arguments.newBean.getDate3() eq ""), de("yes"), de("no"))#" />,
				Date4 = <cfqueryparam value="#arguments.newBean.getDate4()#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((arguments.newBean.getDate4() eq ""), de("yes"), de("no"))#" />,
				Date5 = <cfqueryparam value="#arguments.newBean.getDate5()#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((arguments.newBean.getDate5() eq ""), de("yes"), de("no"))#" />,
				Date6 = <cfqueryparam value="#arguments.newBean.getDate6()#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((arguments.newBean.getDate6() eq ""), de("yes"), de("no"))#" />,
				Date7 = <cfqueryparam value="#arguments.newBean.getDate7()#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((arguments.newBean.getDate7() eq ""), de("yes"), de("no"))#" />,
				Single1 = <cfqueryparam value="#arguments.newBean.getSingle1()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getSingle1() eq ""), de("yes"), de("no"))#" />,
				Single2 = <cfqueryparam value="#arguments.newBean.getSingle2()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getSingle2() eq ""), de("yes"), de("no"))#" />,
				Single3 = <cfqueryparam value="#arguments.newBean.getSingle3()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getSingle3() eq ""), de("yes"), de("no"))#" />,
				Single4 = <cfqueryparam value="#arguments.newBean.getSingle4()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getSingle4() eq ""), de("yes"), de("no"))#" />,
				Single5 = <cfqueryparam value="#arguments.newBean.getSingle5()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getSingle5() eq ""), de("yes"), de("no"))#" />,
				Single6 = <cfqueryparam value="#arguments.newBean.getSingle6()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getSingle6() eq ""), de("yes"), de("no"))#" />,
				Single7 = <cfqueryparam value="#arguments.newBean.getSingle7()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getSingle7() eq ""), de("yes"), de("no"))#" />,
				SingleTotal = <cfqueryparam value="#arguments.newBean.getSingleTotal()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getSingleTotal() eq ""), de("yes"), de("no"))#" />,
				Double1 = <cfqueryparam value="#arguments.newBean.getDouble1()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getDouble1() eq ""), de("yes"), de("no"))#" />,
				Double2 = <cfqueryparam value="#arguments.newBean.getDouble2()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getDouble2() eq ""), de("yes"), de("no"))#" />,
				Double3 = <cfqueryparam value="#arguments.newBean.getDouble3()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getDouble3() eq ""), de("yes"), de("no"))#" />,
				Double4 = <cfqueryparam value="#arguments.newBean.getDouble4()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getDouble4() eq ""), de("yes"), de("no"))#" />,
				Double5 = <cfqueryparam value="#arguments.newBean.getDouble5()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getDouble5() eq ""), de("yes"), de("no"))#" />,
				Double6 = <cfqueryparam value="#arguments.newBean.getDouble6()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getDouble6() eq ""), de("yes"), de("no"))#" />,
				Double7 = <cfqueryparam value="#arguments.newBean.getDouble7()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getDouble7() eq ""), de("yes"), de("no"))#" />,
				DoubleTotal = <cfqueryparam value="#arguments.newBean.getDoubleTotal()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getDoubleTotal() eq ""), de("yes"), de("no"))#" />,
				Total1 = <cfqueryparam value="#arguments.newBean.getTotal1()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getTotal1() eq ""), de("yes"), de("no"))#" />,
				Total2 = <cfqueryparam value="#arguments.newBean.getTotal2()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getTotal2() eq ""), de("yes"), de("no"))#" />,
				Total3 = <cfqueryparam value="#arguments.newBean.getTotal3()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getTotal3() eq ""), de("yes"), de("no"))#" />,
				Total4 = <cfqueryparam value="#arguments.newBean.getTotal4()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getTotal4() eq ""), de("yes"), de("no"))#" />,
				Total5 = <cfqueryparam value="#arguments.newBean.getTotal5()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getTotal5() eq ""), de("yes"), de("no"))#" />,
				Total6 = <cfqueryparam value="#arguments.newBean.getTotal6()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getTotal6() eq ""), de("yes"), de("no"))#" />,
				Total7 = <cfqueryparam value="#arguments.newBean.getTotal7()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getTotal7() eq ""), de("yes"), de("no"))#" />,
				TotalTotal = <cfqueryparam value="#arguments.newBean.getTotalTotal()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getTotalTotal() eq ""), de("yes"), de("no"))#" />,
				Start1 = <cfqueryparam value="#arguments.newBean.getStart1()#" cfsqltype="CF_SQL_VARCHAR" />,
				Start2 = <cfqueryparam value="#arguments.newBean.getStart2()#" cfsqltype="CF_SQL_VARCHAR" />,
				Start3 = <cfqueryparam value="#arguments.newBean.getStart3()#" cfsqltype="CF_SQL_VARCHAR" />,
				Start4 = <cfqueryparam value="#arguments.newBean.getStart4()#" cfsqltype="CF_SQL_VARCHAR" />,
				Start5 = <cfqueryparam value="#arguments.newBean.getStart5()#" cfsqltype="CF_SQL_VARCHAR" />,
				Start6 = <cfqueryparam value="#arguments.newBean.getStart6()#" cfsqltype="CF_SQL_VARCHAR" />,
				Start7 = <cfqueryparam value="#arguments.newBean.getStart7()#" cfsqltype="CF_SQL_VARCHAR" />,
				End1 = <cfqueryparam value="#arguments.newBean.getEnd1()#" cfsqltype="CF_SQL_VARCHAR" />,
				End2 = <cfqueryparam value="#arguments.newBean.getEnd2()#" cfsqltype="CF_SQL_VARCHAR" />,
				End3 = <cfqueryparam value="#arguments.newBean.getEnd3()#" cfsqltype="CF_SQL_VARCHAR" />,
				End4 = <cfqueryparam value="#arguments.newBean.getEnd4()#" cfsqltype="CF_SQL_VARCHAR" />,
				End5 = <cfqueryparam value="#arguments.newBean.getEnd5()#" cfsqltype="CF_SQL_VARCHAR" />,
				End6 = <cfqueryparam value="#arguments.newBean.getEnd6()#" cfsqltype="CF_SQL_VARCHAR" />,
				End7 = <cfqueryparam value="#arguments.newBean.getEnd7()#" cfsqltype="CF_SQL_VARCHAR" />,
				Func1 = <cfqueryparam value="#arguments.newBean.getFunc1()#" cfsqltype="CF_SQL_VARCHAR" />,
				Func2 = <cfqueryparam value="#arguments.newBean.getFunc2()#" cfsqltype="CF_SQL_VARCHAR" />,
				Func3 = <cfqueryparam value="#arguments.newBean.getFunc3()#" cfsqltype="CF_SQL_VARCHAR" />,
				Func4 = <cfqueryparam value="#arguments.newBean.getFunc4()#" cfsqltype="CF_SQL_VARCHAR" />,
				Func5 = <cfqueryparam value="#arguments.newBean.getFunc5()#" cfsqltype="CF_SQL_VARCHAR" />,
				Func6 = <cfqueryparam value="#arguments.newBean.getFunc6()#" cfsqltype="CF_SQL_VARCHAR" />,
				Func7 = <cfqueryparam value="#arguments.newBean.getFunc7()#" cfsqltype="CF_SQL_VARCHAR" />,
				Ppl1 = <cfqueryparam value="#arguments.newBean.getPpl1()#" cfsqltype="CF_SQL_VARCHAR" />,
				Ppl2 = <cfqueryparam value="#arguments.newBean.getPpl2()#" cfsqltype="CF_SQL_VARCHAR" />,
				Ppl3 = <cfqueryparam value="#arguments.newBean.getPpl3()#" cfsqltype="CF_SQL_VARCHAR" />,
				Ppl4 = <cfqueryparam value="#arguments.newBean.getPpl4()#" cfsqltype="CF_SQL_VARCHAR" />,
				Ppl5 = <cfqueryparam value="#arguments.newBean.getPpl5()#" cfsqltype="CF_SQL_VARCHAR" />,
				Ppl6 = <cfqueryparam value="#arguments.newBean.getPpl6()#" cfsqltype="CF_SQL_VARCHAR" />,
				Ppl7 = <cfqueryparam value="#arguments.newBean.getPpl7()#" cfsqltype="CF_SQL_VARCHAR" />,
				Setup1 = <cfqueryparam value="#arguments.newBean.getSetup1()#" cfsqltype="CF_SQL_VARCHAR" />,
				Setup2 = <cfqueryparam value="#arguments.newBean.getSetup2()#" cfsqltype="CF_SQL_VARCHAR" />,
				Setup3 = <cfqueryparam value="#arguments.newBean.getSetup3()#" cfsqltype="CF_SQL_VARCHAR" />,
				Setup4 = <cfqueryparam value="#arguments.newBean.getSetup4()#" cfsqltype="CF_SQL_VARCHAR" />,
				Setup5 = <cfqueryparam value="#arguments.newBean.getSetup5()#" cfsqltype="CF_SQL_VARCHAR" />,
				Setup6 = <cfqueryparam value="#arguments.newBean.getSetup6()#" cfsqltype="CF_SQL_VARCHAR" />,
				Setup7 = <cfqueryparam value="#arguments.newBean.getSetup7()#" cfsqltype="CF_SQL_VARCHAR" />,
				FBComments1 = <cfqueryparam value="#arguments.newBean.getFBComments1()#" cfsqltype="CF_SQL_VARCHAR" />,
				FBComments2 = <cfqueryparam value="#arguments.newBean.getFBComments2()#" cfsqltype="CF_SQL_VARCHAR" />,
				FBComments3 = <cfqueryparam value="#arguments.newBean.getFBComments3()#" cfsqltype="CF_SQL_VARCHAR" />,
				FBComments4 = <cfqueryparam value="#arguments.newBean.getFBComments4()#" cfsqltype="CF_SQL_VARCHAR" />,
				FBComments5 = <cfqueryparam value="#arguments.newBean.getFBComments5()#" cfsqltype="CF_SQL_VARCHAR" />,
				FBComments6 = <cfqueryparam value="#arguments.newBean.getFBComments6()#" cfsqltype="CF_SQL_VARCHAR" />,
				FBComments7 = <cfqueryparam value="#arguments.newBean.getFBComments7()#" cfsqltype="CF_SQL_VARCHAR" />,
				CateringRev1 = <cfqueryparam value="#arguments.newBean.getCateringRev1()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getCateringRev1() eq ""), de("yes"), de("no"))#" />,
				CateringRev2 = <cfqueryparam value="#arguments.newBean.getCateringRev2()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getCateringRev2() eq ""), de("yes"), de("no"))#" />,
				CateringRev3 = <cfqueryparam value="#arguments.newBean.getCateringRev3()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getCateringRev3() eq ""), de("yes"), de("no"))#" />,
				CateringRev4 = <cfqueryparam value="#arguments.newBean.getCateringRev4()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getCateringRev4() eq ""), de("yes"), de("no"))#" />,
				CateringRev5 = <cfqueryparam value="#arguments.newBean.getCateringRev5()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getCateringRev5() eq ""), de("yes"), de("no"))#" />,
				CateringRev6 = <cfqueryparam value="#arguments.newBean.getCateringRev6()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getCateringRev6() eq ""), de("yes"), de("no"))#" />,
				CateringRev7 = <cfqueryparam value="#arguments.newBean.getCateringRev7()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getCateringRev7() eq ""), de("yes"), de("no"))#" />,
				CateringRevTtl = <cfqueryparam value="#arguments.newBean.getCateringRevTtl()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getCateringRevTtl() eq ""), de("yes"), de("no"))#" />,
				RentRev1 = <cfqueryparam value="#arguments.newBean.getRentRev1()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getRentRev1() eq ""), de("yes"), de("no"))#" />,
				RentRev2 = <cfqueryparam value="#arguments.newBean.getRentRev2()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getRentRev2() eq ""), de("yes"), de("no"))#" />,
				RentRev3 = <cfqueryparam value="#arguments.newBean.getRentRev3()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getRentRev3() eq ""), de("yes"), de("no"))#" />,
				RentRev4 = <cfqueryparam value="#arguments.newBean.getRentRev4()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getRentRev4() eq ""), de("yes"), de("no"))#" />,
				RentRev5 = <cfqueryparam value="#arguments.newBean.getRentRev5()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getRentRev5() eq ""), de("yes"), de("no"))#" />,
				RentRev6 = <cfqueryparam value="#arguments.newBean.getRentRev6()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getRentRev6() eq ""), de("yes"), de("no"))#" />,
				RentRev7 = <cfqueryparam value="#arguments.newBean.getRentRev7()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getRentRev7() eq ""), de("yes"), de("no"))#" />,
				RentRevTtl = <cfqueryparam value="#arguments.newBean.getRentRevTtl()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getRentRevTtl() eq ""), de("yes"), de("no"))#" />,
				SpecialComments = <cfqueryparam value="#arguments.newBean.getSpecialComments()#" cfsqltype="CF_SQL_VARCHAR" />,
				Requests = <cfqueryparam value="#arguments.newBean.getRequests()#" cfsqltype="CF_SQL_VARCHAR" />,
				Hotels = <cfqueryparam value="#arguments.newBean.getHotels()#" cfsqltype="CF_SQL_VARCHAR" />,
				RefHotel = <cfqueryparam value="#arguments.newBean.getRefHotel()#" cfsqltype="CF_SQL_VARCHAR" />,
				RefUserID = <cfqueryparam value="#arguments.newBean.getRefUserID()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getRefUserID() eq ""), de("yes"), de("no"))#" />,
				RmRevenue = <cfqueryparam value="#arguments.newBean.getRmRevenue()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getRmRevenue() eq ""), de("yes"), de("no"))#" />,
				myStatus = <cfqueryparam value="#arguments.newBean.getmyStatus()#" cfsqltype="CF_SQL_VARCHAR" />,
				CheckedOut = <cfqueryparam value="#arguments.newBean.getCheckedOut()#" cfsqltype="CF_SQL_BIT" null="#iif((arguments.newBean.getCheckedOut() eq ""), de("yes"), de("no"))#" />,
				CheckOutDate = <cfqueryparam value="#arguments.newBean.getCheckOutDate()#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((arguments.newBean.getCheckOutDate() eq ""), de("yes"), de("no"))#" />,
				DefiniteDate = <cfqueryparam value="#arguments.newBean.getDefiniteDate()#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((arguments.newBean.getDefiniteDate() eq ""), de("yes"), de("no"))#" />,
				Rejection = <cfqueryparam value="#arguments.newBean.getRejection()#" cfsqltype="CF_SQL_VARCHAR" />,
				FinalComments = <cfqueryparam value="#arguments.newBean.getFinalComments()#" cfsqltype="CF_SQL_VARCHAR" />,
				Approved = <cfqueryparam value="#arguments.newBean.getApproved()#" cfsqltype="CF_SQL_BIT" null="#iif((arguments.newBean.getApproved() eq ""), de("yes"), de("no"))#" />,
				CheckCut = <cfqueryparam value="#arguments.newBean.getCheckCut()#" cfsqltype="CF_SQL_BIT" null="#iif((arguments.newBean.getCheckCut() eq ""), de("yes"), de("no"))#" />,
				BonusLead = <cfqueryparam value="#arguments.newBean.getBonusLead()#" cfsqltype="CF_SQL_BIT" null="#iif((arguments.newBean.getBonusLead() eq ""), de("yes"), de("no"))#" />,
				Bonus = <cfqueryparam value="#arguments.newBean.getBonus()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getBonus() eq ""), de("yes"), de("no"))#" />,
				SentDate = <cfqueryparam value="#arguments.newBean.getSentDate()#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((arguments.newBean.getSentDate() eq ""), de("yes"), de("no"))#" />,
				CheckReceived = <cfqueryparam value="#arguments.newBean.getCheckReceived()#" cfsqltype="CF_SQL_BIT" null="#iif((arguments.newBean.getCheckReceived() eq ""), de("yes"), de("no"))#" />,
				WorkingHotel = <cfqueryparam value="#arguments.newBean.getWorkingHotel()#" cfsqltype="CF_SQL_VARCHAR" />,
				DefPerson = <cfqueryparam value="#arguments.newBean.getDefPerson()#" cfsqltype="CF_SQL_INTEGER" null="#iif((arguments.newBean.getDefPerson() eq ""), de("yes"), de("no"))#" />,
				ApprovPerson = <cfqueryparam value="#arguments.newBean.getApprovPerson()#" cfsqltype="CF_SQL_INTEGER" null="#iif((arguments.newBean.getApprovPerson() eq ""), de("yes"), de("no"))#" />,
				Extended_Stay = <cfqueryparam value="#arguments.newBean.getExtended_Stay()#" cfsqltype="CF_SQL_BIT" null="#iif((arguments.newBean.getExtended_Stay() eq ""), de("yes"), de("no"))#" />,
				Nights = <cfqueryparam value="#arguments.newBean.getNights()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getNights() eq ""), de("yes"), de("no"))#" />,
				PrePayment = <cfqueryparam value="#arguments.newBean.getPrePayment()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getPrePayment() eq ""), de("yes"), de("no"))#" />,
				TtlPrePayment = <cfqueryparam value="#arguments.newBean.getTtlPrePayment()#" cfsqltype="CF_SQL_FLOAT" null="#iif((arguments.newBean.getTtlPrePayment() eq ""), de("yes"), de("no"))#" />,
				LastPrePaymentDate = <cfqueryparam value="#arguments.newBean.getLastPrePaymentDate()#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((arguments.newBean.getLastPrePaymentDate() eq ""), de("yes"), de("no"))#" />,
				WorkingManagerID = <cfqueryparam value="#arguments.newBean.getWorkingManagerID()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getWorkingManagerID() eq ""), de("yes"), de("no"))#" />,
				Hotelogic = <cfqueryparam value="#arguments.newBean.getHotelogic()#" cfsqltype="CF_SQL_BIT" null="#iif((arguments.newBean.getHotelogic() eq ""), de("yes"), de("no"))#" />,
				LG = <cfqueryparam value="#arguments.newBean.getLG()#" cfsqltype="CF_SQL_INTEGER" null="#iif((arguments.newBean.getLG() eq ""), de("yes"), de("no"))#" />,
				BizType = <cfqueryparam value="#arguments.newBean.getBizType()#" cfsqltype="CF_SQL_VARCHAR" />,
				HotLeads = <cfqueryparam value="#arguments.newBean.getHotLeads()#" cfsqltype="CF_SQL_BIT" null="#iif((arguments.newBean.getHotLeads() eq ""), de("yes"), de("no"))#" />,
				Prospect = <cfqueryparam value="#arguments.newBean.getProspect()#" cfsqltype="CF_SQL_BIT" null="#iif((arguments.newBean.getProspect() eq ""), de("yes"), de("no"))#" />
			where ID = <cfqueryparam value="#arguments.oldBean.getID()#" cfsqltype="CF_SQL_BIGINT" />
			  and Company = <cfqueryparam value="#arguments.oldBean.getCompany()#" cfsqltype="CF_SQL_VARCHAR" />
			  and myEvent = <cfqueryparam value="#arguments.oldBean.getmyEvent()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Decision = <cfqueryparam value="#arguments.oldBean.getDecision()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Attendees = <cfqueryparam value="#arguments.oldBean.getAttendees()#" cfsqltype="CF_SQL_INTEGER" />
			  and Contact = <cfqueryparam value="#arguments.oldBean.getContact()#" cfsqltype="CF_SQL_VARCHAR" />
			  and myTitle = <cfqueryparam value="#arguments.oldBean.getmyTitle()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Address1 = <cfqueryparam value="#arguments.oldBean.getAddress1()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Address2 = <cfqueryparam value="#arguments.oldBean.getAddress2()#" cfsqltype="CF_SQL_VARCHAR" />
			  and City = <cfqueryparam value="#arguments.oldBean.getCity()#" cfsqltype="CF_SQL_VARCHAR" />
			  and State = <cfqueryparam value="#arguments.oldBean.getState()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Zip = <cfqueryparam value="#arguments.oldBean.getZip()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Country = <cfqueryparam value="#arguments.oldBean.getCountry()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Email = <cfqueryparam value="#arguments.oldBean.getEmail()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Commissionable = <cfqueryparam value="#arguments.oldBean.getCommissionable()#" cfsqltype="CF_SQL_BIT" />
			  and Commission = <cfqueryparam value="#arguments.oldBean.getCommission()#" cfsqltype="CF_SQL_VARCHAR" />
			  and IATA = <cfqueryparam value="#arguments.oldBean.getIATA()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Rate = <cfqueryparam value="#arguments.oldBean.getRate()#" cfsqltype="CF_SQL_FLOAT" />
			  and Phone = <cfqueryparam value="#arguments.oldBean.getPhone()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Fax = <cfqueryparam value="#arguments.oldBean.getFax()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Date1 = <cfqueryparam value="#arguments.oldBean.getDate1()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and Date2 = <cfqueryparam value="#arguments.oldBean.getDate2()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and Date3 = <cfqueryparam value="#arguments.oldBean.getDate3()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and Date4 = <cfqueryparam value="#arguments.oldBean.getDate4()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and Date5 = <cfqueryparam value="#arguments.oldBean.getDate5()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and Date6 = <cfqueryparam value="#arguments.oldBean.getDate6()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and Date7 = <cfqueryparam value="#arguments.oldBean.getDate7()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and Single1 = <cfqueryparam value="#arguments.oldBean.getSingle1()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Single2 = <cfqueryparam value="#arguments.oldBean.getSingle2()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Single3 = <cfqueryparam value="#arguments.oldBean.getSingle3()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Single4 = <cfqueryparam value="#arguments.oldBean.getSingle4()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Single5 = <cfqueryparam value="#arguments.oldBean.getSingle5()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Single6 = <cfqueryparam value="#arguments.oldBean.getSingle6()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Single7 = <cfqueryparam value="#arguments.oldBean.getSingle7()#" cfsqltype="CF_SQL_SMALLINT" />
			  and SingleTotal = <cfqueryparam value="#arguments.oldBean.getSingleTotal()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Double1 = <cfqueryparam value="#arguments.oldBean.getDouble1()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Double2 = <cfqueryparam value="#arguments.oldBean.getDouble2()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Double3 = <cfqueryparam value="#arguments.oldBean.getDouble3()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Double4 = <cfqueryparam value="#arguments.oldBean.getDouble4()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Double5 = <cfqueryparam value="#arguments.oldBean.getDouble5()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Double6 = <cfqueryparam value="#arguments.oldBean.getDouble6()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Double7 = <cfqueryparam value="#arguments.oldBean.getDouble7()#" cfsqltype="CF_SQL_SMALLINT" />
			  and DoubleTotal = <cfqueryparam value="#arguments.oldBean.getDoubleTotal()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Total1 = <cfqueryparam value="#arguments.oldBean.getTotal1()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Total2 = <cfqueryparam value="#arguments.oldBean.getTotal2()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Total3 = <cfqueryparam value="#arguments.oldBean.getTotal3()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Total4 = <cfqueryparam value="#arguments.oldBean.getTotal4()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Total5 = <cfqueryparam value="#arguments.oldBean.getTotal5()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Total6 = <cfqueryparam value="#arguments.oldBean.getTotal6()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Total7 = <cfqueryparam value="#arguments.oldBean.getTotal7()#" cfsqltype="CF_SQL_SMALLINT" />
			  and TotalTotal = <cfqueryparam value="#arguments.oldBean.getTotalTotal()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Start1 = <cfqueryparam value="#arguments.oldBean.getStart1()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Start2 = <cfqueryparam value="#arguments.oldBean.getStart2()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Start3 = <cfqueryparam value="#arguments.oldBean.getStart3()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Start4 = <cfqueryparam value="#arguments.oldBean.getStart4()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Start5 = <cfqueryparam value="#arguments.oldBean.getStart5()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Start6 = <cfqueryparam value="#arguments.oldBean.getStart6()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Start7 = <cfqueryparam value="#arguments.oldBean.getStart7()#" cfsqltype="CF_SQL_VARCHAR" />
			  and End1 = <cfqueryparam value="#arguments.oldBean.getEnd1()#" cfsqltype="CF_SQL_VARCHAR" />
			  and End2 = <cfqueryparam value="#arguments.oldBean.getEnd2()#" cfsqltype="CF_SQL_VARCHAR" />
			  and End3 = <cfqueryparam value="#arguments.oldBean.getEnd3()#" cfsqltype="CF_SQL_VARCHAR" />
			  and End4 = <cfqueryparam value="#arguments.oldBean.getEnd4()#" cfsqltype="CF_SQL_VARCHAR" />
			  and End5 = <cfqueryparam value="#arguments.oldBean.getEnd5()#" cfsqltype="CF_SQL_VARCHAR" />
			  and End6 = <cfqueryparam value="#arguments.oldBean.getEnd6()#" cfsqltype="CF_SQL_VARCHAR" />
			  and End7 = <cfqueryparam value="#arguments.oldBean.getEnd7()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Func1 = <cfqueryparam value="#arguments.oldBean.getFunc1()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Func2 = <cfqueryparam value="#arguments.oldBean.getFunc2()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Func3 = <cfqueryparam value="#arguments.oldBean.getFunc3()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Func4 = <cfqueryparam value="#arguments.oldBean.getFunc4()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Func5 = <cfqueryparam value="#arguments.oldBean.getFunc5()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Func6 = <cfqueryparam value="#arguments.oldBean.getFunc6()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Func7 = <cfqueryparam value="#arguments.oldBean.getFunc7()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Ppl1 = <cfqueryparam value="#arguments.oldBean.getPpl1()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Ppl2 = <cfqueryparam value="#arguments.oldBean.getPpl2()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Ppl3 = <cfqueryparam value="#arguments.oldBean.getPpl3()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Ppl4 = <cfqueryparam value="#arguments.oldBean.getPpl4()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Ppl5 = <cfqueryparam value="#arguments.oldBean.getPpl5()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Ppl6 = <cfqueryparam value="#arguments.oldBean.getPpl6()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Ppl7 = <cfqueryparam value="#arguments.oldBean.getPpl7()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Setup1 = <cfqueryparam value="#arguments.oldBean.getSetup1()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Setup2 = <cfqueryparam value="#arguments.oldBean.getSetup2()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Setup3 = <cfqueryparam value="#arguments.oldBean.getSetup3()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Setup4 = <cfqueryparam value="#arguments.oldBean.getSetup4()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Setup5 = <cfqueryparam value="#arguments.oldBean.getSetup5()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Setup6 = <cfqueryparam value="#arguments.oldBean.getSetup6()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Setup7 = <cfqueryparam value="#arguments.oldBean.getSetup7()#" cfsqltype="CF_SQL_VARCHAR" />
			  and FBComments1 = <cfqueryparam value="#arguments.oldBean.getFBComments1()#" cfsqltype="CF_SQL_VARCHAR" />
			  and FBComments2 = <cfqueryparam value="#arguments.oldBean.getFBComments2()#" cfsqltype="CF_SQL_VARCHAR" />
			  and FBComments3 = <cfqueryparam value="#arguments.oldBean.getFBComments3()#" cfsqltype="CF_SQL_VARCHAR" />
			  and FBComments4 = <cfqueryparam value="#arguments.oldBean.getFBComments4()#" cfsqltype="CF_SQL_VARCHAR" />
			  and FBComments5 = <cfqueryparam value="#arguments.oldBean.getFBComments5()#" cfsqltype="CF_SQL_VARCHAR" />
			  and FBComments6 = <cfqueryparam value="#arguments.oldBean.getFBComments6()#" cfsqltype="CF_SQL_VARCHAR" />
			  and FBComments7 = <cfqueryparam value="#arguments.oldBean.getFBComments7()#" cfsqltype="CF_SQL_VARCHAR" />
			  and CateringRev1 = <cfqueryparam value="#arguments.oldBean.getCateringRev1()#" cfsqltype="CF_SQL_FLOAT" />
			  and CateringRev2 = <cfqueryparam value="#arguments.oldBean.getCateringRev2()#" cfsqltype="CF_SQL_FLOAT" />
			  and CateringRev3 = <cfqueryparam value="#arguments.oldBean.getCateringRev3()#" cfsqltype="CF_SQL_FLOAT" />
			  and CateringRev4 = <cfqueryparam value="#arguments.oldBean.getCateringRev4()#" cfsqltype="CF_SQL_FLOAT" />
			  and CateringRev5 = <cfqueryparam value="#arguments.oldBean.getCateringRev5()#" cfsqltype="CF_SQL_FLOAT" />
			  and CateringRev6 = <cfqueryparam value="#arguments.oldBean.getCateringRev6()#" cfsqltype="CF_SQL_FLOAT" />
			  and CateringRev7 = <cfqueryparam value="#arguments.oldBean.getCateringRev7()#" cfsqltype="CF_SQL_FLOAT" />
			  and CateringRevTtl = <cfqueryparam value="#arguments.oldBean.getCateringRevTtl()#" cfsqltype="CF_SQL_FLOAT" />
			  and RentRev1 = <cfqueryparam value="#arguments.oldBean.getRentRev1()#" cfsqltype="CF_SQL_FLOAT" />
			  and RentRev2 = <cfqueryparam value="#arguments.oldBean.getRentRev2()#" cfsqltype="CF_SQL_FLOAT" />
			  and RentRev3 = <cfqueryparam value="#arguments.oldBean.getRentRev3()#" cfsqltype="CF_SQL_FLOAT" />
			  and RentRev4 = <cfqueryparam value="#arguments.oldBean.getRentRev4()#" cfsqltype="CF_SQL_FLOAT" />
			  and RentRev5 = <cfqueryparam value="#arguments.oldBean.getRentRev5()#" cfsqltype="CF_SQL_FLOAT" />
			  and RentRev6 = <cfqueryparam value="#arguments.oldBean.getRentRev6()#" cfsqltype="CF_SQL_FLOAT" />
			  and RentRev7 = <cfqueryparam value="#arguments.oldBean.getRentRev7()#" cfsqltype="CF_SQL_FLOAT" />
			  and RentRevTtl = <cfqueryparam value="#arguments.oldBean.getRentRevTtl()#" cfsqltype="CF_SQL_FLOAT" />
			  and SpecialComments = <cfqueryparam value="#arguments.oldBean.getSpecialComments()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Requests = <cfqueryparam value="#arguments.oldBean.getRequests()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Hotels = <cfqueryparam value="#arguments.oldBean.getHotels()#" cfsqltype="CF_SQL_VARCHAR" />
			  and RefHotel = <cfqueryparam value="#arguments.oldBean.getRefHotel()#" cfsqltype="CF_SQL_VARCHAR" />
			  and RefUserID = <cfqueryparam value="#arguments.oldBean.getRefUserID()#" cfsqltype="CF_SQL_SMALLINT" />
			  and RmRevenue = <cfqueryparam value="#arguments.oldBean.getRmRevenue()#" cfsqltype="CF_SQL_FLOAT" />
			  and myStatus = <cfqueryparam value="#arguments.oldBean.getmyStatus()#" cfsqltype="CF_SQL_VARCHAR" />
			  and CheckedOut = <cfqueryparam value="#arguments.oldBean.getCheckedOut()#" cfsqltype="CF_SQL_BIT" />
			  and CheckOutDate = <cfqueryparam value="#arguments.oldBean.getCheckOutDate()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and DefiniteDate = <cfqueryparam value="#arguments.oldBean.getDefiniteDate()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and Rejection = <cfqueryparam value="#arguments.oldBean.getRejection()#" cfsqltype="CF_SQL_VARCHAR" />
			  and FinalComments = <cfqueryparam value="#arguments.oldBean.getFinalComments()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Approved = <cfqueryparam value="#arguments.oldBean.getApproved()#" cfsqltype="CF_SQL_BIT" />
			  and CheckCut = <cfqueryparam value="#arguments.oldBean.getCheckCut()#" cfsqltype="CF_SQL_BIT" />
			  and BonusLead = <cfqueryparam value="#arguments.oldBean.getBonusLead()#" cfsqltype="CF_SQL_BIT" />
			  and Bonus = <cfqueryparam value="#arguments.oldBean.getBonus()#" cfsqltype="CF_SQL_SMALLINT" />
			  and SentDate = <cfqueryparam value="#arguments.oldBean.getSentDate()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and CheckReceived = <cfqueryparam value="#arguments.oldBean.getCheckReceived()#" cfsqltype="CF_SQL_BIT" />
			  and WorkingHotel = <cfqueryparam value="#arguments.oldBean.getWorkingHotel()#" cfsqltype="CF_SQL_VARCHAR" />
			  and DefPerson = <cfqueryparam value="#arguments.oldBean.getDefPerson()#" cfsqltype="CF_SQL_INTEGER" />
			  and ApprovPerson = <cfqueryparam value="#arguments.oldBean.getApprovPerson()#" cfsqltype="CF_SQL_INTEGER" />
			  and Extended_Stay = <cfqueryparam value="#arguments.oldBean.getExtended_Stay()#" cfsqltype="CF_SQL_BIT" />
			  and Nights = <cfqueryparam value="#arguments.oldBean.getNights()#" cfsqltype="CF_SQL_SMALLINT" />
			  and PrePayment = <cfqueryparam value="#arguments.oldBean.getPrePayment()#" cfsqltype="CF_SQL_FLOAT" />
			  and TtlPrePayment = <cfqueryparam value="#arguments.oldBean.getTtlPrePayment()#" cfsqltype="CF_SQL_FLOAT" />
			  and LastPrePaymentDate = <cfqueryparam value="#arguments.oldBean.getLastPrePaymentDate()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and WorkingManagerID = <cfqueryparam value="#arguments.oldBean.getWorkingManagerID()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Hotelogic = <cfqueryparam value="#arguments.oldBean.getHotelogic()#" cfsqltype="CF_SQL_BIT" />
			  and LG = <cfqueryparam value="#arguments.oldBean.getLG()#" cfsqltype="CF_SQL_INTEGER" />
			  and BizType = <cfqueryparam value="#arguments.oldBean.getBizType()#" cfsqltype="CF_SQL_VARCHAR" />
			  and HotLeads = <cfqueryparam value="#arguments.oldBean.getHotLeads()#" cfsqltype="CF_SQL_BIT" />
			  and Prospect = <cfqueryparam value="#arguments.oldBean.getProspect()#" cfsqltype="CF_SQL_BIT" />
		</cfquery>
		<!--- if we didn't affect a single record, the update failed --->
		<cfquery name="qUpdateResult" datasource="revpar"  result="status">
			select ID
			from dbo.Referrals
			where ID = <cfqueryparam value="#arguments.newBean.getID()#" cfsqltype="CF_SQL_BIGINT" />
			  and Company = <cfqueryparam value="#arguments.newBean.getCompany()#" cfsqltype="CF_SQL_VARCHAR" />
			  and myEvent = <cfqueryparam value="#arguments.newBean.getmyEvent()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Decision = <cfqueryparam value="#arguments.newBean.getDecision()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Attendees = <cfqueryparam value="#arguments.newBean.getAttendees()#" cfsqltype="CF_SQL_INTEGER" />
			  and Contact = <cfqueryparam value="#arguments.newBean.getContact()#" cfsqltype="CF_SQL_VARCHAR" />
			  and myTitle = <cfqueryparam value="#arguments.newBean.getmyTitle()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Address1 = <cfqueryparam value="#arguments.newBean.getAddress1()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Address2 = <cfqueryparam value="#arguments.newBean.getAddress2()#" cfsqltype="CF_SQL_VARCHAR" />
			  and City = <cfqueryparam value="#arguments.newBean.getCity()#" cfsqltype="CF_SQL_VARCHAR" />
			  and State = <cfqueryparam value="#arguments.newBean.getState()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Zip = <cfqueryparam value="#arguments.newBean.getZip()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Country = <cfqueryparam value="#arguments.newBean.getCountry()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Email = <cfqueryparam value="#arguments.newBean.getEmail()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Commissionable = <cfqueryparam value="#arguments.newBean.getCommissionable()#" cfsqltype="CF_SQL_BIT" />
			  and Commission = <cfqueryparam value="#arguments.newBean.getCommission()#" cfsqltype="CF_SQL_VARCHAR" />
			  and IATA = <cfqueryparam value="#arguments.newBean.getIATA()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Rate = <cfqueryparam value="#arguments.newBean.getRate()#" cfsqltype="CF_SQL_FLOAT" />
			  and Phone = <cfqueryparam value="#arguments.newBean.getPhone()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Fax = <cfqueryparam value="#arguments.newBean.getFax()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Date1 = <cfqueryparam value="#arguments.newBean.getDate1()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and Date2 = <cfqueryparam value="#arguments.newBean.getDate2()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and Date3 = <cfqueryparam value="#arguments.newBean.getDate3()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and Date4 = <cfqueryparam value="#arguments.newBean.getDate4()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and Date5 = <cfqueryparam value="#arguments.newBean.getDate5()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and Date6 = <cfqueryparam value="#arguments.newBean.getDate6()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and Date7 = <cfqueryparam value="#arguments.newBean.getDate7()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and Single1 = <cfqueryparam value="#arguments.newBean.getSingle1()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Single2 = <cfqueryparam value="#arguments.newBean.getSingle2()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Single3 = <cfqueryparam value="#arguments.newBean.getSingle3()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Single4 = <cfqueryparam value="#arguments.newBean.getSingle4()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Single5 = <cfqueryparam value="#arguments.newBean.getSingle5()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Single6 = <cfqueryparam value="#arguments.newBean.getSingle6()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Single7 = <cfqueryparam value="#arguments.newBean.getSingle7()#" cfsqltype="CF_SQL_SMALLINT" />
			  and SingleTotal = <cfqueryparam value="#arguments.newBean.getSingleTotal()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Double1 = <cfqueryparam value="#arguments.newBean.getDouble1()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Double2 = <cfqueryparam value="#arguments.newBean.getDouble2()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Double3 = <cfqueryparam value="#arguments.newBean.getDouble3()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Double4 = <cfqueryparam value="#arguments.newBean.getDouble4()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Double5 = <cfqueryparam value="#arguments.newBean.getDouble5()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Double6 = <cfqueryparam value="#arguments.newBean.getDouble6()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Double7 = <cfqueryparam value="#arguments.newBean.getDouble7()#" cfsqltype="CF_SQL_SMALLINT" />
			  and DoubleTotal = <cfqueryparam value="#arguments.newBean.getDoubleTotal()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Total1 = <cfqueryparam value="#arguments.newBean.getTotal1()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Total2 = <cfqueryparam value="#arguments.newBean.getTotal2()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Total3 = <cfqueryparam value="#arguments.newBean.getTotal3()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Total4 = <cfqueryparam value="#arguments.newBean.getTotal4()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Total5 = <cfqueryparam value="#arguments.newBean.getTotal5()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Total6 = <cfqueryparam value="#arguments.newBean.getTotal6()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Total7 = <cfqueryparam value="#arguments.newBean.getTotal7()#" cfsqltype="CF_SQL_SMALLINT" />
			  and TotalTotal = <cfqueryparam value="#arguments.newBean.getTotalTotal()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Start1 = <cfqueryparam value="#arguments.newBean.getStart1()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Start2 = <cfqueryparam value="#arguments.newBean.getStart2()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Start3 = <cfqueryparam value="#arguments.newBean.getStart3()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Start4 = <cfqueryparam value="#arguments.newBean.getStart4()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Start5 = <cfqueryparam value="#arguments.newBean.getStart5()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Start6 = <cfqueryparam value="#arguments.newBean.getStart6()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Start7 = <cfqueryparam value="#arguments.newBean.getStart7()#" cfsqltype="CF_SQL_VARCHAR" />
			  and End1 = <cfqueryparam value="#arguments.newBean.getEnd1()#" cfsqltype="CF_SQL_VARCHAR" />
			  and End2 = <cfqueryparam value="#arguments.newBean.getEnd2()#" cfsqltype="CF_SQL_VARCHAR" />
			  and End3 = <cfqueryparam value="#arguments.newBean.getEnd3()#" cfsqltype="CF_SQL_VARCHAR" />
			  and End4 = <cfqueryparam value="#arguments.newBean.getEnd4()#" cfsqltype="CF_SQL_VARCHAR" />
			  and End5 = <cfqueryparam value="#arguments.newBean.getEnd5()#" cfsqltype="CF_SQL_VARCHAR" />
			  and End6 = <cfqueryparam value="#arguments.newBean.getEnd6()#" cfsqltype="CF_SQL_VARCHAR" />
			  and End7 = <cfqueryparam value="#arguments.newBean.getEnd7()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Func1 = <cfqueryparam value="#arguments.newBean.getFunc1()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Func2 = <cfqueryparam value="#arguments.newBean.getFunc2()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Func3 = <cfqueryparam value="#arguments.newBean.getFunc3()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Func4 = <cfqueryparam value="#arguments.newBean.getFunc4()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Func5 = <cfqueryparam value="#arguments.newBean.getFunc5()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Func6 = <cfqueryparam value="#arguments.newBean.getFunc6()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Func7 = <cfqueryparam value="#arguments.newBean.getFunc7()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Ppl1 = <cfqueryparam value="#arguments.newBean.getPpl1()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Ppl2 = <cfqueryparam value="#arguments.newBean.getPpl2()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Ppl3 = <cfqueryparam value="#arguments.newBean.getPpl3()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Ppl4 = <cfqueryparam value="#arguments.newBean.getPpl4()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Ppl5 = <cfqueryparam value="#arguments.newBean.getPpl5()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Ppl6 = <cfqueryparam value="#arguments.newBean.getPpl6()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Ppl7 = <cfqueryparam value="#arguments.newBean.getPpl7()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Setup1 = <cfqueryparam value="#arguments.newBean.getSetup1()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Setup2 = <cfqueryparam value="#arguments.newBean.getSetup2()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Setup3 = <cfqueryparam value="#arguments.newBean.getSetup3()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Setup4 = <cfqueryparam value="#arguments.newBean.getSetup4()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Setup5 = <cfqueryparam value="#arguments.newBean.getSetup5()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Setup6 = <cfqueryparam value="#arguments.newBean.getSetup6()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Setup7 = <cfqueryparam value="#arguments.newBean.getSetup7()#" cfsqltype="CF_SQL_VARCHAR" />
			  and FBComments1 = <cfqueryparam value="#arguments.newBean.getFBComments1()#" cfsqltype="CF_SQL_VARCHAR" />
			  and FBComments2 = <cfqueryparam value="#arguments.newBean.getFBComments2()#" cfsqltype="CF_SQL_VARCHAR" />
			  and FBComments3 = <cfqueryparam value="#arguments.newBean.getFBComments3()#" cfsqltype="CF_SQL_VARCHAR" />
			  and FBComments4 = <cfqueryparam value="#arguments.newBean.getFBComments4()#" cfsqltype="CF_SQL_VARCHAR" />
			  and FBComments5 = <cfqueryparam value="#arguments.newBean.getFBComments5()#" cfsqltype="CF_SQL_VARCHAR" />
			  and FBComments6 = <cfqueryparam value="#arguments.newBean.getFBComments6()#" cfsqltype="CF_SQL_VARCHAR" />
			  and FBComments7 = <cfqueryparam value="#arguments.newBean.getFBComments7()#" cfsqltype="CF_SQL_VARCHAR" />
			  and CateringRev1 = <cfqueryparam value="#arguments.newBean.getCateringRev1()#" cfsqltype="CF_SQL_FLOAT" />
			  and CateringRev2 = <cfqueryparam value="#arguments.newBean.getCateringRev2()#" cfsqltype="CF_SQL_FLOAT" />
			  and CateringRev3 = <cfqueryparam value="#arguments.newBean.getCateringRev3()#" cfsqltype="CF_SQL_FLOAT" />
			  and CateringRev4 = <cfqueryparam value="#arguments.newBean.getCateringRev4()#" cfsqltype="CF_SQL_FLOAT" />
			  and CateringRev5 = <cfqueryparam value="#arguments.newBean.getCateringRev5()#" cfsqltype="CF_SQL_FLOAT" />
			  and CateringRev6 = <cfqueryparam value="#arguments.newBean.getCateringRev6()#" cfsqltype="CF_SQL_FLOAT" />
			  and CateringRev7 = <cfqueryparam value="#arguments.newBean.getCateringRev7()#" cfsqltype="CF_SQL_FLOAT" />
			  and CateringRevTtl = <cfqueryparam value="#arguments.newBean.getCateringRevTtl()#" cfsqltype="CF_SQL_FLOAT" />
			  and RentRev1 = <cfqueryparam value="#arguments.newBean.getRentRev1()#" cfsqltype="CF_SQL_FLOAT" />
			  and RentRev2 = <cfqueryparam value="#arguments.newBean.getRentRev2()#" cfsqltype="CF_SQL_FLOAT" />
			  and RentRev3 = <cfqueryparam value="#arguments.newBean.getRentRev3()#" cfsqltype="CF_SQL_FLOAT" />
			  and RentRev4 = <cfqueryparam value="#arguments.newBean.getRentRev4()#" cfsqltype="CF_SQL_FLOAT" />
			  and RentRev5 = <cfqueryparam value="#arguments.newBean.getRentRev5()#" cfsqltype="CF_SQL_FLOAT" />
			  and RentRev6 = <cfqueryparam value="#arguments.newBean.getRentRev6()#" cfsqltype="CF_SQL_FLOAT" />
			  and RentRev7 = <cfqueryparam value="#arguments.newBean.getRentRev7()#" cfsqltype="CF_SQL_FLOAT" />
			  and RentRevTtl = <cfqueryparam value="#arguments.newBean.getRentRevTtl()#" cfsqltype="CF_SQL_FLOAT" />
			  and SpecialComments = <cfqueryparam value="#arguments.newBean.getSpecialComments()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Requests = <cfqueryparam value="#arguments.newBean.getRequests()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Hotels = <cfqueryparam value="#arguments.newBean.getHotels()#" cfsqltype="CF_SQL_VARCHAR" />
			  and RefHotel = <cfqueryparam value="#arguments.newBean.getRefHotel()#" cfsqltype="CF_SQL_VARCHAR" />
			  and RefUserID = <cfqueryparam value="#arguments.newBean.getRefUserID()#" cfsqltype="CF_SQL_SMALLINT" />
			  and RmRevenue = <cfqueryparam value="#arguments.newBean.getRmRevenue()#" cfsqltype="CF_SQL_FLOAT" />
			  and myStatus = <cfqueryparam value="#arguments.newBean.getmyStatus()#" cfsqltype="CF_SQL_VARCHAR" />
			  and CheckedOut = <cfqueryparam value="#arguments.newBean.getCheckedOut()#" cfsqltype="CF_SQL_BIT" />
			  and CheckOutDate = <cfqueryparam value="#arguments.newBean.getCheckOutDate()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and DefiniteDate = <cfqueryparam value="#arguments.newBean.getDefiniteDate()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and Rejection = <cfqueryparam value="#arguments.newBean.getRejection()#" cfsqltype="CF_SQL_VARCHAR" />
			  and FinalComments = <cfqueryparam value="#arguments.newBean.getFinalComments()#" cfsqltype="CF_SQL_VARCHAR" />
			  and Approved = <cfqueryparam value="#arguments.newBean.getApproved()#" cfsqltype="CF_SQL_BIT" />
			  and CheckCut = <cfqueryparam value="#arguments.newBean.getCheckCut()#" cfsqltype="CF_SQL_BIT" />
			  and BonusLead = <cfqueryparam value="#arguments.newBean.getBonusLead()#" cfsqltype="CF_SQL_BIT" />
			  and Bonus = <cfqueryparam value="#arguments.newBean.getBonus()#" cfsqltype="CF_SQL_SMALLINT" />
			  and SentDate = <cfqueryparam value="#arguments.newBean.getSentDate()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and CheckReceived = <cfqueryparam value="#arguments.newBean.getCheckReceived()#" cfsqltype="CF_SQL_BIT" />
			  and WorkingHotel = <cfqueryparam value="#arguments.newBean.getWorkingHotel()#" cfsqltype="CF_SQL_VARCHAR" />
			  and DefPerson = <cfqueryparam value="#arguments.newBean.getDefPerson()#" cfsqltype="CF_SQL_INTEGER" />
			  and ApprovPerson = <cfqueryparam value="#arguments.newBean.getApprovPerson()#" cfsqltype="CF_SQL_INTEGER" />
			  and Extended_Stay = <cfqueryparam value="#arguments.newBean.getExtended_Stay()#" cfsqltype="CF_SQL_BIT" />
			  and Nights = <cfqueryparam value="#arguments.newBean.getNights()#" cfsqltype="CF_SQL_SMALLINT" />
			  and PrePayment = <cfqueryparam value="#arguments.newBean.getPrePayment()#" cfsqltype="CF_SQL_FLOAT" />
			  and TtlPrePayment = <cfqueryparam value="#arguments.newBean.getTtlPrePayment()#" cfsqltype="CF_SQL_FLOAT" />
			  and LastPrePaymentDate = <cfqueryparam value="#arguments.newBean.getLastPrePaymentDate()#" cfsqltype="CF_SQL_TIMESTAMP" />
			  and WorkingManagerID = <cfqueryparam value="#arguments.newBean.getWorkingManagerID()#" cfsqltype="CF_SQL_SMALLINT" />
			  and Hotelogic = <cfqueryparam value="#arguments.newBean.getHotelogic()#" cfsqltype="CF_SQL_BIT" />
			  and LG = <cfqueryparam value="#arguments.newBean.getLG()#" cfsqltype="CF_SQL_INTEGER" />
			  and BizType = <cfqueryparam value="#arguments.newBean.getBizType()#" cfsqltype="CF_SQL_VARCHAR" />
			  and HotLeads = <cfqueryparam value="#arguments.newBean.getHotLeads()#" cfsqltype="CF_SQL_BIT" />
			  and Prospect = <cfqueryparam value="#arguments.newBean.getProspect()#" cfsqltype="CF_SQL_BIT" />
		</cfquery>
		<cfif status.recordcount EQ 0>
			<cfthrow type="conflict" message="Unable to update record">
		</cfif>
		<cfreturn arguments.newBean />
	</cffunction>



	<cffunction name="delete" output="false" access="public" returntype="void">
		<cfargument name="bean" required="true" type="com.adobe.leadgine.Referrals">
		<cfset var qDelete="">

		<cfquery name="qDelete" datasource="revpar" result="status">
			delete
			from dbo.Referrals
			where ID = <cfqueryparam cfsqltype="CF_SQL_BIGINT" value="#arguments.bean.getID()#" />
		</cfquery>

		<!--- Did we delete the record? --->
		<cfquery name="qDeleteResult" datasource="revpar"  result="status">
			select ID
			from dbo.Referrals
			where ID = <cfqueryparam cfsqltype="CF_SQL_BIGINT" value="#arguments.bean.getID()#" />
		</cfquery>
		<cfif status.recordcount NEQ 0>
			<cfthrow type="conflict" message="Unable to delete record">
		</cfif>

	</cffunction>

	<cffunction name="count" output="false" access="public" returntype="Numeric">
		<cfargument name="id" required="false">
		<cfargument name="param" required="false">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="revpar">
			select COUNT(*) as totalRecords
			from dbo.Referrals
			<cfif structKeyExists(arguments, "id")>
				where ID = <cfqueryparam cfsqltype="CF_SQL_BIGINT" value="#arguments.id#" />
			<cfelseif structKeyExists(arguments, "param")>
				<!---
					adjust this where clause to fit your needs (based on what you want to filter by
					(ie if you wanted to filter by LastName, pass in what you want to filter by in
					the "param" attribute of the function and change "where fieldname" to
					"where LastName" below)

					by default, it will probably throw an error as invalid SQL
				--->
				<!--- where fieldname LIKE '%' & <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.param#"/> & '%' --->
			</cfif>
		</cfquery>

		<cfreturn qRead.totalRecords>
	</cffunction>




</cfcomponent>