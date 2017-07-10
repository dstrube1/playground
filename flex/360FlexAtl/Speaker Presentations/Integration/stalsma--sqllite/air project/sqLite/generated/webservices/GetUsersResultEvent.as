/**
 * GetUsersResultEvent.as
 * This file was auto-generated from WSDL
 * Any change made to this file will be overwritten when the code is re-generated.
*/
package generated.webservices
{
    import mx.utils.ObjectProxy;
    import flash.events.Event;
    import flash.utils.ByteArray;
    import mx.rpc.soap.types.*;
    /**
     * Typed event handler for the result of the operation
     */
    
    public class GetUsersResultEvent extends Event
    {
        /**
         * The event type value
         */
        public static var GetUsers_RESULT:String="GetUsers_result";
        /**
         * Constructor for the new event type
         */
        public function GetUsersResultEvent()
        {
            super(GetUsers_RESULT,false,false);
        }
        
        private var _headers:Object;
        private var _result:ArrayOf_xsd_anyType;
         public function get result():ArrayOf_xsd_anyType
        {
            return _result;
        }
        
        public function set result(value:ArrayOf_xsd_anyType):void
        {
            _result = value;
        }

        public function get headers():Object
	    {
            return _headers;
	    }
			
	    public function set headers(value:Object):void
	    {
            _headers = value;
	    }
    }
}