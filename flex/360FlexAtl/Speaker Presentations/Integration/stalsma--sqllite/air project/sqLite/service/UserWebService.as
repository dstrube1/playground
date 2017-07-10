package service
{
	import flash.events.EventDispatcher;
	
	import generated.webservices.GetUsersResultEvent;
	import generated.webservices.SOAPService;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	
	import vo.UserBean;
	
	[Event(name="GetUsersAsObject_result", type="GetUsersAsObjectResultEvent")]
	
	public class UserWebService extends EventDispatcher
	{
		private var myService:SOAPService= new SOAPService();
		
		function UserWebService() {
			
			myService.addgetUsersEventListener( getUserResult );
			myService.addSOAPServiceFaultEventListener( getUserFault );
		}
		
		private function updateMsg( s:String ):void {
			Factory.getInstance().applicationModel.statusMsg = s;
		}
		
		public function getUsers():void {
			updateMsg("Calling Webservice");
			myService.getUsers();
		}
		
		private function getUserResult( event:GetUsersResultEvent ):void {
			updateMsg("Extracting results");

			//extract the results
			var resultArray:ArrayCollection = event.result as ArrayCollection;

			//transform to array coll
			var userBeanCol:ArrayCollection = arrayToUserBeanCollection( resultArray );
			dispatchEvent( new UserDataEvent( UserDataEvent.USERDATAEVENT_NAME, userBeanCol ) );
		}
		
		private function getUserFault( result:FaultEvent ):void {
			wsFault( result );
		}

		private function wsFault( result:FaultEvent ):void {
			Alert.show("There was an error with the webservice", "Information");					
		}
		
		private function arrayToUserBeanCollection( aIn:ArrayCollection ):ArrayCollection {
			var newCollection:ArrayCollection = new ArrayCollection();
			var curItem:Object;
			
			for( var i:int = 0 ; i < aIn.length ; i++ ) {
				curItem = aIn.getItemAt(i);
				
				var newBean:UserBean = new UserBean();
				newBean.userid = curItem.USERID;
				newBean.firstName = curItem.FIRSTNAME;
				newBean.lastName = curItem.LASTNAME;
				newBean.email = curItem.EMAIL;
				newBean.company = curItem.COMPANY;
				
				newCollection.addItem( newBean );
			}
			
			return newCollection;
		}

	}
}

