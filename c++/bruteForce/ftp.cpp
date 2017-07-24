#include "stdafx.h"
#include "ftp.h"

using namespace Ftp;

CFtp::CFtp()
{
	m_RemoteHost = "127.0.0.1";
	m_UserName = "anonymous";
	m_Password = "anonymous";
	m_Port = 21;
	m_ClientSocket = NULL;
	m_Connected = false;
}

void CFtp::Initialise(String* host, String* user, String* password, int port)
{
	m_RemoteHost = host;
	m_UserName = user;
	m_Password = password;
	m_Port = port;
}

void CFtp::Connect()
{

	m_ClientSocket = new Socket(AddressFamily::InterNetwork, SocketType::Stream, ProtocolType::Tcp );

	IPAddress* ipAddress = Dns::Resolve(m_RemoteHost)->AddressList[0];
	IPEndPoint* endPoint = new IPEndPoint(ipAddress, m_Port);

	try
	{
		m_ClientSocket->Connect(endPoint);
		m_Connected = true;
	}
	catch(SocketException* e)
	{
		m_Connected = false;
		throw new IOException("Connect Failed", e);
	}

	ReadResponse();
}

void CFtp::Disconnect()
{
	if(m_ClientSocket != NULL)
	{
		m_ClientSocket->Shutdown(SocketShutdown::Both);
		m_ClientSocket->Close();
		m_Connected = false;
		OnConnectionEvent(this, new ConnectionEventArgs(false));
	}
}

void CFtp::ReadResponse()
{
	String* reply = ReadLine();
	BroadcastResponse(reply);
}

String* CFtp::ReadLine()
{
	return ReadLine(false);
}

#define BUFFER_SIZE 512
String* CFtp::ReadLine(bool clearResponse)
{
	String* temp = "\n";
	Char endLine[] = temp->ToCharArray();

	String* data = "";
	
	Byte buffer[] = new Byte[BUFFER_SIZE];

	int bytesRead = 0;

	if(clearResponse == true) m_Response->Empty;

	while(true)
	{
		Array::Clear(buffer, 0, BUFFER_SIZE);
		bytesRead = m_ClientSocket->Receive(buffer, buffer->Length, SocketFlags::None);

		ASCIIEncoding* ascii = new ASCIIEncoding();

		data = data->Concat(data, ascii->GetString(buffer, 0, bytesRead));
		if(bytesRead < buffer->Length) break;
	}

	String* parts[] = data->Split(endLine);

	if(parts->Length > 2) m_Response = parts[parts->Length - 2];
	else m_Response = parts[0];

	if(m_Response->Substring(3, 1)->Equals(" ") == false) return ReadLine(false);

	return m_Response;
}

void CFtp::BroadcastResponse(String* reply)
{
	// permit handling as raw data
	OnRawDataReceivedEvent(this, new RawDataReceivedEventArgs(reply));
	
	int code = Int32::Parse(reply->Substring(0,3));
	String* data = reply->Substring(4);

	OnTcpEvent(this, new TcpEventArgs(code, data));

	switch(code)
	{
	case SENDING_DATA_PORT_20:
	case COMMAND_NOT_IMPLEMENTED:
	case CONNECTED:
		OnConnectionEvent(this, new ConnectionEventArgs(true, code, data));
	case AUTHENTICATED:
		OnAuthentication(this, new AuthenticationEventArgs(true, code, data));
	case NEED_PASSWORD:
	case AUTHENTICATION_FAILED:
		OnAuthentication(this, new AuthenticationEventArgs(false, code, data));
	}

}

