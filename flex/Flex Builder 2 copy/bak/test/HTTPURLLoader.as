// ActionScript file
package //com.abdulqabiz.net
{
 import flash.net.*;
 import flash.events.*;
 import flash.system.Security;
 import flash.errors.EOFError;
 import mx.utils.StringUtil;
 dynamic public class HTTPURLLoader extends EventDispatcher
 {
  [Event(name="close", type="flash.events.Event.CLOSE")]
  [Event(name="complete", type="flash.events.Event.COMPLETE")]
  [Event(name="open", type="flash.events.Event.CONNECT")]
  [Event(name="ioError", type="flash.events.IOErrorEvent.IO_ERROR")]
  [Event(name="securityError", type="flash.events.SecurityErrorEvent.SECURITY_ERROR")]
  [Event(name="progress", type="flash.events.ProgressEvent.PROGRESS")]
  [Event(name="httpStatus", type="flash.events.HTTPStatusEvent.HTTP_STATUS")]
    
  private var _httpPort:uint = 80;
  private var _httpSocket:Socket;
  private var _request:URLRequest;
  public  var _httRequest:String;
  public  var _httpServer:String;
  private var _headersServed:Boolean = false;
  private var _responseHeaders:Object;
  private var _data:String = "";
  private var _bytesLoaded:int = 0;
  private var _bytesTotal:int = 0;
  private var _tmpStr:String = "";
  public function get data():String
  {
   return _data;
  }
  public function get responseHeaders():Object
  {
   return _responseHeaders;
  }  
  
  public function get bytesLoaded():int
  {
   return _bytesLoaded;
  }
  public function HTTPURLLoader(request:URLRequest = null)
  {
   
   //doesn't really need it here, as load(..) requires request
   _request = request; 
     
   // create http-socket
   _httpSocket = new Socket();
   //subscribe to events
   _httpSocket.addEventListener( "connect" , onConnectEvent , false , 0 );    
   _httpSocket.addEventListener( "close" , onCloseEvent , false, 0 );
   _httpSocket.addEventListener( "ioError" , onIOErrorEvent , false, 0 );
   _httpSocket.addEventListener( "securityError" , onSecurityErrorEvent , false, 0 );
   _httpSocket.addEventListener( "socketData" , onSocketDataEvent , false, 0 );
  }
  //## event handlers ##
  private function onConnectEvent(event:Event):void
  { 
  
   sendHeaders();
   dispatchEvent(new Event(Event.CONNECT));
    
  }
   
  private function onCloseEvent(event:Event):void
  {
   dispatchEvent(new Event(flash.events.Event.COMPLETE));
  }
   
  private function onIOErrorEvent(event:IOErrorEvent):void
  { 
   dispatchEvent(event);
  }
  
  private function onSecurityErrorEvent(event:SecurityErrorEvent):void
  {
   dispatchEvent(event.clone());
  }
  
  private function onSocketDataEvent(event:ProgressEvent):void
  {
        
   _bytesLoaded+= _httpSocket.bytesAvailable;
   dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, _bytesLoaded, _bytesTotal))
   trace("HTTPURLLoader::onSocketDataEvent() -> " + _bytesLoaded);
   
   //temporary string variable   
   var str:String = ""
   
   // loop while there are bytes available
   while (_httpSocket.bytesAvailable)
   {
    
    //attempt to read from the socket receive buffer
    try 
    {      
     str = _httpSocket.readUTFBytes(_httpSocket.bytesAvailable);
    
           
    } 
    //watch for EndOfFile Errors!!!
    catch(e:EOFError) 
    {
     break;
    }          
   
   
    
   }
   if(!_headersServed)
   {
    _tmpStr+= str;
   
    //check if headers are over; 
    if(str.indexOf("\r\n\r\n")!=-1)
    {
     _headersServed = true;
       
     //parse header
     var t1:Array =  _tmpStr.split("\r\n\r\n");
     var t2:Array;
     var t3:Array;
     _data+= t1[1];
     
     var t2:Array = t1[0].split("\r\n");
 
     _responseHeaders = {};
     for each(var header:String in t2)
     {
      if(header.indexOf("HTTP/1.")==-1)
      {
       var t3:Array = header.split(":");
       _responseHeaders[t3[0]] = StringUtil.trim(t3[1]); 
      }
     }
     
     if(_responseHeaders["Content-Length"])
     {
      //total bytes = content-length + header size (number of characters in header)
      //not working, need to work on right logic..
      _bytesTotal = int(_responseHeaders["Content-Length"])  +_tmpStr.length;
     }
     
    }
    var isHTTPStatus:Boolean = false;
    if(_tmpStr.indexOf("HTTP/1.1 200")!=-1 || _tmpStr.indexOf("HTTP/1.0 200")!=-1)
    {
     dispatchEvent(new HTTPStatusEvent (HTTPStatusEvent.HTTP_STATUS, false, false, 200));
    }
    else if(_tmpStr.indexOf("HTTP/1.1 304")!=-1 || _tmpStr.indexOf("HTTP/1.0 304")!=-1)
    {
     dispatchEvent(new HTTPStatusEvent (HTTPStatusEvent.HTTP_STATUS, false, false, 304));
    }
    else if(_tmpStr.indexOf("HTTP/1.1 400")!=-1 || _tmpStr.indexOf("HTTP/1.0 400")!=-1)
    {
     dispatchEvent(new HTTPStatusEvent (HTTPStatusEvent.HTTP_STATUS, false, false, 400));
     _httpSocket.close();
     return;  
    }
    else if(_tmpStr.indexOf("HTTP/1.1 401")!=-1 || _tmpStr.indexOf("HTTP/1.0 401")!=-1)
    {
     dispatchEvent(new HTTPStatusEvent (HTTPStatusEvent.HTTP_STATUS, false, false, 401));
     _httpSocket.close();  
     return;
    }
    else if(_tmpStr.indexOf("HTTP/1.1 403")!=-1 || _tmpStr.indexOf("HTTP/1.0 403")!=-1)
    {
     dispatchEvent(new HTTPStatusEvent (HTTPStatusEvent.HTTP_STATUS, false, false, 403));
     _httpSocket.close();
     return;  
    }
    else if(_tmpStr.indexOf("HTTP/1.1 404")!=-1 || _tmpStr.indexOf("HTTP/1.0 404")!=-1)
    {
     dispatchEvent(new HTTPStatusEvent (HTTPStatusEvent.HTTP_STATUS, false, false, 404));
     _httpSocket.close();
     return;  
    }
    else if(_tmpStr.indexOf("HTTP/1.1 410")!=-1 || _tmpStr.indexOf("HTTP/1.0 410")!=-1)
    {
     dispatchEvent(new HTTPStatusEvent (HTTPStatusEvent.HTTP_STATUS, false, false, 410));
    }
    else if(_tmpStr.indexOf("HTTP/1.1 500")!=-1 || _tmpStr.indexOf("HTTP/1.0 500")!=-1)
    {
     dispatchEvent(new HTTPStatusEvent (HTTPStatusEvent.HTTP_STATUS, false, false, 500));
     _httpSocket.close();
     return;  
    }
    else if(_tmpStr.indexOf("HTTP/1.1 501")!=-1 || _tmpStr.indexOf("HTTP/1.0 501")!=-1)
    {
     dispatchEvent(new HTTPStatusEvent (HTTPStatusEvent.HTTP_STATUS, false, false, 501));
     _httpSocket.close();
     return;  
    }
    } else {   
     _data+= str;
    }
  }  
  
  private function sendHeaders()
  {
   var requestHeaders:Array = _request.requestHeaders;
   var h:String = "";
 
   _responseHeaders = null;
   _bytesLoaded = 0;
   _bytesTotal = 0;
   _data = "";
   _headersServed = false;
   _tmpStr = "";
   //create an HTTP 1.0 Header Request
   h+= "GET " + _httpRequest + " HTTP/1.0\r\n";
   h+= "Host:" + _httpServer + "\r\n";
   if(requestHeaders.length > 0)
   {
    for each(var rh:URLRequestHeader in requestHeaders)
    {
     h+= rh.name + ":" + rh.value + "\r\n";
    }
   }
   
   //set HTTP headers to socket buffer
   _httpSocket.writeUTFBytes(h + "\r\n\r\n")
   //push the data to server
   _httpSocket.flush()   
  }
  private function parseURL():Boolean
  {
    
   //parse URL into sockServer and sockRequest
   
   var d:Array = _request.url.split('http://')[1].split('/');
   if(d.length > 0)
   {
    _httpServer = d.shift();
    //load crossdomain, if its on server.
    Security.loadPolicyFile("http://"+_httpServer+"/crossdomain.xml");
    _httpRequest = '/' + d.join('/');
    return true;
   }
   return false;
  }
 
  public function load(request:URLRequest):void
  {
   _request = request;
   if(parseURL())
   {
    _httpSocket.connect(_httpServer, _httpPort);
    
   }
   else
   {
    throw new Error("Invalid URL");
   }        
    
  }
  
  public function close():void
  {
   if(_httpSocket.connected)
   {
    _httpSocket.close();
    dispatchEvent(new Event(Event.CLOSE));
   }
  }
 }
}

