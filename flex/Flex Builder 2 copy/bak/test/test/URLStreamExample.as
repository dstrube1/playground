// ActionScript file
//from
// http://livedocs.macromedia.com/labs/flashauthoringpreview/flash/net/URLStream.html#includeExamplesSummary
package URLStreamExample {
    import flash.display.Sprite;
    import flash.errors.*;
    import flash.events.*;
    import flash.net.URLRequest;
    import flash.net.URLStream;

    public class URLStreamExample extends Sprite {
        private static const ZLIB_CODE:String = "CWS";
        private var stream:URLStream;

        public function URLStreamExample() {
            stream = new URLStream();
            var request:URLRequest = new URLRequest("URLStreamExample.swf");
            configureListeners(stream);
            try {
                stream.load(request);
            } catch (error:Error) {
                trace("Unable to load requested URL.");
            }
        }

        private function configureListeners(dispatcher:EventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
        }

        private function parseHeader():String {
            var s:String;
            try{
            s=("parseHeader: ");
            s+=("isCompressed: " + isCompressed());
            s+=("; version: " + stream.readByte());
            s+="; ";
            }catch (err:Error){
            	s=err.toString();
            }
            return s;
        }

        private function isCompressed():Boolean {
            return (stream.readUTFBytes(3) == ZLIB_CODE);
        }

        public function completeHandler(event:Event):String {
        	var s:String;
        	try{
            s= ("completeHandler: " + event);
            s+= parseHeader();
            }catch (err:Error){
            	s=err.toString();
            }
            return s;
        }

        public function httpStatusHandler(event:HTTPStatusEvent):String {
            var s:String;
            try{
            s=("httpStatusHandler: " + event);
            }catch (err:Error){
            	s=err.toString();
            }
            return s;
        }

        public function ioErrorHandler(event:IOErrorEvent):String {
            var s:String;
            try{
     	       s=("ioErrorHandler: " + event);
            }catch (err:Error){
            	s=err.toString();
            }
            return s;
        }

		public function openHandler(event:Event):String {
        	var s:String;
        	try{
            s=("openHandler: " + event);
            }catch (err:Error){
            	s=err.toString();
            }
            return s;
        }

        public function progressHandler(event:Event):String {
            var s:String;
            try{
            s=("progressHandler: " + event);
            }catch (err:Error){
            	s=err.toString();
            }
            return s;
        }

        public function securityErrorHandler(event:SecurityErrorEvent):String {
            var s:String;
            try{
            s=("securityErrorHandler: " + event);
            }catch (err:Error){
            	s=err.toString();
            }
            return s;
        }

    }
}