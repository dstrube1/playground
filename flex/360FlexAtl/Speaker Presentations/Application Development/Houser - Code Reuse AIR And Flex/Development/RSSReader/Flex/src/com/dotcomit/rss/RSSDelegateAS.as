package com.dotcomit.rss
{
	import flash.events.Event;
	
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	
	[Event(name="newRSS", type="flash.events.Event")]
	
	public class RSSDelegateAS 
		extends HTTPService 
		implements IRSSDelegate
	{
		public function RSSDelegateAS(rootURL:String=null, 
				destination:String=null)
		{
			super(rootURL, destination);
			this.url = 'http://local.codereuse.com:8080/test.rss';
			this.resultFormat = 'e4x';
			this.method = 'GET';
			this.addEventListener(ResultEvent.RESULT,processResult);
			this.addEventListener(FaultEvent.FAULT,processFault);

		}

		[Bindable] public var title : String = '';
		[Bindable] public var description : String = '';
			
		public function update():void{
			this.send();
		}
		
		public function processResult(event:ResultEvent):void{
			var results : XML = event.result as XML;
			title  = results.channel.item[0].title.toString();
			description  = results.channel.item[0].description.toString();
			this.dispatchEvent(new Event('newRSS'));
		}
		
		public function processFault(event:FaultEvent):void{
			Alert.show('Did not retrieve RSS Feed');
		}

	}
}