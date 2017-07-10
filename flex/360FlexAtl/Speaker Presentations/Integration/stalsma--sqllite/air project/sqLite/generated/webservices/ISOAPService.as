
/**
 * Service.as
 * This file was auto-generated from WSDL by the Apache Axis2 generator modified by Adobe
 * Any change made to this file will be overwritten when the code is re-generated.
 */
package generated.webservices{
	import mx.rpc.AsyncToken;
	import flash.utils.ByteArray;
	import mx.rpc.soap.types.*;
               
    public interface ISOAPService
    {
    	//Stub functions for the getUsers operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @return An AsyncToken
    	 */
    	function getUsers():AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function getUsers_send():AsyncToken;
        
        /**
         * The getUsers operation lastResult property
         */
        function get getUsers_lastResult():ArrayOf_xsd_anyType;
		/**
		 * @private
		 */
        function set getUsers_lastResult(lastResult:ArrayOf_xsd_anyType):void;
       /**
        * Add a listener for the getUsers operation successful result event
        * @param The listener function
        */
       function addgetUsersEventListener(listener:Function):void;
       
       
        /**
         * Get access to the underlying web service that the stub uses to communicate with the server
         * @return The base service that the facade implements
         */
        function getWebService():BaseSOAPService;
	}
}