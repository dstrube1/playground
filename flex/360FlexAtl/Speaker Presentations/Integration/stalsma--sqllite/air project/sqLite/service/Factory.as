package service
{
	import model.ApplicationModel;
	
	public class Factory
	{
		static private var _instance:Factory;
		private var _applicationModel:ApplicationModel;
		private var _applicationService:ApplicationService;
		
		function Factory() {
			_applicationModel = new ApplicationModel();
			_applicationService = new ApplicationService( _applicationModel.dbFileName );
		}
		
		static public function getInstance():Factory {
			if( !Factory._instance ) {
				Factory._instance = new Factory();
			}
			
			return Factory._instance;
		}
		
		public function get applicationModel():ApplicationModel {	
			return _applicationModel; 
		}
		
		public function get applicationService():ApplicationService {	
			return _applicationService; 
		}
	}
}