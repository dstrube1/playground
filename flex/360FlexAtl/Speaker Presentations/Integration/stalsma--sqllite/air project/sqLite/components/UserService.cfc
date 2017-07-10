<cfcomponent output="false">
	<cffunction name="getUsers" returntype="array" access="remote">
		<cfset var qList = generateUsers(100) />
		<cfset var tmpObj = "" />
		<cfset var i = "" />
		<cfset var arrObjects = arrayNew(1) />

		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = queryRowToStruct(qList,i) />
			<cfset tmpObj.phoneNr = ArrayNew(1) />
			<cfset arrayAppend( tmpObj.phoneNr, generatePhoneNr("work") ) />
			<cfset arrayAppend( tmpObj.phoneNr, generatePhoneNr("mobile") ) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
		<cfreturn arrObjects>
	</cffunction>


	<cffunction name="generateUsers" returntype="query" access="private">
		<cfargument name="numUsers" type="numeric" required="false" default="100" />

		<cfset var fName = "JAMES,JOHN,ROBERT,MICHAEL,MARY,WILLIAM,DAVID,RICHARD,CHARLES,JOSEPH,THOMAS,PATRICIA,CHRISTOPHER,LINDA,BARBARA,DANIEL,PAUL,MARK,ELIZABETH,JENNIFER,DONALD,GEORGE,MARIA,KENNETH,SUSAN,STEVEN,EDWARD,MARGARET,BRIAN,DOROTHY,RONALD,ANTHONY,LISA,KEVIN,NANCY,KAREN,BETTY,HELEN,JASON,MATTHEW,GARY,TIMOTHY,SANDRA,JOSE,LARRY,JEFFREY,DONNA,FRANK,CAROL,RUTH,SCOTT,ERIC,STEPHEN,ANDREW,SHARON,MICHELLE,LAURA,SARAH,KIMBERLY,DEBORAH,JESSICA,RAYMOND,SHIRLEY,CYNTHIA,ANGELA,MELISSA,BRENDA,AMY,GREGORY,ANNA,JOSHUA,JERRY,REBECCA,VIRGINIA,KATHLEEN,PAMELA,DENNIS,MARTHA,DEBRA,AMANDA,STEPHANIE,WALTER,PATRICK,CAROLYN,CHRISTINE,PETER,MARIE,JANET,CATHERINE,HAROLD,FRANCES,DOUGLAS,HENRY,ANN,JOYCE,DIANE,ALICE,JULIE,CARL,HEATHER" />
		<cfset var lName = "SMITH,JOHNSON,WILLIAMS,JONES,BROWN,DAVIS,MILLER,WILSON,MOORE,TAYLOR,ANDERSON,THOMAS,JACKSON,WHITE,HARRIS,MARTIN,THOMPSON,GARCIA,MARTINEZ,ROBINSON,CLARK,RODRIGUEZ,LEWIS,LEE,WALKER,HALL,ALLEN,YOUNG,HERNANDEZ,KING,WRIGHT,LOPEZ,HILL,SCOTT,GREEN,ADAMS,BAKER,GONZALEZ,NELSON,CARTER,MITCHELL,PEREZ,ROBERTS,TURNER,PHILLIPS,CAMPBELL,PARKER,EVANS,EDWARDS,COLLINS,STEWART,SANCHEZ,MORRIS,ROGERS,REED,COOK,MORGAN,BELL,MURPHY,BAILEY,RIVERA,COOPER,RICHARDSON,COX,HOWARD,WARD,TORRES,PETERSON,GRAY,RAMIREZ,JAMES,WATSON,BROOKS,KELLY,SANDERS,PRICE,BENNETT,WOOD,BARNES,ROSS,HENDERSON,COLEMAN,JENKINS,PERRY,POWELL,LONG,PATTERSON,HUGHES,FLORES,WASHINGTON,BUTLER,SIMMONS,FOSTER,GONZALES,BRYANT,ALEXANDER,RUSSELL,GRIFFIN,DIAZ,HAYES" />
		<cfset var q = queryNew("userid,firstname,lastname,email,company") />
		<cfset var i = "" />
		<cfset var curFName = "" />
		<cfset var curLName = "" />


		<cfset fName = lCase(fname) />
		<cfset lName = lCase(lName) />

		<cfset fName = listToArray(fName) />
		<cfset lName = listToArray(lName) />

		<cfloop index="i" from="1" to="#arguments.numUsers#">
			<cfset curFName = fName[ randRange(1, arrayLen(fName))] />
			<cfset curLName = lName[ randRange(1, arrayLen(lName))] />
			<cfset queryAddRow(q) />
			<cfset querySetCell(q, "userid", createuuid()) />
			<cfset querySetCell(q, "firstname", curFName) />
			<cfset querySetCell(q, "lastname", curLName) />
			<cfset querySetCell(q, "email", "#curFName#.#curLName#@company.com") />
			<cfset querySetCell(q, "company", "echoeleven "  & chr( asc("A") + randRange(0,25) ) ) />
		</cfloop>

		<cfreturn q />
	</cffunction>
	
	
	<cffunction name="generatePhoneNr" access="private" returnType="struct">
		<cfargument name="type" type="string" required="true" />
		
		<cfset var st = structNew() />
		<cfset st.phoneid = createuuid() />
		<cfset st.phoneNr = generateRandomPhoneNr() />
		<cfset st.type = arguments.type />
		
		<cfreturn st />
	</cffunction>
	
	<cffunction name="generateRandomPhoneNr" access="private" returnType="string">
		<cfset var s = "(" & randRange(0,9) & randRange(0,9) & randRange(0,9) & ") " />
		<cfset s = s & randRange(0,9) & randRange(0,9) & randRange(0,9) & "-" />
		<cfset s = s & randRange(0,9) & randRange(0,9) & randRange(0,9) & randRange(0,9)  />
		
		<cfreturn s />
	</cffunction>




	<cffunction name="queryRowToStruct" access="private" output="false" returntype="struct">
		<cfargument name="qry" type="query" required="true">

		<cfscript>
			/**
			 * Makes a row of a query into a structure.
			 *
			 * @param query 	 The query to work with.
			 * @param row 	 Row number to check. Defaults to row 1.
			 * @return Returns a structure.
			 * @author Nathan Dintenfass (nathan@changemedia.com)
			 * @version 1, December 11, 2001
			 */
			//by default, do this to the first row of the query
			var row = 1;
			//a var for looping
			var ii = 1;
			//the cols to loop over
			var cols = listToArray(qry.columnList);
			//the struct to return
			var stReturn = structnew();
			//if there is a second argument, use that for the row number
			if(arrayLen(arguments) GT 1)
				row = arguments[2];
			//loop over the cols and build the struct from the query row
			for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
				stReturn[cols[ii]] = qry[cols[ii]][row];
			}
			//return the struct
			return stReturn;
		</cfscript>
	</cffunction>
</cfcomponent>