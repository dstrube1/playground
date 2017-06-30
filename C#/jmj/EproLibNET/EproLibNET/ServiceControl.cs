using System;
using System.Runtime.InteropServices;

namespace EproLibNET
{

	/// <summary>
	/// Summary description for ServiceControl.
	/// </summary>
	public class ServiceControl
	{
		[Flags]

			public enum ServiceControlAccessRights : int

		{

			StandardRightsRequired = 0xf0000,

			Connect = 0x00001,

			CreateService = 0x00002,

			EnumerateService = 0x00004,

			Lock = 0x00008,

			QueryLockStatus = 0x00010,

			ModifyBootConfig = 0x00020,

			AllAccess = 0xf003F

		}

		[Flags]

			public enum ServiceControlType

		{

			OwnProcess = 0x010,

			ShareProcess = 0x020,

			KernelDriver = 0x001,

			FileSystemDriver = 0x002,

			InteractiveProcess = 0x100

		}

		[Flags]
			public enum ServiceStartType
		{
			SERVICE_AUTO_START = 0x002,
			SERVICE_DEMAND_START = 0x003,
			SERVICE_DISABLED = 0x004
		}

		[DllImport( "kernel32.dll", EntryPoint = "GetLastError" )]

		public static extern int GetLastError();

		[DllImport( "advapi32.dll", EntryPoint = "OpenSCManager" )]

		public static extern int OpenSCManager( string machineName, string

			databaseName, ServiceControlAccessRights desiredAccess );

		[DllImport( "advapi32.dll", EntryPoint = "CloseServiceHandle" )]

		public static extern bool CloseServiceHandle( int hSCObject );

		[DllImport( "advapi32.dll", EntryPoint = "OpenService" )]

		public static extern int OpenService( int hSCManager, string

			serviceName, ServiceControlAccessRights desiredAccess );

		[DllImport( "advapi32.dll", EntryPoint = "LockServiceDatabase" )]

		public static extern int LockServiceDatabase( int handle );

		[DllImport( "advapi32.dll", EntryPoint = "UnlockServiceDatabase" )]

		public static extern bool UnlockServiceDatabase( int handle );

		[DllImport( "advapi32.dll", EntryPoint = "ChangeServiceConfig" )]

		public static extern bool ChangeServiceConfig( int hService,

			int dwServiceType, ServiceStartType dwStartType, int dwErrorControl,

			string lpBinaryPathName, string lpLoadOrderGroup, IntPtr lpdwTagId,

			string lpDependencies, string lpServiceStartName, string lpPassword,

			string lpDisplayName );

		//And the actual code to change the service properties:

		public static void ChangeServiceStartType( string serviceName, ServiceStartType
			flags )

		{

			int ServiceNoChange = -1;

			int hScm = OpenSCManager( null, null,

				ServiceControlAccessRights.AllAccess );

			int hSvc = OpenService( hScm, serviceName,

				ServiceControlAccessRights.AllAccess );

			ChangeServiceConfig( hSvc, ServiceNoChange, flags, ServiceNoChange, 

				null, null, IntPtr.Zero, null, null, null, null );

			CloseServiceHandle( hSvc );

			CloseServiceHandle( hScm );

		}

		public ServiceControl()
		{
		}
	}
}
