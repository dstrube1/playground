
/**
 * BaseSOAPServiceService.as
 * This file was auto-generated from WSDL by the Apache Axis2 generator modified by Adobe
 * Any change made to this file will be overwritten when the code is re-generated.
 */
package generated.webservices{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import mx.controls.treeClasses.DefaultDataDescriptor;
	import mx.utils.ObjectUtil;
	import mx.utils.ObjectProxy;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.MessageResponder;
	import mx.messaging.messages.SOAPMessage;
	import mx.messaging.messages.ErrorMessage;
   	import mx.messaging.ChannelSet;
	import mx.messaging.channels.DirectHTTPChannel;
	import mx.rpc.*;
	import mx.rpc.events.*;
	import mx.rpc.soap.*;
	import mx.rpc.wsdl.*;
	import mx.rpc.xml.*;
	import mx.rpc.soap.types.*;
	import mx.collections.ArrayCollection;
	
	/**
	 * Base service implementation, extends the AbstractWebService and adds specific functionality for the selected WSDL
	 * It defines the options and properties for each of the WSDL's operations
	 */ 
	public class BaseSOAPService extends AbstractWebService
    {
		private var results:Object;
		private var schemaMgr:SchemaManager;
		private var BaseSOAPServiceService:WSDLService;
		private var BaseSOAPServicePortType:WSDLPortType;
		private var BaseSOAPServiceBinding:WSDLBinding;
		private var BaseSOAPServicePort:WSDLPort;
		private var currentOperation:WSDLOperation;
		private var internal_schema:BaseSOAPServiceSchema;
	
		/**
		 * Constructor for the base service, initializes all of the WSDL's properties
		 * @param [Optional] The LCDS destination (if available) to use to contact the server
		 * @param [Optional] The URL to the WSDL end-point
		 */
		public function BaseSOAPService(destination:String=null, rootURL:String=null)
		{
			super(destination, rootURL);
			if(destination == null)
			{
				//no destination available; must set it to go directly to the target
				this.useProxy = false;
			}
			else
			{
				//specific destination requested; must set proxying to true
				this.useProxy = true;
			}
			
			if(rootURL != null)
			{
				this.endpointURI = rootURL;
			} 
			else 
			{
				this.endpointURI = null;
			}
			internal_schema = new BaseSOAPServiceSchema();
			schemaMgr = new SchemaManager();
			for(var i:int;i<internal_schema.schemas.length;i++)
			{
				internal_schema.schemas[i].targetNamespace=internal_schema.targetNamespaces[i];
				schemaMgr.addSchema(internal_schema.schemas[i]);
			}
BaseSOAPServiceService = new WSDLService("BaseSOAPServiceService");
			BaseSOAPServicePort = new WSDLPort("BaseSOAPServicePort",BaseSOAPServiceService);
        	BaseSOAPServiceBinding = new WSDLBinding("BaseSOAPServiceBinding");
	        BaseSOAPServicePortType = new WSDLPortType("BaseSOAPServicePortType");
       		BaseSOAPServiceBinding.portType = BaseSOAPServicePortType;
       		BaseSOAPServicePort.binding = BaseSOAPServiceBinding;
       		BaseSOAPServiceService.addPort(BaseSOAPServicePort);
       		BaseSOAPServicePort.endpointURI = "http://localhost:8500/sqLite/components/UserService.cfc";
       		if(this.endpointURI == null)
       		{
       			this.endpointURI = BaseSOAPServicePort.endpointURI; 
       		} 
       		
			var requestMessage:WSDLMessage;
	        var responseMessage:WSDLMessage;
//define the WSDLOperation: new WSDLOperation(methodName)
            var getUsers:WSDLOperation = new WSDLOperation("getUsers");
				//input message for the operation
    	        requestMessage = new WSDLMessage("getUsers");
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://components.sqLite";
			requestMessage.encoding.useStyle="encoded";
                
                responseMessage = new WSDLMessage("getUsersResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("","getUsersReturn"),null,new QName("http://components.sqLite","ArrayOf_xsd_anyType")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://components.sqLite";
                responseMessage.encoding.useStyle="encoded";				
				getUsers.inputMessage = requestMessage;
	        getUsers.outputMessage = responseMessage;
            getUsers.schemaManager = this.schemaMgr;
            getUsers.soapAction = "\"\"";
            getUsers.style = "rpc";
            BaseSOAPServiceService.getPort("BaseSOAPServicePort").binding.portType.addOperation(getUsers);
							SchemaTypeRegistry.getInstance().registerCollectionClass(new QName("http://components.sqLite","ArrayOf_xsd_string"),generated.webservices.ArrayOf_xsd_string);
							SchemaTypeRegistry.getInstance().registerCollectionClass(new QName("http://components.sqLite","ArrayOfArrayOf_xsd_anyType"),generated.webservices.ArrayOfArrayOf_xsd_anyType);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://rpc.xml.coldfusion","CFCInvocationException"),generated.webservices.CFCInvocationException);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://xml.apache.org/xml-soap","mapItem"),generated.webservices.MapItem);
							SchemaTypeRegistry.getInstance().registerCollectionClass(new QName("http://components.sqLite","ArrayOf_xsd_anyType"),generated.webservices.ArrayOf_xsd_anyType);}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 
		 * @return Asynchronous token
		 */
		public function getUsers():AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            currentOperation = BaseSOAPServiceService.getPort("BaseSOAPServicePort").binding.portType.getOperation("getUsers");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
        /**
         * Performs the actual call to the remove server
         * It SOAP-encodes the message using the schema and WSDL operation options set above and then calls the server using 
         * an async invoker
         * It also registers internal event handlers for the result / fault cases
         * @private
         */
        private function call(operation:WSDLOperation,args:Object,token:AsyncToken,headers:Array=null):void
        {
	    	var enc:SOAPEncoder = new SOAPEncoder();
	        var soap:Object = new Object;
	        var message:SOAPMessage = new SOAPMessage();
	        enc.wsdlOperation = operation;
	        soap = enc.encodeRequest(args,headers);
	        message.setSOAPAction(operation.soapAction);
	        message.body = soap.toString();
	        message.url=endpointURI;
            var inv:AsyncRequest = new AsyncRequest();
            inv.destination = super.destination;
            //we need this to handle multiple asynchronous calls 
            var wrappedData:Object = new Object();
            wrappedData.operation = currentOperation;
            wrappedData.returnToken = token;
            if(!this.useProxy)
            {
            	var dcs:ChannelSet = new ChannelSet();	
	        	dcs.addChannel(new DirectHTTPChannel("direct_http_channel"));
            	inv.channelSet = dcs;
            }                
            var processRes:AsyncResponder = new AsyncResponder(processResult,faultResult,wrappedData);
            inv.invoke(message,processRes);
		}
        
        /**
         * Internal event handler to process a successful operation call from the server
         * The result is decoded using the schema and operation settings and then the events get passed on to the actual facade that the user employs in the application 
         * @private
         */
		private function processResult(result:Object,wrappedData:Object):void
           {
           		var headers:Object;
           		var token:AsyncToken = wrappedData.returnToken;
                var currentOperation:WSDLOperation = wrappedData.operation;
                var decoder:SOAPDecoder = new SOAPDecoder();
                decoder.resultFormat = "object";
                decoder.headerFormat = "object";
                decoder.ignoreWhitespace = true;
                decoder.makeObjectsBindable=true;
                decoder.wsdlOperation = currentOperation;
                decoder.schemaManager = currentOperation.schemaManager;
                var body:Object = result.message.body;
                var stringResult:String = String(body);
                if(stringResult == null  || stringResult == "")
                	return;
                var soapResult:SOAPResult = decoder.decodeResponse(result.message.body);
                if(soapResult.isFault)
                {
	                var faults:Array = soapResult.result as Array;
	                for each (var soapFault:Fault in faults)
	                {
		                var soapFaultEvent:FaultEvent = FaultEvent.createEvent(soapFault,token,null);
		                token.dispatchEvent(soapFaultEvent);
	                }
                } else {
	                result = soapResult.result;
	                headers = soapResult.headers;
	                var event:ResultEvent = ResultEvent.createEvent(result,token,null);
	                event.headers = headers;
	                token.dispatchEvent(event);
                }
           }
           	/**
           	 * Handles the cases when there are errors calling the operation on the server
           	 * This is not the case for SOAP faults, which is handled by the SOAP decoder in the result handler
           	 * but more critical errors, like network outage or the impossibility to connect to the server
           	 * The fault is dispatched upwards to the facade so that the user can do something meaningful 
           	 * @private
           	 */
			private function faultResult(error:MessageFaultEvent,token:Object):void
			{
				//when there is a network error the token is actually the wrappedData object from above	
				if(!(token is AsyncToken))
					token = token.returnToken;
				token.dispatchEvent(new FaultEvent(FaultEvent.FAULT,true,true,new Fault(error.faultCode,error.faultString,error.faultDetail)));
			}
		}
	}

	import mx.rpc.AsyncToken;
	import mx.rpc.AsyncResponder;
	import mx.rpc.wsdl.WSDLBinding;
                
    /**
     * Internal class to handle multiple operation call scheduling
     * It allows us to pass data about the operation being encoded / decoded to and from the SOAP encoder / decoder units. 
     * @private
     */
    class PendingCall
    {
		public var args:*;
		public var headers:Array;
		public var token:AsyncToken;
		
		public function PendingCall(args:Object, headers:Array=null)
		{
			this.args = args;
			this.headers = headers;
			this.token = new AsyncToken(null);
		}
	}