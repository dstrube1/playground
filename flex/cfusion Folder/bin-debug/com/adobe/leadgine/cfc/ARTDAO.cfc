<cfcomponent output="false">

	<cffunction name="read" output="false" access="public" returntype="com.adobe.leadgine.cfc.ART[]">
		<cfargument name="id" required="false">
		<cfargument name="param" required="false">
		<cfset var qRead="">
		<cfset var obj="">
		<cfset var ret = ArrayNew(1)>

		<cfquery name="qRead" datasource="cfartgallery">
			select 	ARTID, ARTISTID, ARTNAME, DESCRIPTION, PRICE, LARGEIMAGE, 
					MEDIAID, ISSOLD
			from APP.ART
			<cfif structKeyExists(arguments, "id")>
				where ARTID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#" />
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

		<cfloop query="qRead">
			<cfscript>
				obj = createObject("component", "com.adobe.leadgine.cfc.ART").init();
				obj.setARTID(qRead.ARTID);
				obj.setARTISTID(qRead.ARTISTID);
				obj.setARTNAME(qRead.ARTNAME);
				obj.setDESCRIPTION(qRead.DESCRIPTION);
				obj.setPRICE(qRead.PRICE);
				obj.setLARGEIMAGE(qRead.LARGEIMAGE);
				obj.setMEDIAID(qRead.MEDIAID);
				obj.setISSOLD(qRead.ISSOLD);
				ArrayAppend(ret, obj);
			</cfscript>
		</cfloop>
		<cfreturn ret>
	</cffunction>



	<cffunction name="create" output="false" access="public">
		<cfargument name="bean" required="true" type="com.adobe.leadgine.cfc.ART">
		<cfset var qCreate="">

		<cfset var qGetId="">

		<cfset var local1=arguments.bean.getARTISTID()>
		<cfset var local2=arguments.bean.getARTNAME()>
		<cfset var local3=arguments.bean.getDESCRIPTION()>
		<cfset var local4=arguments.bean.getPRICE()>
		<cfset var local5=arguments.bean.getLARGEIMAGE()>
		<cfset var local6=arguments.bean.getMEDIAID()>
		<cfset var local7=arguments.bean.getISSOLD()>

		<cftransaction isolation="read_committed">
			<cfquery name="qCreate" datasource="cfartgallery">
				insert into APP.ART(ARTISTID, ARTNAME, DESCRIPTION, PRICE, LARGEIMAGE, MEDIAID, ISSOLD)
				values (
					<cfqueryparam value="#local1#" cfsqltype="CF_SQL_INTEGER" null="#iif((local1 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local2#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local3#" cfsqltype="CF_SQL_CLOB" />,
					<cfqueryparam value="#local4#" cfsqltype="CF_SQL_DECIMAL" null="#iif((local4 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local5#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local6#" cfsqltype="CF_SQL_INTEGER" null="#iif((local6 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local7#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local7 eq ""), de("yes"), de("no"))#" />
				)
			</cfquery>

			<!--- If your server has a better way to get the ID that is more reliable, use that instead --->
			<cfquery name="qGetID" datasource="cfartgallery">
				select ARTID
				from APP.ART
				where ARTISTID = <cfqueryparam value="#local1#" cfsqltype="CF_SQL_INTEGER" null="#iif((local1 eq ""), de("yes"), de("no"))#" />
				  and ARTNAME = <cfqueryparam value="#local2#" cfsqltype="CF_SQL_VARCHAR" />
				  and DESCRIPTION LIKE <cfqueryparam value="#local3#" cfsqltype="CF_SQL_CLOB" />
				  and PRICE = <cfqueryparam value="#local4#" cfsqltype="CF_SQL_DECIMAL" null="#iif((local4 eq ""), de("yes"), de("no"))#" />
				  and LARGEIMAGE = <cfqueryparam value="#local5#" cfsqltype="CF_SQL_VARCHAR" />
				  and MEDIAID = <cfqueryparam value="#local6#" cfsqltype="CF_SQL_INTEGER" null="#iif((local6 eq ""), de("yes"), de("no"))#" />
				  and ISSOLD = <cfqueryparam value="#local7#" cfsqltype="CF_SQL_SMALLINT" null="#iif((local7 eq ""), de("yes"), de("no"))#" />
				order by ARTID desc
			</cfquery>
		</cftransaction>

		<cfscript>
			arguments.bean.setARTID(qGetID.ARTID);
		</cfscript>
		<cfreturn arguments.bean />
	</cffunction>



	<cffunction name="update" output="false" access="public">
		<cfargument name="oldBean" required="true" type="com.adobe.leadgine.cfc.ART">
		<cfargument name="newBean" required="true" type="com.adobe.leadgine.cfc.ART">
		<cfset var qUpdate="">

		<cfquery name="qUpdate" datasource="cfartgallery" result="status">
			update APP.ART
			set ARTISTID = <cfqueryparam value="#arguments.newBean.getARTISTID()#" cfsqltype="CF_SQL_INTEGER" null="#iif((arguments.newBean.getARTISTID() eq ""), de("yes"), de("no"))#" />,
				ARTNAME = <cfqueryparam value="#arguments.newBean.getARTNAME()#" cfsqltype="CF_SQL_VARCHAR" />,
				DESCRIPTION = <cfqueryparam value="#arguments.newBean.getDESCRIPTION()#" cfsqltype="CF_SQL_CLOB" />,
				PRICE = <cfqueryparam value="#arguments.newBean.getPRICE()#" cfsqltype="CF_SQL_DECIMAL" null="#iif((arguments.newBean.getPRICE() eq ""), de("yes"), de("no"))#" />,
				LARGEIMAGE = <cfqueryparam value="#arguments.newBean.getLARGEIMAGE()#" cfsqltype="CF_SQL_VARCHAR" />,
				MEDIAID = <cfqueryparam value="#arguments.newBean.getMEDIAID()#" cfsqltype="CF_SQL_INTEGER" null="#iif((arguments.newBean.getMEDIAID() eq ""), de("yes"), de("no"))#" />,
				ISSOLD = <cfqueryparam value="#arguments.newBean.getISSOLD()#" cfsqltype="CF_SQL_SMALLINT" null="#iif((arguments.newBean.getISSOLD() eq ""), de("yes"), de("no"))#" />
			where ARTID = <cfqueryparam value="#arguments.oldBean.getARTID()#" cfsqltype="CF_SQL_INTEGER" />
			  and ARTISTID = <cfqueryparam value="#arguments.oldBean.getARTISTID()#" cfsqltype="CF_SQL_INTEGER" />
			  and ARTNAME = <cfqueryparam value="#arguments.oldBean.getARTNAME()#" cfsqltype="CF_SQL_VARCHAR" />
			  and DESCRIPTION LIKE <cfqueryparam value="#arguments.oldBean.getDESCRIPTION()#" cfsqltype="CF_SQL_CLOB" />
			  and PRICE = <cfqueryparam value="#arguments.oldBean.getPRICE()#" cfsqltype="CF_SQL_DECIMAL" />
			  and LARGEIMAGE = <cfqueryparam value="#arguments.oldBean.getLARGEIMAGE()#" cfsqltype="CF_SQL_VARCHAR" />
			  and MEDIAID = <cfqueryparam value="#arguments.oldBean.getMEDIAID()#" cfsqltype="CF_SQL_INTEGER" />
			  and ISSOLD = <cfqueryparam value="#arguments.oldBean.getISSOLD()#" cfsqltype="CF_SQL_SMALLINT" />
		</cfquery>
		<!--- if we didn't affect a single record, the update failed --->
		<cfquery name="qUpdateResult" datasource="cfartgallery"  result="status">
			select ARTID
			from APP.ART
			where ARTID = <cfqueryparam value="#arguments.newBean.getARTID()#" cfsqltype="CF_SQL_INTEGER" />
			  and ARTISTID = <cfqueryparam value="#arguments.newBean.getARTISTID()#" cfsqltype="CF_SQL_INTEGER" />
			  and ARTNAME = <cfqueryparam value="#arguments.newBean.getARTNAME()#" cfsqltype="CF_SQL_VARCHAR" />
			  and DESCRIPTION LIKE <cfqueryparam value="#arguments.newBean.getDESCRIPTION()#" cfsqltype="CF_SQL_CLOB" />
			  and PRICE = <cfqueryparam value="#arguments.newBean.getPRICE()#" cfsqltype="CF_SQL_DECIMAL" />
			  and LARGEIMAGE = <cfqueryparam value="#arguments.newBean.getLARGEIMAGE()#" cfsqltype="CF_SQL_VARCHAR" />
			  and MEDIAID = <cfqueryparam value="#arguments.newBean.getMEDIAID()#" cfsqltype="CF_SQL_INTEGER" />
			  and ISSOLD = <cfqueryparam value="#arguments.newBean.getISSOLD()#" cfsqltype="CF_SQL_SMALLINT" />
		</cfquery>
		<cfif status.recordcount EQ 0>
			<cfthrow type="conflict" message="Unable to update record">
		</cfif>
		<cfreturn arguments.newBean />
	</cffunction>



	<cffunction name="delete" output="false" access="public" returntype="void">
		<cfargument name="bean" required="true" type="com.adobe.leadgine.cfc.ART">
		<cfset var qDelete="">

		<cfquery name="qDelete" datasource="cfartgallery" result="status">
			delete
			from APP.ART
			where ARTID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.bean.getARTID()#" />
		</cfquery>

		<!--- Did we delete the record? --->
		<cfquery name="qDeleteResult" datasource="cfartgallery"  result="status">
			select ARTID
			from APP.ART
			where ARTID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.bean.getARTID()#" />
		</cfquery>
		<cfif status.recordcount NEQ 0>
			<cfthrow type="conflict" message="Unable to delete record">
		</cfif>

	</cffunction>

	<cffunction name="count" output="false" access="public" returntype="Numeric">
		<cfargument name="id" required="false">
		<cfargument name="param" required="false">
		<cfset var qRead="">

		<cfquery name="qRead" datasource="cfartgallery">
			select COUNT(*) as totalRecords
			from APP.ART
			<cfif structKeyExists(arguments, "id")>
				where ARTID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#" />
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