package service
{
	import flash.data.SQLConnection;
	import flash.errors.SQLError;
	import flash.net.Responder;
	
	import mx.collections.ArrayCollection;
	
	import vo.UserBean;
	
	public class UserDAO
	{
		private const userTableName:String = "users";
		private var localDatabaseService:LocalDatabaseService;
		private var myConn:SQLConnection;
		private var phoneDAO:PhoneNrDAO;
		
		[Bindable] 
		private var myStatus:String = "";
		
		function UserDAO( dbconnection:SQLConnection, phoneNrDAOParam:PhoneNrDAO ) {
			myConn = dbconnection; 
			phoneDAO = phoneNrDAOParam; 
			
			localDatabaseService = new LocalDatabaseService(myConn, UserBean, "user");
			initializeDBTable();
		}
		
		private function initializeDBTable():void {
			createTable( new UserBean() );
		}
		
		public function createTable( myObj:UserBean ):void{
			localDatabaseService.createTable( myObj);
		}
		
		public function save( myObj:UserBean):void{
			localDatabaseService.save( myObj );
			
			//save the phone nrs
			for( var i:int = 0 ; i < myObj.aPhoneNr.length ; i++ ) {
				phoneDAO.save( myObj.aPhoneNr[i] );
			}
		}
		
		public function add( myObj:UserBean, myResponder:Responder):void{
			localDatabaseService.add( myObj);
		}
			
		public function getAll( orderBy:String="lastName, firstName"):ArrayCollection{
			return localDatabaseService.getAll( orderBy);
		}
		
		public function getByID( myID:Number):UserBean {
			var bean:UserBean = localDatabaseService.getByID( myID ) as UserBean;
			bean.aPhoneNr = phoneDAO.getByUserID( bean.userid );
			
			return bean;
		}
		
		public function update( myObj:UserBean):void{
			localDatabaseService.update( myObj);
		}
				
		public function bulkInsert( arrayOfBean:ArrayCollection ):void {
			for( var i:int = 0 ; i < arrayOfBean.length ; i++ ) {
				save( arrayOfBean.getItemAt(i) as UserBean );
			}
		}
		
		public function remove( myObj:UserBean ):void{
			//save the phone nrs
			for( var i:int = 0 ; i < myObj.aPhoneNr.length ; i++ ) {
				phoneDAO.remove( myObj.aPhoneNr[i] );
			}

			localDatabaseService.remove( myObj );
		}

		public function removeAll():void{
			phoneDAO.removeAll();
			localDatabaseService.removeAll();
		}
		
		
		/*
		private function onDatabaseCreated(event:Event):void{
			myStatus += "Database created <br/>";
		}
		
		private function onTableCreatedResult(event:SQLResult):void{
			myStatus += "Table created<br/>";
		}
		
		private function onObjectsRetrievedResult(event:SQLResult):void{
			myStatus += "Objects retrieved";
		}
		
		private function onObjectInsertedResult(event:SQLResult):void{
			myStatus += "Object inserted<br/>";
		}
		
		private function onObjectUpdatedResult(event:SQLResult):void{
			myStatus += "Object updated<br/>";
		}
		
		private function onObjectRemovedResult(event:SQLResult):void{
			myStatus += "Object deleted<br/>";
		}		
		*/
		private function onFault(error:SQLError):void{
			myStatus += "Error Name: " + error.name + "<br/>";
			myStatus += "Error Message: " + error.message + "<br/>";
		}
	}
}