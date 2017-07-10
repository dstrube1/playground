package service
{
	import flash.data.SQLConnection;
	import flash.filesystem.File;
	
	public class DatabaseConnection
	{
		private var _connection:SQLConnection;
		
		public function DatabaseConnection( dbFilename:String ) {
			_connection = new SQLConnection();
			var dbFile:File = File.applicationStorageDirectory.resolvePath(dbFilename);
			connection.open(dbFile);
		}

		public function get connection():SQLConnection {
			return _connection;
		}
	}
}