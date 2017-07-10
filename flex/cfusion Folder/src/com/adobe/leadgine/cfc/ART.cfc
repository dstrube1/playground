<cfcomponent output="false" alias="com.adobe.leadgine.cfc.ART">
	<!---
		 These are properties that are exposed by this CFC object.
		 These property definitions are used when calling this CFC as a web services, 
		 passed back to a flash movie, or when generating documentation

		 NOTE: these cfproperty tags do not set any default property values.
	--->
	<cfproperty name="ARTID" type="numeric" default="0">
	<cfproperty name="ARTISTID" type="numeric" default="0">
	<cfproperty name="ARTNAME" type="string" default="">
	<cfproperty name="DESCRIPTION" type="string" default="">
	<cfproperty name="PRICE" type="numeric" default="0">
	<cfproperty name="LARGEIMAGE" type="string" default="">
	<cfproperty name="MEDIAID" type="numeric" default="0">
	<cfproperty name="ISSOLD" type="numeric" default="0">

	<cfscript>
		//Initialize the CFC with the default properties values.
		variables.ARTID = 0;
		variables.ARTISTID = 0;
		variables.ARTNAME = "";
		variables.DESCRIPTION = "";
		variables.PRICE = 0;
		variables.LARGEIMAGE = "";
		variables.MEDIAID = 0;
		variables.ISSOLD = 0;
	</cfscript>

	<cffunction name="init" output="false" returntype="ART">
		<cfreturn this>
	</cffunction>
	<cffunction name="getARTID" output="false" access="public" returntype="any">
		<cfreturn variables.ARTID>
	</cffunction>

	<cffunction name="setARTID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.ARTID = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getARTISTID" output="false" access="public" returntype="any">
		<cfreturn variables.ARTISTID>
	</cffunction>

	<cffunction name="setARTISTID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.ARTISTID = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getARTNAME" output="false" access="public" returntype="any">
		<cfreturn variables.ARTNAME>
	</cffunction>

	<cffunction name="setARTNAME" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.ARTNAME = arguments.val>
	</cffunction>

	<cffunction name="getDESCRIPTION" output="false" access="public" returntype="any">
		<cfreturn variables.DESCRIPTION>
	</cffunction>

	<cffunction name="setDESCRIPTION" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.DESCRIPTION = arguments.val>
	</cffunction>

	<cffunction name="getPRICE" output="false" access="public" returntype="any">
		<cfreturn variables.PRICE>
	</cffunction>

	<cffunction name="setPRICE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.PRICE = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getLARGEIMAGE" output="false" access="public" returntype="any">
		<cfreturn variables.LARGEIMAGE>
	</cffunction>

	<cffunction name="setLARGEIMAGE" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset variables.LARGEIMAGE = arguments.val>
	</cffunction>

	<cffunction name="getMEDIAID" output="false" access="public" returntype="any">
		<cfreturn variables.MEDIAID>
	</cffunction>

	<cffunction name="setMEDIAID" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.MEDIAID = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>

	<cffunction name="getISSOLD" output="false" access="public" returntype="any">
		<cfreturn variables.ISSOLD>
	</cffunction>

	<cffunction name="setISSOLD" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfif (IsNumeric(arguments.val)) OR (arguments.val EQ "")>
			<cfset variables.ISSOLD = arguments.val>
		<cfelse>
			<cfthrow message="'#arguments.val#' is not a valid numeric"/>
		</cfif>
	</cffunction>



</cfcomponent>