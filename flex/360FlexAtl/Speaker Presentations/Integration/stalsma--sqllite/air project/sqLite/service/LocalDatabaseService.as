//thanks to http://patsmitherman.blogspot.com/2007/10/air-local-database-helper-class.html


package service
{
	import flash.data.SQLColumnSchema;
	import flash.data.SQLConnection;
	import flash.data.SQLSchemaResult;
	import flash.data.SQLStatement;
	import flash.data.SQLTableSchema;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;
		
	public class LocalDatabaseService extends EventDispatcher
	{
			
		private var conn:SQLConnection;
		private var beanClass:Class;
		private var tableName:String;		
				
		//*************************************************************************************************************		
		//  Connect to database file
		//*************************************************************************************************************
		public function LocalDatabaseService(myConn:SQLConnection, beanClass:Class, tableName:String):void{
			conn = myConn;
			this.beanClass = beanClass;
			this.tableName = tableName;
		}
				
		//*************************************************************************************************************
		// Create Table
		//*************************************************************************************************************
		public function createTable(myObj:Object):void{
			var myReflecObj:Object = mx.utils.ObjectUtil.getClassInfo(myObj);
			var tableStr:String = "";
			var sql:String = "";
			var colType:String = "";
			
			for(var i:Number = 0; i<myReflecObj.properties.length; i++){
				colType = getTypeString(myObj[myReflecObj.properties[i]]);
				
				if(myReflecObj.properties[i] != "ID" && colType.length){
					tableStr += myReflecObj.properties[i] + " " + colType + ", ";						
				}									
			}
			
			tableStr = tableStr.substring(0, (tableStr.length - 2));
			sql = "CREATE TABLE IF NOT EXISTS " + tableName + " (ID INTEGER PRIMARY KEY AUTOINCREMENT, " + tableStr + ")";
			
			executeSQL( sql );
			
			syncTables( myObj );
		}
		

		//  createTable helper function
		private function getTypeString(myProp:Object):String{
			if(myProp is Number){
				return "NUMBER";
			} else if (myProp is Date){
				return "TEXT";
			} else if (myProp is String){
				return "TEXT";
			} else if (myProp is Array || myProp is ArrayCollection){
				return "";
			} else {
				return "BLOB";
			}
		}		
		
		
	private function syncTables( myObj:Object ):void {
			var aColumns:Array = getTableColumns(tableName);
			var myReflecObj:Object = mx.utils.ObjectUtil.getClassInfo(myObj);
			var colType:String = "";
			
			for(var i:Number = 0; i<myReflecObj.properties.length; i++){
				colType = getTypeString(myObj[myReflecObj.properties[i]]);

				if(myReflecObj.properties[i] != "ID" && colType.length){
					if( !columnExists( aColumns, myReflecObj.properties[i] ) ) {
						deployColumn( myReflecObj.properties[i], colType );
					}
				}									
			}
		}
		
		
		private function deployColumn( colName:String, colType:String ):void {			
			var sql:String = "ALTER TABLE " + tableName + " ADD COLUMN '" + colName + "' " + colType;
			executeSQL( sql );
		}
	
		private function columnExists( aColumns:Array, colName:String ):Boolean {
			var bFound:Boolean = false;
			
			for( var i:int = 0 ; i < aColumns.length ; i++ ) {
				var curCol:SQLColumnSchema = aColumns[i] as SQLColumnSchema;
				if( colName == curCol.name ) {
					bFound = true;
					break;
				}
			}
			
			return bFound; 
		}  
		private function getTableColumns( tableName:String ):Array {
			conn.loadSchema( SQLTableSchema, tableName );
			var schema:SQLSchemaResult = conn.getSchemaResult();
						
			return schema.tables[0].columns;
		}
			
			
		//*************************************************************************************************************
		// This is a wrapper for the nonparameterized sql calls
		//*************************************************************************************************************
		private function executeSQL( sql:String ):SQLStatement {
			var sqlStmt:SQLStatement =  new SQLStatement();

			sqlStmt.sqlConnection = conn;
			sqlStmt.text = sql;
			sqlStmt.itemClass = beanClass;						
			sqlStmt.execute();
			
			return sqlStmt;	
		}	
	
		//*************************************************************************************************************
		// Save Object - Either Add or Update based on object ID
		//*************************************************************************************************************
		public function save(myObj:Object):void{
			if(myObj.ID == 0){
				add(myObj);
			} else {
				update(myObj);
			}			
		}
		
		//*************************************************************************************************************
		// Add Object
		//*************************************************************************************************************				
		public function add(myObj:Object):void{
			var myColStr:String = "";
			var myParamStr:String = "";
			var myReflecObj:Object = mx.utils.ObjectUtil.getClassInfo(myObj);
			var sqlStmt:SQLStatement =  new SQLStatement();

			sqlStmt.sqlConnection = conn;
							
			for(var i:Number = 0; i<myReflecObj.properties.length; i++){
				var colType:String = getTypeString(myObj[myReflecObj.properties[i]]);

				if(myReflecObj.properties[i] != "ID" && colType.length){
					myColStr += myReflecObj.properties[i] + ", ";
					myParamStr += ":" + myReflecObj.properties[i] + ", ";
					sqlStmt.parameters[":" + myReflecObj.properties[i]] = myObj[myReflecObj.properties[i]];
				}				
			}
							
			myColStr = myColStr.substring(0, (myColStr.length - 2));
			myParamStr = myParamStr.substring(0, (myParamStr.length - 2));
			sqlStmt.text = "INSERT INTO " + tableName + " (" + myColStr + ") VALUES (" + myParamStr + ")";
			sqlStmt.execute();			
		}
				
		//*************************************************************************************************************
		// Select all objects
		//*************************************************************************************************************
		public function getAll(orderBy:String="ID"):ArrayCollection{
			var sql:String = "SELECT * FROM " + tableName + " ORDER BY " + orderBy;

			var sqlStmt:SQLStatement =  executeSQL( sql );
			
			var result:ArrayCollection = new ArrayCollection( sqlStmt.getResult().data );
			
			return result;
		}
				

		//*************************************************************************************************************
		// Select objects based on prop map
		//	Expects array of objects (name, value) for filtering
		//*************************************************************************************************************
		public function getByProperty( aProperty:Array, orderBy:String="ID" ):ArrayCollection{
			var myColStr:String = "";
			var myParamStr:String = "";
			var sqlStmt:SQLStatement =  new SQLStatement();
			var sql:String = "SELECT * FROM " + tableName + " WHERE 1=1 ";
							
			for(var i:Number = 0; i < aProperty.length; i++){
				sql += "AND " + aProperty[i].name + " = :" + aProperty[i].name;
				sqlStmt.parameters[":" + aProperty[i].name] = aProperty[i].value;
			}
			sql += " ORDER BY " + orderBy;
			
			sqlStmt.sqlConnection = conn;
			sqlStmt.itemClass = beanClass;						
			sqlStmt.text = sql;
			sqlStmt.execute();			
			
			var result:ArrayCollection = new ArrayCollection( sqlStmt.getResult().data );
			
			return result;
		}


		//*************************************************************************************************************
		// Select object by ID
		//*************************************************************************************************************
		public function getByID(myID:Number):Object{
			var sqlStmt:SQLStatement =  new SQLStatement();
			var sql:String = "SELECT * FROM " + tableName + " WHERE ID = :ID";

			sqlStmt.parameters[":ID"] = myID;
			sqlStmt.sqlConnection = conn;
			sqlStmt.text = sql;
			sqlStmt.itemClass = beanClass;						
			sqlStmt.execute();
			
			var aResult:Array = sqlStmt.getResult().data;
			var result:Object;
			
			if( aResult.length ) {
				result = aResult[0];
			}
			
			return result;
		}
				
		//*************************************************************************************************************
		// Update object
		//*************************************************************************************************************		
		public function update(myObj:Object):void{
			var sqlStmt:SQLStatement =  new SQLStatement();
			var myColStr:String = "";
			var myReflecObj:Object = mx.utils.ObjectUtil.getClassInfo(myObj);

			sqlStmt.sqlConnection = conn;
							
			for(var i:Number = 0; i<myReflecObj.properties.length; i++){
				var colType:String = getTypeString(myObj[myReflecObj.properties[i]]);

				if(myReflecObj.properties[i] != "ID" && colType.length){
					myColStr += myReflecObj.properties[i] + " = :" + myReflecObj.properties[i] + ", " ;
					sqlStmt.parameters[":" + myReflecObj.properties[i]] = myObj[myReflecObj.properties[i]];
				}				
			}
			
			sqlStmt.parameters[":ID"] = myObj.ID;							
			myColStr = myColStr.substring(0, (myColStr.length - 2));			
			sqlStmt.text = "UPDATE " + tableName + " SET " + myColStr + " WHERE ID = :ID";
			sqlStmt.execute();			
		}
				
		//*************************************************************************************************************
		// Delete object
		//*************************************************************************************************************
		public function remove(myObj:Object):void{
			var sqlStmt:SQLStatement =  new SQLStatement();
			var sql:String = "DELETE FROM " + tableName + " WHERE ID = :ID";

			sqlStmt.sqlConnection = conn;
			sqlStmt.text = sql;
			sqlStmt.parameters[":ID"] = myObj.ID;			
			sqlStmt.execute();
		}
		
		//*************************************************************************************************************
		// Delete all object
		//*************************************************************************************************************
		public function removeAll():void{
			var sqlStmt:SQLStatement =  new SQLStatement();
			var sql:String = "DELETE FROM " + tableName;;

			sqlStmt.sqlConnection = conn;
			sqlStmt.text = sql;
			sqlStmt.execute();
		}
					
	}
}
