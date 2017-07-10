<cfcomponent output="false">

	<!--- Code executed when component is created --->
	<cfscript>
		// Create a Data Access Object for this assembler instance
		variables.dao = CreateObject("component", "com.adobe.leadgine.ReferralsDAO");
	</cfscript>

	<cffunction name="fill" output="no" returntype="com.adobe.leadgine.Referrals[]" access="remote">
		<cfargument name="param" type="string" required="no">

		<cftry>
			<cfif structKeyExists(arguments, "param")>
				<cfreturn variables.dao.read(param=arguments.param)>
			<cfelse>
				<cfreturn variables.dao.read()>
			</cfif>

			<!--- If the SQL failed, report the error, include SQL if debugging turned on --->
			<cfcatch type="database">
				<cfif isDebugMode() AND  isDefined("cfcatch.queryError") AND isDefined("cfcatch.sql")>
					<cfset msg = "Error during fill: " & cfcatch.queryError & ". SQL was :" & cfcatch.sql>
				<cfelse>
					<cfset msg = "Error during fill: " & cfcatch.message >
				</cfif>
				<cfthrow message="#msg#">
			</cfcatch>
			<!--- If anything else happened, report the error --->
			<cfcatch type="any">
				<cfset msg = "Error during fill: " & cfcatch.message >
				<cfthrow message="#msg#">
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="get" output="no" returnType="com.adobe.leadgine.Referrals" access="remote">
		<cfargument name="uid" type="struct" required="yes">

		<cftry>
			<!--- This is the record to look up --->
			<cfset key = uid.ID>

			<cfset ret="">
			<cfset ret=variables.dao.read(id=key)>

			<cfif ArrayLen(ret) EQ 1>
				<cfreturn ret[1]>
			<cfelseif ArrayLen(ret) GT 1>
				<cfset msg="get returned more than one record when ID had a value of #key#.">
				<cfthrow message="#msg#">
			<cfelse>
				<cfset msg="get did not return anything when ID had a value of #key#.">
				<cfthrow message="#msg#">
			</cfif>

			<!--- If the SQL failed, report the error, include SQL if debugging turned on --->
			<cfcatch type="database">
				<cfif isDebugMode() AND  isDefined("cfcatch.queryError") AND isDefined("cfcatch.sql")>
					<cfset msg = "Error during get: " & cfcatch.queryError & ". SQL was :" & cfcatch.sql>
				<cfelse>
					<cfset msg = "Error during get: " & cfcatch.message >
				</cfif>
				<cfthrow message="#msg#">
			</cfcatch>
			<!--- If anything else happened, report the error --->
			<cfcatch type="any">
				<cfset msg = "Error during get: " & cfcatch.message >
				<cfthrow message="#msg#">
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="sync" output="no" returnType="array" access="remote">
		<cfargument name="changes" type="array" required="yes">

		<!-- array for the returned changes -->
		<cfset var newchanges=ArrayNew(1)>

		<!-- Loop over the changes and apply them --->
		<cfloop from="1" to="#ArrayLen(changes)#" index="i" >
			<cfset co = changes[i]>
			<cfif co.isCreate()>
				<cfset x = doCreate(co)>
			<cfelseif co.isUpdate()>
				<cfset x = doUpdate(co)>
			<cfelseif co.isDelete()>
				<cfset x = doDelete(co)>
			</cfif>
			<cfset ArrayAppend(newchanges, x)>
		</cfloop>

		<!-- Return the change objects, as this is how success or failure is indicated --->
		<cfreturn newchanges>
	</cffunction>

	<cffunction name="count" output="no" returntype="Numeric" access="remote">
		<cfargument name="param" type="string" required="no">

		<cftry>
			<cfif structKeyExists(arguments, "param")>
				<cfreturn variables.dao.count(param=arguments.param)>
			<cfelse>
				<cfreturn variables.dao.count()>
			</cfif>

			<!--- If the SQL failed, report the error, include SQL if debugging turned on --->
			<cfcatch type="database">
				<cfif isDebugMode() AND  isDefined("cfcatch.queryError") AND isDefined("cfcatch.sql")>
					<cfset msg = "Error during count: " & cfcatch.queryError & ". SQL was :" & cfcatch.sql>
				<cfelse>
					<cfset msg = "Error during count: " & cfcatch.message >
				</cfif>
				<cfthrow message="#msg#">
			</cfcatch>
			<!--- If anything else happened, report the error --->
			<cfcatch type="any">
				<cfset msg = "Error during count: " & cfcatch.message >
				<cfthrow message="#msg#">
			</cfcatch>
		</cftry>
	</cffunction>


	<cffunction name="doCreate" access="private" output="no">
		<cfargument name="co" required="yes" hint="The change object.">

		<!--- the record to create --->
		<cfset var new = co.getNewVersion()>

		<!--- TODO: Validate that all the required fields are set --->

		<cftry>
			<!--- create the record, create returns with the identity fields set --->
			<cfset variables.dao.create(new)>
			<!--- set the new version in to the change object --->
			<cfset co.setNewVersion(new)>
			<!--- mark this change as processed successfully --->
			<cfset co.processed()>

			<!--- If the SQL failed, report the error, include SQL if debugging turned on --->
			<cfcatch type="database">
				<cfif isDebugMode() AND  isDefined("cfcatch.queryError") AND isDefined("cfcatch.sql")>
					<cfset msg = "Error during create: " & cfcatch.queryError & ". SQL was :" & cfcatch.sql>
				<cfelse>
					<cfset msg = "Error during create: " & cfcatch.message >
				</cfif>
			<!--- Make sure to mark the change with an error --->
				<cfset co.fail(msg)>
			</cfcatch>
			<!--- If anything else happened, report the error --->
			<cfcatch type="any">
				<cfset msg = "Error during create: " & cfcatch.message >
				<!--- Make sure to mark the change with an error --->
				<cfset co.fail(msg)>
			</cfcatch>
		</cftry>

		<!--- Return the change object --->
		<cfreturn co>

	</cffunction>

	<cffunction name="doUpdate" access="private" output="no">
		<cfargument name="co" required="yes" hint="The change object.">

		<!--- the record to update --->
		<cfset var new = co.getNewVersion()>
		<cfset var old = co.getPreviousVersion()>

		<cftry>
			<!--- update the record --->
			<cfset new = variables.dao.update(old, new)>
			<!--- mark this change as processed successfully --->
			<cfset co.processed()>

			<!--- If there was a conflict, mark the change object.
			      Include the current version of the record --->
			<cfcatch type="conflict">
				<cfset co.conflict(variables.dao.read(id=new.getID()))>
			</cfcatch>

			<!--- If the SQL failed, report the error, include SQL if debugging turned on --->
			<cfcatch type="database">
				<cfif isDebugMode() AND  isDefined("cfcatch.queryError") AND isDefined("cfcatch.sql")>
					<cfset msg = "Error during update: " & cfcatch.queryError & ". SQL was :" & cfcatch.sql>
				<cfelse>
					<cfset msg = "Error during update: " & cfcatch.message >
				</cfif>
			<!--- Make sure to mark the change with an error --->
				<cfset co.fail(msg)>
			</cfcatch>
			<!--- If anything else happened, report the error --->
			<cfcatch type="any">
				<cfset msg = "Error during update: " & cfcatch.message >
				<!--- Make sure to mark the change with an error --->
				<cfset co.fail(msg)>
			</cfcatch>
		</cftry>

		<!--- Return the change object --->
		<cfreturn co>

	</cffunction>

	<cffunction name="doDelete" access="private" output="no">
		<cfargument name="co" required="yes" hint="The change object.">

		<!--- the record to delete --->
		<cfset var old = co.getPreviousVersion()>

		<cftry>
			<!--- delete the record --->
			<cfset variables.dao.delete(old)>
			<!--- mark this change as processed successfully --->
			<cfset co.processed()>
			<!--- If there was a conflict, mark the change object.
			      Include the current version of the record --->
			<cfcatch type="conflict">
				<cfset arr = variables.dao.read(id=old.getperson_id())>
				<cfset co.conflict(arr[1])>
			</cfcatch>

			<!--- If the SQL failed, report the error, include SQL if debugging turned on --->
			<cfcatch type="database">
				<cfif isDebugMode() AND  isDefined("cfcatch.queryError") AND isDefined("cfcatch.sql")>
					<cfset msg = "Error during delete: " & cfcatch.queryError & ". SQL was :" & cfcatch.sql>
				<cfelse>
					<cfset msg = "Error during delete: " & cfcatch.message >
				</cfif>
			<!--- Make sure to mark the change with an error --->
				<cfset co.fail(msg)>
			</cfcatch>
			<!--- If anything else happened, report the error --->
			<cfcatch type="any">
				<cfset msg = "Error during delete: " & cfcatch.message >
				<!--- Make sure to mark the change with an error --->
				<cfset co.fail(msg)>
			</cfcatch>
		</cftry>

		<!--- Return the change object --->
		<cfreturn co>

	</cffunction>


</cfcomponent>