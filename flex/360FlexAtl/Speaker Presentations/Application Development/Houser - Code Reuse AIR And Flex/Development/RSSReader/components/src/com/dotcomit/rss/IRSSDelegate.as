package com.dotcomit.rss
{
	[Bindable] 
	public interface IRSSDelegate
	{
		function get title():String	
		function set title(arg:String):void
		function get description():String	
		function set description(arg:String):void
		function update():void
	}
}

