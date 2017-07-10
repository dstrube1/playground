package service
{
	import mx.rpc.http.HTTPService;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.events.FaultEvent;
	import app.App;

	public class MemoryService extends HTTPService
	{
		private var params:Object = null;
		private var success:Boolean = false;
		private var result:Object = null;
		
		public function MemoryService(parameters:Object=null){
			params=parameters;
		
		}
		
		public function setParameters():void{
			
		}
		
        public function useHttpService(parameters:Object=null):void {

			this.url = App.URL+"xml/memory.do";
			this.useProxy = false;
            this.method = "GET";
            this.addEventListener("result", httpResult);
            this.addEventListener("fault", httpFault);
            /*     keep for debugging:
            if (parameters == null){
            	parameters = {username:"hema", password:"hema"};
            }
            */
            this.send(parameters);
        }
        
		private function httpResult(event:ResultEvent):void {
                result = event.result;
                success=true;
            //Do something with the result.
        }

        private function httpFault(event:FaultEvent):void {
            var faultstring:String = event.fault.faultString;
            success = false;
        }
        
        public function isSuccess():Boolean{
        	return success;
        }
        
        public function getResult():Object{
        	return result;
        }
	}
}