package com.dotcomit.rss
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	[Event(name="newRSS", type="flash.events.Event")]
	
	public class RSSDelegateAS implements IRSSDelegate
	{
	public function RSSDelegateAS()
	{

	}

	[Bindable] public var title : String = '';
	[Bindable] public var description : String = '';
		
	public function update():void{

		try{
			var file:File = File.documentsDirectory.resolvePath("app:/test.rss");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			var prefsXML:XML = XML(fileStream.readUTFBytes(fileStream.bytesAvailable));
			fileStream.close();
			
			var data: Object = new Object();
			data.result = prefsXML;
			processResult(data);

		}
		catch(err:Error){
			processFault(err);
		}

	}
	
	public function processResult(event:Object):void{
		var results : XML = event.result as XML;
		title  = results.channel.item[0].title.toString();
		description  = results.channel.item[0].description.toString();
		this.dispatchEvent(new Event('newRSS'));
	}
	
	public function processFault(e:Error):void{
		Alert.show('Did not retrieve RSS Feed');
	}

	}
}