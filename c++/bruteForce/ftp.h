#pragma once

#define SENDING_DATA_PORT_20			150
#define COMMAND_NOT_IMPLEMENTED			202
#define CONNECTED						220
#define AUTHENTICATED					230
#define NEED_PASSWORD					331
#define AUTHENTICATION_FAILED			530


namespace Ftp
{

	using namespace System;
	using namespace System::Net;
	using namespace System::IO;
	using namespace System::Text;
	//using namespace System.Text::ASCIIEncoding;
	using namespace System::Net::Sockets;
	using namespace System::Configuration;
	using namespace System::Resources;

	//#pragma managed
	// __gc makes it managed

	__gc class TcpEventArgs
	{
	private:
		int m_FCode;
		String* m_FData;
	
	public:
		TcpEventArgs()
		{
		}
		TcpEventArgs(int code, String* data)
		{
			New(code, data);
		}
		void New(int code, String* data)
		{
			m_FCode = code;
			m_FData = data;
		}
		__property int get_Code()
		{
			return m_FCode;
		}
		__property String* get_Data()
		{
			return m_FData;
		}
	};

	__gc class RawDataReceivedEventArgs: public TcpEventArgs
	{
	private:
		String* m_FRawData;
	public:
		RawDataReceivedEventArgs(String* rawData)
		{
			TcpEventArgs::New(-1, "");
			m_FRawData = rawData;
		}
		void New(String* rawData)
		{
			TcpEventArgs::New(-1, "");
			m_FRawData = rawData;
		}

		void New(String* rawData, int code, String* data)
		{
			TcpEventArgs::New(code, data);
			m_FRawData = rawData;
		}
		__property String* get_RawData()
		{
			return m_FRawData;
		}
	};

	__gc class ConnectionEventArgs: public TcpEventArgs
	{
	private:
		bool m_FConnected;

	public:
		ConnectionEventArgs(bool connected)
		{
			m_FConnected = false;
			New(connected);
		}
		ConnectionEventArgs(bool connected, int code, String* data)
		{
			m_FConnected = false;
			New(connected, code, data);
		}
		void New(bool connected)
		{
			TcpEventArgs::New(-1, "");
			m_FConnected = connected;
		}

		void New(bool connected, int code, String* data)
		{
			TcpEventArgs::New(code, data);
			m_FConnected = connected;
		}
		__property bool get_Connected()
		{
			return m_FConnected;
		}
	};

	__gc class AuthenticationEventArgs: public TcpEventArgs
	{
	private:
		bool m_FAuthenticated;

	public:
		AuthenticationEventArgs(bool authenticated)
		{
			m_FAuthenticated = false;
			New(authenticated);
		}
		AuthenticationEventArgs(bool authenticated, int code, String* data)
		{
			m_FAuthenticated = false;
			New(authenticated, code, data);
		}
		void New(bool authenticated)
		{
			TcpEventArgs::New(-1, "");
			m_FAuthenticated = authenticated;
		}

		void New(bool authenticated, int code, String* data)
		{
			TcpEventArgs::New(code, data);
			m_FAuthenticated = authenticated;
		}
		__property bool get_Authenticated()
		{
			return m_FAuthenticated;
		}
	};


	public __delegate void RawDataReceivedEvent(Object* sender, RawDataReceivedEventArgs* e);
	public __delegate void TcpEvent(Object* sender, TcpEventArgs* e);
	public __delegate void ConnectionEvent(Object* sender, ConnectionEventArgs* e);
	public __delegate void AuthenticationEvent(Object* sender, AuthenticationEventArgs* e);

	public __gc class CFtp
	{
	public:
		CFtp();
		__property bool get_Connected(void)
		{
			return m_Connected;
		}
		void		Initialise(String* host, String* user, String* password, int port);
		void		Connect(void);
		void		Disconnect(void);
		__event RawDataReceivedEvent* OnRawDataReceivedEvent;
		__event TcpEvent* OnTcpEvent;
		__event AuthenticationEvent* OnAuthentication;
		__event ConnectionEvent* OnConnectionEvent;

	protected:


	private:
		bool		m_Connected;
		void		ReadResponse();
		String*		m_RemoteHost;
		String*		m_UserName ;
		String*		m_Password;
		int			m_Port;
		Socket*		m_ClientSocket;
		String*		m_Response;
		String*		ReadLine();
		String*		ReadLine(bool clearResponse);
		void		BroadcastResponse(String* reply);
		

	};

}