/*



    Private FRemoteHost As String     = "127.0.0.1"
    Private FRemotePath As String     = "."
    Private FRemoteUser As String     = "anonymous"
    Private FRemotePassword As String = "anonymous@nowhere.com"
    Private FRemotePort As Integer    = 21
    Private clientSocket As Socket    = Nothing
    Private response As String

    Public Event OnAuthentication As AuthenticationEvent
    Public Event OnConnectionEvent As ConnectionEvent
    Public Event OnRawDataReceivedEvent As RawDataReceivedEvent
    Public Event OnTcpEvent As TcpEvent

    Public Sub New()
    End Sub

    Public Sub New(ByVal remoteHost As String, _
                   ByVal remotePath As String, _
    ByVal remoteUser As String, ByVal remotePassword As String, _
                                ByVal remotePort As Integer)
        FRemoteHost     = remoteHost
        FRemotePath     = remotePath
        FRemoteUser     = remoteUser
        FRemotePassword = remotePassword
        FRemotePort     = remotePort
    End Sub


    Public Sub Connect()
        clientSocket = New Socket(AddressFamily.InterNetwork, _
                                  SocketType.Stream, ProtocolType.Tcp)
        Dim endpoint As IPEndPoint = _
            New IPEndPoint(Dns.Resolve(FRemoteHost).AddressList(0), _
            FRemotePort)

        Try
            clientSocket.Connect(endpoint)
        Catch ex As Exception
            Throw New IOException("Connect failed", ex)
        End Try

        ReadResponse()
    End Sub

    Public Sub Disconnect()
        If (clientSocket Is Nothing = False) Then
            clientSocket.Disconnect(True)
            RaiseEvent OnConnectionEvent(Me, _
                New ConnectionEventArgs(False))
        End If
    End Sub

    Private Sub ReadResponse()
        Dim reply As String = ReadLine()
        'Figure out the response and raise that event
        BroadcastResponse(reply)
    End Sub

    Private Function ReadLine() As String
        Return ReadLine(False)
    End Function

    Private Function ReadLine(ByVal clearResponse As Boolean) _
            As String
        Const EndLine As Char = "\n"
        Const BUFFER_SIZE As Integer = 512

        Dim data As String = ""
        Dim buffer(BUFFER_SIZE) As Byte
        Dim bytesRead As Integer = 0

        If (clearResponse = True) Then response = String.Empty

        While (True)
            Array.Clear(buffer, 0, BUFFER_SIZE)
            bytesRead = clientSocket.Receive(buffer, buffer.Length, 0)
            data += ASCII.GetString(buffer, 0, bytesRead)

            If (bytesRead < buffer.Length) Then Exit While
        End While

        Dim parts() As String = data.Split(EndLine)

        If (parts.Length > 2) Then
            response = parts(parts.Length - 2)
        Else
            response = parts(0)
        End If

        If (response.Substring(3, 1).Equals(" ") = False) Then
            Return ReadLine(False)
        End If

        Return response

    End Function

    Private Sub BroadcastResponse(ByVal reply As String)

        ' Permit handling as raw  data
        RaiseEvent OnRawDataReceivedEvent(Me, _
            New RawDataReceivedEventArgs(reply))

        Dim code As Integer = Int32.Parse(reply.Substring(0, 3))
        Dim data As String = reply.Substring(4)

        ' Permit special handling as code and data
        RaiseEvent OnTcpEvent(Me, New TcpEventArgs(code, data))


        ' Specific handling based on code
        Select Case code
            Case SENDING_DATA_PORT_20
            Case COMMAND_NOT_IMPLEMENTED
            Case CONNECTED
                RaiseEvent OnConnectionEvent(Me, _
                    New ConnectionEventArgs(True, code, data))
            Case AUTHENTICATED
                RaiseEvent OnAuthentication(Me, New _
                    AuthenticationEventArgs(True, code, data))
            Case NEED_PASSWORD

            Case AUTHENTICATION_FAILED
                RaiseEvent OnAuthentication(Me, _
                    New AuthenticationEventArgs(False, code, data))
        End Select

    End Sub

    Public Sub Login()
        SendCommand("USER " + FRemoteUser)
        SendCommand("PASS " + FRemotePassword)
    End Sub

    Public Sub Login(ByVal user As String, ByVal password As String)
        FRemotePassword = password
        FRemoteUser = user
        Login()
    End Sub


    Private Sub SendCommand(ByVal command As String)
        command += Environment.NewLine
        Dim commandBytes() As Byte = ASCII.GetBytes(command)
        clientSocket.Send(commandBytes, commandBytes.Length, 0)
        ReadResponse()
    End Sub

End Class


Public Class TcpEventArgs
    Private FCode As Integer
    Private FData As String

    Public Sub New(ByVal code As Integer, ByVal data As String)
        FCode = code
        FData = data
    End Sub

    Public ReadOnly Property Code() As Integer
        Get
            Return FCode
        End Get
    End Property

    Public ReadOnly Property Data() As String
        Get
            Return FData
        End Get
    End Property
End Class

Public Class ConnectionEventArgs
    Inherits TcpEventArgs

    Private FConnected As Boolean = False

    Public Sub New(ByVal connected As Boolean)
        MyBase.New(-1, "")
        FConnected = connected
    End Sub

    Public Sub New(ByVal connected As Boolean, _
                   ByVal code As Integer, ByVal data As String)
        MyBase.New(code, data)
        FConnected = connected
    End Sub

    Public ReadOnly Property Connected() As Boolean
        Get
            Return FConnected
        End Get
    End Property
End Class

Public Class AuthenticationEventArgs
    Inherits TcpEventArgs

    Private FAuthenticated As Boolean = False

    Public Sub New(ByVal authenticated As Boolean)
        MyBase.New(-1, "")
        FAuthenticated = authenticated
    End Sub

    Public Sub New(ByVal authenticated As Boolean, _
                   ByVal code As Integer, ByVal data As String)
        MyBase.New(code, data)
        FAuthenticated = authenticated
    End Sub

    Public ReadOnly Property Authenticated() As Boolean
        Get
            Return FAuthenticated
        End Get
    End Property
End Class

Public Class RawDataReceivedEventArgs
    Inherits TcpEventArgs

    Private FRawData As String
    Public Sub New(ByVal rawData As String)
        MyBase.New(-1, "")
        FRawData = rawData
    End Sub

    Public Sub New(ByVal rawData As String, _
                   ByVal code As Integer, ByVal data As String)
        MyBase.New(code, data)
        FRawData = rawData
    End Sub

    Public ReadOnly Property RawData() As String
        Get
            Return FRawData
        End Get
    End Property
End Class

Public Delegate Sub AuthenticationEvent(ByVal sender As Object, _
       ByVal e As AuthenticationEventArgs)
Public Delegate Sub ConnectionEvent(ByVal sender As Object, _
       ByVal e As ConnectionEventArgs)
Public Delegate Sub RawDataReceivedEvent(ByVal sender As Object, _
       ByVal e As RawDataReceivedEventArgs)
Public Delegate Sub TcpEvent(ByVal sender As Object, _
       ByVal e As TcpEventArgs)
*/