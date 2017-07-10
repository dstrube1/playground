package service
{
	import flash.data.SQLConnection;
	import flash.net.Responder;
	
	import mx.collections.ArrayCollection;
	
	import vo.PhoneNr;
	
	public class PhoneNrDAO
	{
		private const tableName:String = "phoneNrs";
		private var localDatabaseService:LocalDatabaseService;
		private var myConn:SQLConnection;
		
		[Bindable] 
		private var myStatus:String = "";
		
		function PhoneNrDAO( dbconnection:SQLConnection) {
			myConn = dbconnection; 
			
			localDatabaseService = new LocalDatabaseService(myConn, PhoneNr, "phoneNr");
			initializeDBTable();
		}
		
		private function initializeDBTable():void {
			createTable( new PhoneNr() );
		}
		
		public function createTable( myObj:PhoneNr ):void{
			localDatabaseService.createTable( myObj);
		}
		
		public function save( myObj:PhoneNr):void{
			localDatabaseService.save( myObj);
		}
		
		public function add( myObj:PhoneNr, myResponder:Responder):void{
			localDatabaseService.add( myObj);
		}
			
		public function getAll( orderBy:String="type"):ArrayCollection{
			return localDatabaseService.getAll( orderBy );
		}
		
		public function getByID( myID:Number):PhoneNr {
			return localDatabaseService.getByID( myID ) as PhoneNr;
		}
		
		public function getByUserID( userid:String):ArrayCollection {
			return localDatabaseService.getByProperty( [ {name:"userid", value:userid} ] ) as ArrayCollection;
		}
		
		public function update( myObj:PhoneNr):void{
			localDatabaseService.update( myObj);
		}
				
		public function bulkInsert( arrayOfBean:ArrayCollection ):void {
			for( var i:int = 0 ; i < arrayOfBean.length ; i++ ) {
				save( arrayOfBean.getItemAt(i) as PhoneNr );
			}
		}
		
		public function remove( myObj:PhoneNr):void{
			localDatabaseService.remove( myObj);
		}

		public function removeAll():void{
			localDatabaseService.removeAll();
		}
	}
}