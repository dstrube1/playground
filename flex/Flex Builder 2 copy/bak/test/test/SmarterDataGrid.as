package test
{
	import mx.controls.DataGrid; 
	
	public interface class SmarterDataGrid extends DataGrid
	{
		function setRollover(rolloverText:String):void;
		function getRollover():String;
		function getContent():DataGrid;
		function setColumn(header:String, field:String, id:int):void;
		function getHeader():String;
		function getField():String;
	}
}