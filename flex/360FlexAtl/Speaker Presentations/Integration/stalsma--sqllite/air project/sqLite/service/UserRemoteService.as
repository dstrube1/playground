package service
{
	import flash.events.EventDispatcher;
	
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.utils.ObjectUtil;
	
	public class UserRemoteService extends EventDispatcher
	{
		private var _userRemoteService:RemoteObject;
		
		public function UserRemoteService()
		{
            _userRemoteService = new RemoteObject();
            _userRemoteService.end
            _userRemoteService.source = "sqLite.components.UserService";
            _userRemoteService.addEventListener("result", resultHandler);
            _userRemoteService.addEventListener("fault", faultHandler);

		}
		
		public function getUsers():void {
            _userRemoteService.getUsers();
		}
		
		private function resultHandler( event:ResultEvent ):void {
			
		}

		private function faultHandler( result:FaultEvent ):void {
			wsFault( result );
		}

		private function wsFault( result:FaultEvent ):void {
			Alert.show( ObjectUtil.toString( result ) );
			//Alert.show("There was an error with the remoting service", "Information");					
		}

	}
}