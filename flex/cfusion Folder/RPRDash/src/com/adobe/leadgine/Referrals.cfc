<cfcomponent output="false" alias="com.adobe.leadgine.Referrals">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="ID" type="numeric" default="0">
	<cfproperty name="Company" type="string" default="">
	<cfproperty name="myEvent" type="string" default="">
	<cfproperty name="Decision" type="string" default="">
	<cfproperty name="Attendees" type="numeric" default="0">
	<cfproperty name="Contact" type="string" default="">
	<cfproperty name="myTitle" type="string" default="">
	<cfproperty name="Address1" type="string" default="">
	<cfproperty name="Address2" type="string" default="">
	<cfproperty name="City" type="string" default="">
	<cfproperty name="State" type="string" default="">
	<cfproperty name="Zip" type="string" default="">
	<cfproperty name="Country" type="string" default="">
	<cfproperty name="Email" type="string" default="">
	<cfproperty name="Commissionable" type="numeric" default="0">
	<cfproperty name="Commission" type="string" default="">
	<cfproperty name="IATA" type="string" default="">
	<cfproperty name="Rate" type="numeric" default="0">
	<cfproperty name="Phone" type="string" default="">
	<cfproperty name="Fax" type="string" default="">
	<cfproperty name="Date1" type="date" default="">
	<cfproperty name="Date2" type="date" default="">
	<cfproperty name="Date3" type="date" default="">
	<cfproperty name="Date4" type="date" default="">
	<cfproperty name="Date5" type="date" default="">
	<cfproperty name="Date6" type="date" default="">
	<cfproperty name="Date7" type="date" default="">
	<cfproperty name="Single1" type="numeric" default="0">
	<cfproperty name="Single2" type="numeric" default="0">
	<cfproperty name="Single3" type="numeric" default="0">
	<cfproperty name="Single4" type="numeric" default="0">
	<cfproperty name="Single5" type="numeric" default="0">
	<cfproperty name="Single6" type="numeric" default="0">
	<cfproperty name="Single7" type="numeric" default="0">
	<cfproperty name="SingleTotal" type="numeric" default="0">
	<cfproperty name="Double1" type="numeric" default="0">
	<cfproperty name="Double2" type="numeric" default="0">
	<cfproperty name="Double3" type="numeric" default="0">
	<cfproperty name="Double4" type="numeric" default="0">
	<cfproperty name="Double5" type="numeric" default="0">
	<cfproperty name="Double6" type="numeric" default="0">
	<cfproperty name="Double7" type="numeric" default="0">
	<cfproperty name="DoubleTotal" type="numeric" default="0">
	<cfproperty name="Total1" type="numeric" default="0">
	<cfproperty name="Total2" type="numeric" default="0">
	<cfproperty name="Total3" type="numeric" default="0">
	<cfproperty name="Total4" type="numeric" default="0">
	<cfproperty name="Total5" type="numeric" default="0">
	<cfproperty name="Total6" type="numeric" default="0">
	<cfproperty name="Total7" type="numeric" default="0">
	<cfproperty name="TotalTotal" type="numeric" default="0">
	<cfproperty name="Start1" type="string" default="">
	<cfproperty name="Start2" type="string" default="">
	<cfproperty name="Start3" type="string" default="">
	<cfproperty name="Start4" type="string" default="">
	<cfproperty name="Start5" type="string" default="">
	<cfproperty name="Start6" type="string" default="">
	<cfproperty name="Start7" type="string" default="">
	<cfproperty name="End1" type="string" default="">
	<cfproperty name="End2" type="string" default="">
	<cfproperty name="End3" type="string" default="">
	<cfproperty name="End4" type="string" default="">
	<cfproperty name="End5" type="string" default="">
	<cfproperty name="End6" type="string" default="">
	<cfproperty name="End7" type="string" default="">
	<cfproperty name="Func1" type="string" default="">
	<cfproperty name="Func2" type="string" default="">
	<cfproperty name="Func3" type="string" default="">
	<cfproperty name="Func4" type="string" default="">
	<cfproperty name="Func5" type="string" default="">
	<cfproperty name="Func6" type="string" default="">
	<cfproperty name="Func7" type="string" default="">
	<cfproperty name="Ppl1" type="string" default="">
	<cfproperty name="Ppl2" type="string" default="">
	<cfproperty name="Ppl3" type="string" default="">
	<cfproperty name="Ppl4" type="string" default="">
	<cfproperty name="Ppl5" type="string" default="">
	<cfproperty name="Ppl6" type="string" default="">
	<cfproperty name="Ppl7" type="string" default="">
	<cfproperty name="Setup1" type="string" default="">
	<cfproperty name="Setup2" type="string" default="">
	<cfproperty name="Setup3" type="string" default="">
	<cfproperty name="Setup4" type="string" default="">
	<cfproperty name="Setup5" type="string" default="">
	<cfproperty name="Setup6" type="string" default="">
	<cfproperty name="Setup7" type="string" default="">
	<cfproperty name="FBComments1" type="string" default="">
	<cfproperty name="FBComments2" type="string" default="">
	<cfproperty name="FBComments3" type="string" default="">
	<cfproperty name="FBComments4" type="string" default="">
	<cfproperty name="FBComments5" type="string" default="">
	<cfproperty name="FBComments6" type="string" default="">
	<cfproperty name="FBComments7" type="string" default="">
	<cfproperty name="CateringRev1" type="numeric" default="0">
	<cfproperty name="CateringRev2" type="numeric" default="0">
	<cfproperty name="CateringRev3" type="numeric" default="0">
	<cfproperty name="CateringRev4" type="numeric" default="0">
	<cfproperty name="CateringRev5" type="numeric" default="0">
	<cfproperty name="CateringRev6" type="numeric" default="0">
	<cfproperty name="CateringRev7" type="numeric" default="0">
	<cfproperty name="CateringRevTtl" type="numeric" default="0">
	<cfproperty name="RentRev1" type="numeric" default="0">
	<cfproperty name="RentRev2" type="numeric" default="0">
	<cfproperty name="RentRev3" type="numeric" default="0">
	<cfproperty name="RentRev4" type="numeric" default="0">
	<cfproperty name="RentRev5" type="numeric" default="0">
	<cfproperty name="RentRev6" type="numeric" default="0">
	<cfproperty name="RentRev7" type="numeric" default="0">
	<cfproperty name="RentRevTtl" type="numeric" default="0">
	<cfproperty name="SpecialComments" type="string" default="">
	<cfproperty name="Requests" type="string" default="">
	<cfproperty name="Hotels" type="string" default="">
	<cfproperty name="RefHotel" type="string" default="">
	<cfproperty name="RefUserID" type="numeric" default="0">
	<cfproperty name="RmRevenue" type="numeric" default="0">
	<cfproperty name="myStatus" type="string" default="">
	<cfproperty name="CheckedOut" type="numeric" default="0">
	<cfproperty name="CheckOutDate" type="date" default="">
	<cfproperty name="DefiniteDate" type="date" default="">
	<cfproperty name="Rejection" type="string" default="">
	<cfproperty name="FinalComments" type="string" default="">
	<cfproperty name="Approved" type="numeric" default="0">
	<cfproperty name="CheckCut" type="numeric" default="0">
	<cfproperty name="BonusLead" type="numeric" default="0">
	<cfproperty name="Bonus" type="numeric" default="0">
	<cfproperty name="SentDate" type="date" default="">
	<cfproperty name="CheckReceived" type="numeric" default="0">
	<cfproperty name="WorkingHotel" type="string" default="">
	<cfproperty name="DefPerson" type="numeric" default="0">
	<cfproperty name="ApprovPerson" type="numeric" default="0">
	<cfproperty name="Extended_Stay" type="numeric" default="0">
	<cfproperty name="Nights" type="numeric" default="0">
	<cfproperty name="PrePayment" type="numeric" default="0">
	<cfproperty name="TtlPrePayment" type="numeric" default="0">
	<cfproperty name="LastPrePaymentDate" type="date" default="">
	<cfproperty name="WorkingManagerID" type="numeric" default="0">
	<cfproperty name="Hotelogic" type="numeric" default="0">
	<cfproperty name="LG" type="numeric" default="0">
	<cfproperty name="BizType" type="string" default="">
	<cfproperty name="HotLeads" type="numeric" default="0">
	<cfproperty name="Prospect" type="numeric" default="0">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.ID = 0;
		variables.Company = "";
		variables.myEvent = "";
		variables.Decision = "";
		variables.Attendees = 0;
		variables.Contact = "";
		variables.myTitle = "";
		variables.Address1 = "";
		variables.Address2 = "";
		variables.City = "";
		variables.State = "";
		variables.Zip = "";
		variables.Country = "";
		variables.Email = "";
		variables.Commissionable = 0;
		variables.Commission = "";
		variables.IATA = "";
		variables.Rate = 0;
		variables.Phone = "";
		variables.Fax = "";
		variables.Date1 = "";
		variables.Date2 = "";
		variables.Date3 = "";
		variables.Date4 = "";
		variables.Date5 = "";
		variables.Date6 = "";
		variables.Date7 = "";
		variables.Single1 = 0;
		variables.Single2 = 0;
		variables.Single3 = 0;
		variables.Single4 = 0;
		variables.Single5 = 0;
		variables.Single6 = 0;
		variables.Single7 = 0;
		variables.SingleTotal = 0;
		variables.Double1 = 0;
		variables.Double2 = 0;
		variables.Double3 = 0;
		variables.Double4 = 0;
		variables.Double5 = 0;
		variables.Double6 = 0;
		variables.Double7 = 0;
		variables.DoubleTotal = 0;
		variables.Total1 = 0;
		variables.Total2 = 0;
		variables.Total3 = 0;
		variables.Total4 = 0;
		variables.Total5 = 0;
		variables.Total6 = 0;
		variables.Total7 = 0;
		variables.TotalTotal = 0;
		variables.Start1 = "";
		variables.Start2 = "";
		variables.Start3 = "";
		variables.Start4 = "";
		variables.Start5 = "";
		variables.Start6 = "";
		variables.Start7 = "";
		variables.End1 = "";
		variables.End2 = "";
		variables.End3 = "";
		variables.End4 = "";
		variables.End5 = "";
		variables.End6 = "";
		variables.End7 = "";
		variables.Func1 = "";
		variables.Func2 = "";
		variables.Func3 = "";
		variables.Func4 = "";
		variables.Func5 = "";
		variables.Func6 = "";
		variables.Func7 = "";
		variables.Ppl1 = "";
		variables.Ppl2 = "";
		variables.Ppl3 = "";
		variables.Ppl4 = "";
		variables.Ppl5 = "";
		variables.Ppl6 = "";
		variables.Ppl7 = "";
		variables.Setup1 = "";
		variables.Setup2 = "";
		variables.Setup3 = "";
		variables.Setup4 = "";
		variables.Setup5 = "";
		variables.Setup6 = "";
		variables.Setup7 = "";
		variables.FBComments1 = "";
		variables.FBComments2 = "";
		variables.FBComments3 = "";
		variables.FBComments4 = "";
		variables.FBComments5 = "";
		variables.FBComments6 = "";
		variables.FBComments7 = "";
		variables.CateringRev1 = 0;
		variables.CateringRev2 = 0;
		variables.CateringRev3 = 0;
		variables.CateringRev4 = 0;
		variables.CateringRev5 = 0;
		variables.CateringRev6 = 0;
		variables.CateringRev7 = 0;
		variables.CateringRevTtl = 0;
		variables.RentRev1 = 0;
		variables.RentRev2 = 0;
		variables.RentRev3 = 0;
		variables.RentRev4 = 0;
		variables.RentRev5 = 0;
		variables.RentRev6 = 0;
		variables.RentRev7 = 0;
		variables.RentRevTtl = 0;
		variables.SpecialComments = "";
		variables.Requests = "";
		variables.Hotels = "";
		variables.RefHotel = "";
		variables.RefUserID = 0;
		variables.RmRevenue = 0;
		variables.myStatus = "";
		variables.CheckedOut = 0;
		variables.CheckOutDate = "";
		variables.DefiniteDate = "";
		variables.Rejection = "";
		variables.FinalComments = "";
		variables.Approved = 0;
		variables.CheckCut = 0;
		variables.BonusLead = 0;
		variables.Bonus = 0;
		variables.SentDate = "";
		variables.CheckReceived = 0;
		variables.WorkingHotel = "";
		variables.DefPerson = 0;
		variables.ApprovPerson = 0;
		variables.Extended_Stay = 0;
		variables.Nights = 0;
		variables.PrePayment = 0;
		variables.TtlPrePayment = 0;
		variables.LastPrePaymentDate = "";
		variables.WorkingManagerID = 0;
		variables.Hotelogic = 0;
		variables.LG = 0;
		variables.BizType = "";
		variables.HotLeads = 0;
		variables.Prospect = 0;
	</cfscript>

	<cffunction name="init" output="false" returntype="Referrals">
		<cfreturn this>
	</cffunction>
	<cffunction name="getID" output="false" access="public" returntype="any">
		<cfreturn variables.ID>
	</cffunction>

	<cffunction name="setID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.ID = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getCompany" output="false" access="public" returntype="any">
		<cfreturn variables.Company>
	</cffunction>

	<cffunction name="setCompany" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Company = arguments.val>
	</cffunction>

	<cffunction name="getMyEvent" output="false" access="public" returntype="any">
		<cfreturn variables.MyEvent>
	</cffunction>

	<cffunction name="setMyEvent" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.MyEvent = arguments.val>
	</cffunction>

	<cffunction name="getDecision" output="false" access="public" returntype="any">
		<cfreturn variables.Decision>
	</cffunction>

	<cffunction name="setDecision" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Decision = arguments.val>
	</cffunction>

	<cffunction name="getAttendees" output="false" access="public" returntype="any">
		<cfreturn variables.Attendees>
	</cffunction>

	<cffunction name="setAttendees" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Attendees = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getContact" output="false" access="public" returntype="any">
		<cfreturn variables.Contact>
	</cffunction>

	<cffunction name="setContact" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Contact = arguments.val>
	</cffunction>

	<cffunction name="getMyTitle" output="false" access="public" returntype="any">
		<cfreturn variables.MyTitle>
	</cffunction>

	<cffunction name="setMyTitle" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.MyTitle = arguments.val>
	</cffunction>

	<cffunction name="getAddress1" output="false" access="public" returntype="any">
		<cfreturn variables.Address1>
	</cffunction>

	<cffunction name="setAddress1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Address1 = arguments.val>
	</cffunction>

	<cffunction name="getAddress2" output="false" access="public" returntype="any">
		<cfreturn variables.Address2>
	</cffunction>

	<cffunction name="setAddress2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Address2 = arguments.val>
	</cffunction>

	<cffunction name="getCity" output="false" access="public" returntype="any">
		<cfreturn variables.City>
	</cffunction>

	<cffunction name="setCity" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.City = arguments.val>
	</cffunction>

	<cffunction name="getState" output="false" access="public" returntype="any">
		<cfreturn variables.State>
	</cffunction>

	<cffunction name="setState" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.State = arguments.val>
	</cffunction>

	<cffunction name="getZip" output="false" access="public" returntype="any">
		<cfreturn variables.Zip>
	</cffunction>

	<cffunction name="setZip" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Zip = arguments.val>
	</cffunction>

	<cffunction name="getCountry" output="false" access="public" returntype="any">
		<cfreturn variables.Country>
	</cffunction>

	<cffunction name="setCountry" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Country = arguments.val>
	</cffunction>

	<cffunction name="getEmail" output="false" access="public" returntype="any">
		<cfreturn variables.Email>
	</cffunction>

	<cffunction name="setEmail" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Email = arguments.val>
	</cffunction>

	<cffunction name="getCommissionable" output="false" access="public" returntype="any">
		<cfreturn variables.Commissionable>
	</cffunction>

	<cffunction name="setCommissionable" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Commissionable = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getCommission" output="false" access="public" returntype="any">
		<cfreturn variables.Commission>
	</cffunction>

	<cffunction name="setCommission" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Commission = arguments.val>
	</cffunction>

	<cffunction name="getIATA" output="false" access="public" returntype="any">
		<cfreturn variables.IATA>
	</cffunction>

	<cffunction name="setIATA" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.IATA = arguments.val>
	</cffunction>

	<cffunction name="getRate" output="false" access="public" returntype="any">
		<cfreturn variables.Rate>
	</cffunction>

	<cffunction name="setRate" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Rate = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getPhone" output="false" access="public" returntype="any">
		<cfreturn variables.Phone>
	</cffunction>

	<cffunction name="setPhone" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Phone = arguments.val>
	</cffunction>

	<cffunction name="getFax" output="false" access="public" returntype="any">
		<cfreturn variables.Fax>
	</cffunction>

	<cffunction name="setFax" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Fax = arguments.val>
	</cffunction>

	<cffunction name="getDate1" output="false" access="public" returntype="any">
		<cfreturn variables.Date1>
	</cffunction>

	<cffunction name="setDate1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Date1 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getDate2" output="false" access="public" returntype="any">
		<cfreturn variables.Date2>
	</cffunction>

	<cffunction name="setDate2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Date2 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getDate3" output="false" access="public" returntype="any">
		<cfreturn variables.Date3>
	</cffunction>

	<cffunction name="setDate3" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Date3 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getDate4" output="false" access="public" returntype="any">
		<cfreturn variables.Date4>
	</cffunction>

	<cffunction name="setDate4" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Date4 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getDate5" output="false" access="public" returntype="any">
		<cfreturn variables.Date5>
	</cffunction>

	<cffunction name="setDate5" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Date5 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getDate6" output="false" access="public" returntype="any">
		<cfreturn variables.Date6>
	</cffunction>

	<cffunction name="setDate6" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Date6 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getDate7" output="false" access="public" returntype="any">
		<cfreturn variables.Date7>
	</cffunction>

	<cffunction name="setDate7" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Date7 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getSingle1" output="false" access="public" returntype="any">
		<cfreturn variables.Single1>
	</cffunction>

	<cffunction name="setSingle1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Single1 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getSingle2" output="false" access="public" returntype="any">
		<cfreturn variables.Single2>
	</cffunction>

	<cffunction name="setSingle2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Single2 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getSingle3" output="false" access="public" returntype="any">
		<cfreturn variables.Single3>
	</cffunction>

	<cffunction name="setSingle3" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Single3 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getSingle4" output="false" access="public" returntype="any">
		<cfreturn variables.Single4>
	</cffunction>

	<cffunction name="setSingle4" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Single4 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getSingle5" output="false" access="public" returntype="any">
		<cfreturn variables.Single5>
	</cffunction>

	<cffunction name="setSingle5" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Single5 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getSingle6" output="false" access="public" returntype="any">
		<cfreturn variables.Single6>
	</cffunction>

	<cffunction name="setSingle6" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Single6 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getSingle7" output="false" access="public" returntype="any">
		<cfreturn variables.Single7>
	</cffunction>

	<cffunction name="setSingle7" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Single7 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getSingleTotal" output="false" access="public" returntype="any">
		<cfreturn variables.SingleTotal>
	</cffunction>

	<cffunction name="setSingleTotal" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.SingleTotal = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getDouble1" output="false" access="public" returntype="any">
		<cfreturn variables.Double1>
	</cffunction>

	<cffunction name="setDouble1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Double1 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getDouble2" output="false" access="public" returntype="any">
		<cfreturn variables.Double2>
	</cffunction>

	<cffunction name="setDouble2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Double2 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getDouble3" output="false" access="public" returntype="any">
		<cfreturn variables.Double3>
	</cffunction>

	<cffunction name="setDouble3" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Double3 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getDouble4" output="false" access="public" returntype="any">
		<cfreturn variables.Double4>
	</cffunction>

	<cffunction name="setDouble4" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Double4 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getDouble5" output="false" access="public" returntype="any">
		<cfreturn variables.Double5>
	</cffunction>

	<cffunction name="setDouble5" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Double5 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getDouble6" output="false" access="public" returntype="any">
		<cfreturn variables.Double6>
	</cffunction>

	<cffunction name="setDouble6" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Double6 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getDouble7" output="false" access="public" returntype="any">
		<cfreturn variables.Double7>
	</cffunction>

	<cffunction name="setDouble7" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Double7 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getDoubleTotal" output="false" access="public" returntype="any">
		<cfreturn variables.DoubleTotal>
	</cffunction>

	<cffunction name="setDoubleTotal" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DoubleTotal = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getTotal1" output="false" access="public" returntype="any">
		<cfreturn variables.Total1>
	</cffunction>

	<cffunction name="setTotal1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Total1 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getTotal2" output="false" access="public" returntype="any">
		<cfreturn variables.Total2>
	</cffunction>

	<cffunction name="setTotal2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Total2 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getTotal3" output="false" access="public" returntype="any">
		<cfreturn variables.Total3>
	</cffunction>

	<cffunction name="setTotal3" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Total3 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getTotal4" output="false" access="public" returntype="any">
		<cfreturn variables.Total4>
	</cffunction>

	<cffunction name="setTotal4" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Total4 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getTotal5" output="false" access="public" returntype="any">
		<cfreturn variables.Total5>
	</cffunction>

	<cffunction name="setTotal5" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Total5 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getTotal6" output="false" access="public" returntype="any">
		<cfreturn variables.Total6>
	</cffunction>

	<cffunction name="setTotal6" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Total6 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getTotal7" output="false" access="public" returntype="any">
		<cfreturn variables.Total7>
	</cffunction>

	<cffunction name="setTotal7" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Total7 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getTotalTotal" output="false" access="public" returntype="any">
		<cfreturn variables.TotalTotal>
	</cffunction>

	<cffunction name="setTotalTotal" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.TotalTotal = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getStart1" output="false" access="public" returntype="any">
		<cfreturn variables.Start1>
	</cffunction>

	<cffunction name="setStart1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Start1 = arguments.val>
	</cffunction>

	<cffunction name="getStart2" output="false" access="public" returntype="any">
		<cfreturn variables.Start2>
	</cffunction>

	<cffunction name="setStart2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Start2 = arguments.val>
	</cffunction>

	<cffunction name="getStart3" output="false" access="public" returntype="any">
		<cfreturn variables.Start3>
	</cffunction>

	<cffunction name="setStart3" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Start3 = arguments.val>
	</cffunction>

	<cffunction name="getStart4" output="false" access="public" returntype="any">
		<cfreturn variables.Start4>
	</cffunction>

	<cffunction name="setStart4" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Start4 = arguments.val>
	</cffunction>

	<cffunction name="getStart5" output="false" access="public" returntype="any">
		<cfreturn variables.Start5>
	</cffunction>

	<cffunction name="setStart5" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Start5 = arguments.val>
	</cffunction>

	<cffunction name="getStart6" output="false" access="public" returntype="any">
		<cfreturn variables.Start6>
	</cffunction>

	<cffunction name="setStart6" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Start6 = arguments.val>
	</cffunction>

	<cffunction name="getStart7" output="false" access="public" returntype="any">
		<cfreturn variables.Start7>
	</cffunction>

	<cffunction name="setStart7" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Start7 = arguments.val>
	</cffunction>

	<cffunction name="getEnd1" output="false" access="public" returntype="any">
		<cfreturn variables.End1>
	</cffunction>

	<cffunction name="setEnd1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.End1 = arguments.val>
	</cffunction>

	<cffunction name="getEnd2" output="false" access="public" returntype="any">
		<cfreturn variables.End2>
	</cffunction>

	<cffunction name="setEnd2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.End2 = arguments.val>
	</cffunction>

	<cffunction name="getEnd3" output="false" access="public" returntype="any">
		<cfreturn variables.End3>
	</cffunction>

	<cffunction name="setEnd3" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.End3 = arguments.val>
	</cffunction>

	<cffunction name="getEnd4" output="false" access="public" returntype="any">
		<cfreturn variables.End4>
	</cffunction>

	<cffunction name="setEnd4" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.End4 = arguments.val>
	</cffunction>

	<cffunction name="getEnd5" output="false" access="public" returntype="any">
		<cfreturn variables.End5>
	</cffunction>

	<cffunction name="setEnd5" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.End5 = arguments.val>
	</cffunction>

	<cffunction name="getEnd6" output="false" access="public" returntype="any">
		<cfreturn variables.End6>
	</cffunction>

	<cffunction name="setEnd6" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.End6 = arguments.val>
	</cffunction>

	<cffunction name="getEnd7" output="false" access="public" returntype="any">
		<cfreturn variables.End7>
	</cffunction>

	<cffunction name="setEnd7" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.End7 = arguments.val>
	</cffunction>

	<cffunction name="getFunc1" output="false" access="public" returntype="any">
		<cfreturn variables.Func1>
	</cffunction>

	<cffunction name="setFunc1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Func1 = arguments.val>
	</cffunction>

	<cffunction name="getFunc2" output="false" access="public" returntype="any">
		<cfreturn variables.Func2>
	</cffunction>

	<cffunction name="setFunc2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Func2 = arguments.val>
	</cffunction>

	<cffunction name="getFunc3" output="false" access="public" returntype="any">
		<cfreturn variables.Func3>
	</cffunction>

	<cffunction name="setFunc3" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Func3 = arguments.val>
	</cffunction>

	<cffunction name="getFunc4" output="false" access="public" returntype="any">
		<cfreturn variables.Func4>
	</cffunction>

	<cffunction name="setFunc4" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Func4 = arguments.val>
	</cffunction>

	<cffunction name="getFunc5" output="false" access="public" returntype="any">
		<cfreturn variables.Func5>
	</cffunction>

	<cffunction name="setFunc5" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Func5 = arguments.val>
	</cffunction>

	<cffunction name="getFunc6" output="false" access="public" returntype="any">
		<cfreturn variables.Func6>
	</cffunction>

	<cffunction name="setFunc6" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Func6 = arguments.val>
	</cffunction>

	<cffunction name="getFunc7" output="false" access="public" returntype="any">
		<cfreturn variables.Func7>
	</cffunction>

	<cffunction name="setFunc7" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Func7 = arguments.val>
	</cffunction>

	<cffunction name="getPpl1" output="false" access="public" returntype="any">
		<cfreturn variables.Ppl1>
	</cffunction>

	<cffunction name="setPpl1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Ppl1 = arguments.val>
	</cffunction>

	<cffunction name="getPpl2" output="false" access="public" returntype="any">
		<cfreturn variables.Ppl2>
	</cffunction>

	<cffunction name="setPpl2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Ppl2 = arguments.val>
	</cffunction>

	<cffunction name="getPpl3" output="false" access="public" returntype="any">
		<cfreturn variables.Ppl3>
	</cffunction>

	<cffunction name="setPpl3" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Ppl3 = arguments.val>
	</cffunction>

	<cffunction name="getPpl4" output="false" access="public" returntype="any">
		<cfreturn variables.Ppl4>
	</cffunction>

	<cffunction name="setPpl4" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Ppl4 = arguments.val>
	</cffunction>

	<cffunction name="getPpl5" output="false" access="public" returntype="any">
		<cfreturn variables.Ppl5>
	</cffunction>

	<cffunction name="setPpl5" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Ppl5 = arguments.val>
	</cffunction>

	<cffunction name="getPpl6" output="false" access="public" returntype="any">
		<cfreturn variables.Ppl6>
	</cffunction>

	<cffunction name="setPpl6" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Ppl6 = arguments.val>
	</cffunction>

	<cffunction name="getPpl7" output="false" access="public" returntype="any">
		<cfreturn variables.Ppl7>
	</cffunction>

	<cffunction name="setPpl7" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Ppl7 = arguments.val>
	</cffunction>

	<cffunction name="getSetup1" output="false" access="public" returntype="any">
		<cfreturn variables.Setup1>
	</cffunction>

	<cffunction name="setSetup1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Setup1 = arguments.val>
	</cffunction>

	<cffunction name="getSetup2" output="false" access="public" returntype="any">
		<cfreturn variables.Setup2>
	</cffunction>

	<cffunction name="setSetup2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Setup2 = arguments.val>
	</cffunction>

	<cffunction name="getSetup3" output="false" access="public" returntype="any">
		<cfreturn variables.Setup3>
	</cffunction>

	<cffunction name="setSetup3" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Setup3 = arguments.val>
	</cffunction>

	<cffunction name="getSetup4" output="false" access="public" returntype="any">
		<cfreturn variables.Setup4>
	</cffunction>

	<cffunction name="setSetup4" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Setup4 = arguments.val>
	</cffunction>

	<cffunction name="getSetup5" output="false" access="public" returntype="any">
		<cfreturn variables.Setup5>
	</cffunction>

	<cffunction name="setSetup5" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Setup5 = arguments.val>
	</cffunction>

	<cffunction name="getSetup6" output="false" access="public" returntype="any">
		<cfreturn variables.Setup6>
	</cffunction>

	<cffunction name="setSetup6" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Setup6 = arguments.val>
	</cffunction>

	<cffunction name="getSetup7" output="false" access="public" returntype="any">
		<cfreturn variables.Setup7>
	</cffunction>

	<cffunction name="setSetup7" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Setup7 = arguments.val>
	</cffunction>

	<cffunction name="getFBComments1" output="false" access="public" returntype="any">
		<cfreturn variables.FBComments1>
	</cffunction>

	<cffunction name="setFBComments1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FBComments1 = arguments.val>
	</cffunction>

	<cffunction name="getFBComments2" output="false" access="public" returntype="any">
		<cfreturn variables.FBComments2>
	</cffunction>

	<cffunction name="setFBComments2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FBComments2 = arguments.val>
	</cffunction>

	<cffunction name="getFBComments3" output="false" access="public" returntype="any">
		<cfreturn variables.FBComments3>
	</cffunction>

	<cffunction name="setFBComments3" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FBComments3 = arguments.val>
	</cffunction>

	<cffunction name="getFBComments4" output="false" access="public" returntype="any">
		<cfreturn variables.FBComments4>
	</cffunction>

	<cffunction name="setFBComments4" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FBComments4 = arguments.val>
	</cffunction>

	<cffunction name="getFBComments5" output="false" access="public" returntype="any">
		<cfreturn variables.FBComments5>
	</cffunction>

	<cffunction name="setFBComments5" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FBComments5 = arguments.val>
	</cffunction>

	<cffunction name="getFBComments6" output="false" access="public" returntype="any">
		<cfreturn variables.FBComments6>
	</cffunction>

	<cffunction name="setFBComments6" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FBComments6 = arguments.val>
	</cffunction>

	<cffunction name="getFBComments7" output="false" access="public" returntype="any">
		<cfreturn variables.FBComments7>
	</cffunction>

	<cffunction name="setFBComments7" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FBComments7 = arguments.val>
	</cffunction>

	<cffunction name="getCateringRev1" output="false" access="public" returntype="any">
		<cfreturn variables.CateringRev1>
	</cffunction>

	<cffunction name="setCateringRev1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CateringRev1 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getCateringRev2" output="false" access="public" returntype="any">
		<cfreturn variables.CateringRev2>
	</cffunction>

	<cffunction name="setCateringRev2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CateringRev2 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getCateringRev3" output="false" access="public" returntype="any">
		<cfreturn variables.CateringRev3>
	</cffunction>

	<cffunction name="setCateringRev3" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CateringRev3 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getCateringRev4" output="false" access="public" returntype="any">
		<cfreturn variables.CateringRev4>
	</cffunction>

	<cffunction name="setCateringRev4" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CateringRev4 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getCateringRev5" output="false" access="public" returntype="any">
		<cfreturn variables.CateringRev5>
	</cffunction>

	<cffunction name="setCateringRev5" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CateringRev5 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getCateringRev6" output="false" access="public" returntype="any">
		<cfreturn variables.CateringRev6>
	</cffunction>

	<cffunction name="setCateringRev6" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CateringRev6 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getCateringRev7" output="false" access="public" returntype="any">
		<cfreturn variables.CateringRev7>
	</cffunction>

	<cffunction name="setCateringRev7" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CateringRev7 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getCateringRevTtl" output="false" access="public" returntype="any">
		<cfreturn variables.CateringRevTtl>
	</cffunction>

	<cffunction name="setCateringRevTtl" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CateringRevTtl = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getRentRev1" output="false" access="public" returntype="any">
		<cfreturn variables.RentRev1>
	</cffunction>

	<cffunction name="setRentRev1" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.RentRev1 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getRentRev2" output="false" access="public" returntype="any">
		<cfreturn variables.RentRev2>
	</cffunction>

	<cffunction name="setRentRev2" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.RentRev2 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getRentRev3" output="false" access="public" returntype="any">
		<cfreturn variables.RentRev3>
	</cffunction>

	<cffunction name="setRentRev3" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.RentRev3 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getRentRev4" output="false" access="public" returntype="any">
		<cfreturn variables.RentRev4>
	</cffunction>

	<cffunction name="setRentRev4" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.RentRev4 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getRentRev5" output="false" access="public" returntype="any">
		<cfreturn variables.RentRev5>
	</cffunction>

	<cffunction name="setRentRev5" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.RentRev5 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getRentRev6" output="false" access="public" returntype="any">
		<cfreturn variables.RentRev6>
	</cffunction>

	<cffunction name="setRentRev6" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.RentRev6 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getRentRev7" output="false" access="public" returntype="any">
		<cfreturn variables.RentRev7>
	</cffunction>

	<cffunction name="setRentRev7" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.RentRev7 = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getRentRevTtl" output="false" access="public" returntype="any">
		<cfreturn variables.RentRevTtl>
	</cffunction>

	<cffunction name="setRentRevTtl" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.RentRevTtl = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getSpecialComments" output="false" access="public" returntype="any">
		<cfreturn variables.SpecialComments>
	</cffunction>

	<cffunction name="setSpecialComments" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.SpecialComments = arguments.val>
	</cffunction>

	<cffunction name="getRequests" output="false" access="public" returntype="any">
		<cfreturn variables.Requests>
	</cffunction>

	<cffunction name="setRequests" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Requests = arguments.val>
	</cffunction>

	<cffunction name="getHotels" output="false" access="public" returntype="any">
		<cfreturn variables.Hotels>
	</cffunction>

	<cffunction name="setHotels" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Hotels = arguments.val>
	</cffunction>

	<cffunction name="getRefHotel" output="false" access="public" returntype="any">
		<cfreturn variables.RefHotel>
	</cffunction>

	<cffunction name="setRefHotel" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.RefHotel = arguments.val>
	</cffunction>

	<cffunction name="getRefUserID" output="false" access="public" returntype="any">
		<cfreturn variables.RefUserID>
	</cffunction>

	<cffunction name="setRefUserID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.RefUserID = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getRmRevenue" output="false" access="public" returntype="any">
		<cfreturn variables.RmRevenue>
	</cffunction>

	<cffunction name="setRmRevenue" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.RmRevenue = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getMyStatus" output="false" access="public" returntype="any">
		<cfreturn variables.MyStatus>
	</cffunction>

	<cffunction name="setMyStatus" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.MyStatus = arguments.val>
	</cffunction>

	<cffunction name="getCheckedOut" output="false" access="public" returntype="any">
		<cfreturn variables.CheckedOut>
	</cffunction>

	<cffunction name="setCheckedOut" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CheckedOut = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getCheckOutDate" output="false" access="public" returntype="any">
		<cfreturn variables.CheckOutDate>
	</cffunction>

	<cffunction name="setCheckOutDate" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CheckOutDate = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getDefiniteDate" output="false" access="public" returntype="any">
		<cfreturn variables.DefiniteDate>
	</cffunction>

	<cffunction name="setDefiniteDate" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DefiniteDate = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getRejection" output="false" access="public" returntype="any">
		<cfreturn variables.Rejection>
	</cffunction>

	<cffunction name="setRejection" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.Rejection = arguments.val>
	</cffunction>

	<cffunction name="getFinalComments" output="false" access="public" returntype="any">
		<cfreturn variables.FinalComments>
	</cffunction>

	<cffunction name="setFinalComments" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.FinalComments = arguments.val>
	</cffunction>

	<cffunction name="getApproved" output="false" access="public" returntype="any">
		<cfreturn variables.Approved>
	</cffunction>

	<cffunction name="setApproved" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Approved = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getCheckCut" output="false" access="public" returntype="any">
		<cfreturn variables.CheckCut>
	</cffunction>

	<cffunction name="setCheckCut" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CheckCut = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getBonusLead" output="false" access="public" returntype="any">
		<cfreturn variables.BonusLead>
	</cffunction>

	<cffunction name="setBonusLead" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.BonusLead = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getBonus" output="false" access="public" returntype="any">
		<cfreturn variables.Bonus>
	</cffunction>

	<cffunction name="setBonus" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Bonus = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getSentDate" output="false" access="public" returntype="any">
		<cfreturn variables.SentDate>
	</cffunction>

	<cffunction name="setSentDate" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.SentDate = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getCheckReceived" output="false" access="public" returntype="any">
		<cfreturn variables.CheckReceived>
	</cffunction>

	<cffunction name="setCheckReceived" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.CheckReceived = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getWorkingHotel" output="false" access="public" returntype="any">
		<cfreturn variables.WorkingHotel>
	</cffunction>

	<cffunction name="setWorkingHotel" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.WorkingHotel = arguments.val>
	</cffunction>

	<cffunction name="getDefPerson" output="false" access="public" returntype="any">
		<cfreturn variables.DefPerson>
	</cffunction>

	<cffunction name="setDefPerson" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.DefPerson = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getApprovPerson" output="false" access="public" returntype="any">
		<cfreturn variables.ApprovPerson>
	</cffunction>

	<cffunction name="setApprovPerson" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.ApprovPerson = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getExtended_Stay" output="false" access="public" returntype="any">
		<cfreturn variables.Extended_Stay>
	</cffunction>

	<cffunction name="setExtended_Stay" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Extended_Stay = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getNights" output="false" access="public" returntype="any">
		<cfreturn variables.Nights>
	</cffunction>

	<cffunction name="setNights" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Nights = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getPrePayment" output="false" access="public" returntype="any">
		<cfreturn variables.PrePayment>
	</cffunction>

	<cffunction name="setPrePayment" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.PrePayment = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getTtlPrePayment" output="false" access="public" returntype="any">
		<cfreturn variables.TtlPrePayment>
	</cffunction>

	<cffunction name="setTtlPrePayment" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.TtlPrePayment = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getLastPrePaymentDate" output="false" access="public" returntype="any">
		<cfreturn variables.LastPrePaymentDate>
	</cffunction>

	<cffunction name="setLastPrePaymentDate" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsDate(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.LastPrePaymentDate = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid date"/>
		</cfif>
	</cffunction>

	<cffunction name="getWorkingManagerID" output="false" access="public" returntype="any">
		<cfreturn variables.WorkingManagerID>
	</cffunction>

	<cffunction name="setWorkingManagerID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.WorkingManagerID = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getHotelogic" output="false" access="public" returntype="any">
		<cfreturn variables.Hotelogic>
	</cffunction>

	<cffunction name="setHotelogic" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Hotelogic = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getLG" output="false" access="public" returntype="any">
		<cfreturn variables.LG>
	</cffunction>

	<cffunction name="setLG" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.LG = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getBizType" output="false" access="public" returntype="any">
		<cfreturn variables.BizType>
	</cffunction>

	<cffunction name="setBizType" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.BizType = arguments.val>
	</cffunction>

	<cffunction name="getHotLeads" output="false" access="public" returntype="any">
		<cfreturn variables.HotLeads>
	</cffunction>

	<cffunction name="setHotLeads" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.HotLeads = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getProspect" output="false" access="public" returntype="any">
		<cfreturn variables.Prospect>
	</cffunction>

	<cffunction name="setProspect" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.Prospect = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>



</cfcomponent>