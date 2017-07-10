
/**
 * SOAPServiceService.as
 * This file was auto-generated from WSDL by the Apache Axis2 generator modified by Adobe
 * Any change made to this file will be overwritten when the code is re-generated.
 */
 /**
  * Usage example: to use this service from within your Flex application you have two choices:
  * Use it via Actionscript only
  * Use it via MXML tags
  * Actionscript sample code:
  * Step 1: create an instance of the service; pass it the LCDS destination string if any
  * var myService:SOAPService= new SOAPService();
  * Step 2: for the desired operation add a result handler (a function that you have already defined previously)  
  * myService.addgetUsersEventListener(myResultHandlingFunction);
  * Step 3: Call the operation as a method on the service. Pass the right values as arguments:
  * myService.getUsers();
  *
  * MXML sample code:
  * First you need to map the package where the files were generated to a namespace, usually on the <mx:Application> tag, 
  * like this: xmlns:srv="generated.webservices.*"
  * Define the service and within its tags set the request wrapper for the desired operation
  * <srv:SOAPService id="myService">
  *   <srv:getUsers_request_var>
  *		<srv:GetUsers_request />
  *   </srv:getUsers_request_var>
  * </srv:SOAPService>
  * Then call the operation for which you have set the request wrapper value above, like this:
  * <mx:Button id="myButton" label="Call operation" click="myService.getUsers_send()" />
  */
 package generated.webservices{
	import mx.rpc.AsyncToken;
	import flash.events.EventDispatcher;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.events.FaultEvent;
	import flash.utils.ByteArray;
	import mx.rpc.soap.types.*;

    /**
     * Dispatches when a call to the operation getUsers completes with success
     * and returns some data
     * @eventType GetUsersResultEvent
     */
    [Event(name="GetUsers_result", type="GetUsersResultEvent")]
    
	/**
	 * Dispatches when the operation that has been called fails. The fault event is common for all operations
	 * of the WSDL
	 * @eventType mx.rpc.events.FaultEvent
	 */
    [Event(name="fault", type="mx.rpc.events.FaultEvent")]

	public class SOAPService extends EventDispatcher implements ISOAPService
	{
    	private var _baseService:BaseSOAPService;
        
        /**
         * Constructor for the facade; sets the destination and create a baseService instance
         * @param The LCDS destination (if any) associated with the imported WSDL
         */  
        public function SOAPService(destination:String=null,rootURL:String=null)
        {
        	_baseService = new BaseSOAPService(destination,rootURL);
        }
        
		//stub functions for the getUsers operation
          

        /**
         * @see ISOAPService#getUsers()
         */
        public function getUsers():AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.getUsers();
            _internal_token.addEventListener("result",_getUsers_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see ISOAPService#getUsers_send()
		 */    
        public function getUsers_send():AsyncToken
        {
        	return getUsers();
        }
              
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _getUsers_lastResult:ArrayOf_xsd_anyType;
		[Bindable]
		/**
		 * @see ISOAPService#getUsers_lastResult
		 */	  
		public function get getUsers_lastResult():ArrayOf_xsd_anyType
		{
			return _getUsers_lastResult;
		}
		/**
		 * @private
		 */
		public function set getUsers_lastResult(lastResult:ArrayOf_xsd_anyType):void
		{
			_getUsers_lastResult = lastResult;
		}
		
		/**
		 * @see ISOAPService#addgetUsers()
		 */
		public function addgetUsersEventListener(listener:Function):void
		{
			addEventListener(GetUsersResultEvent.GetUsers_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _getUsers_populate_results(event:ResultEvent):void
        {
        var e:GetUsersResultEvent = new GetUsersResultEvent();
		            e.result = event.result as ArrayOf_xsd_anyType;
		                       e.headers = event.headers;
		             getUsers_lastResult = e.result;
		             dispatchEvent(e);
	        		
		}
		
		//service-wide functions
		/**
		 * @see ISOAPService#getWebService()
		 */
		public function getWebService():BaseSOAPService
		{
			return _baseService;
		}
		
		/**
		 * Set the event listener for the fault event which can be triggered by each of the operations defined by the facade
		 */
		public function addSOAPServiceFaultEventListener(listener:Function):void
		{
			addEventListener("fault",listener);
		}
		
		/**
		 * Internal function to re-dispatch the fault event passed on by the base service implementation
		 * @private
		 */
		 
		 private function throwFault(event:FaultEvent):void
		 {
		 	dispatchEvent(event);
		 }
    }
}
