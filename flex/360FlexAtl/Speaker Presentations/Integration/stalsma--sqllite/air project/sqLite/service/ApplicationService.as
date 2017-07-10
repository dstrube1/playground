package service
{
	
	
	public class ApplicationService
	{
		private var _userDAO:UserDAO;
		private var _phoneDAO:PhoneNrDAO;
		private var _userSOAPService:UserWebService;
		private var _userRemoteService:RemotingService;

		
		function ApplicationService( dbFilename:String ) {
			var connection:DatabaseConnection = new DatabaseConnection(dbFilename);
			_phoneDAO = new PhoneNrDAO( connection.connection );
			_userDAO = new UserDAO( connection.connection, phoneDAO );
			_userSOAPService = new UserWebService();
			_userRemoteService = new RemotingService();
		}
		
		public function get userDAO():UserDAO {
			return _userDAO;
		}
		
		public function get phoneDAO():PhoneNrDAO {
			return _phoneDAO;
		}
		
		public function get userSOAPService():UserWebService {	
			return _userSOAPService; 
		}

		public function get userRemoteService():RemotingService {	
			return _userRemoteService; 
		}

	}
}