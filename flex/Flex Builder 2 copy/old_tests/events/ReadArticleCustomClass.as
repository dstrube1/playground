package events
{
	import flash.events.Event;

	public class ReadArticleCustomClass extends Event
	{
		public var article:Object;
      
		public function ReadArticleCustomClass(articleParam:Object,type:String)
		{
		super(type,true);
		this.article = articleParam;
		}
		override public function clone():Event
		{
		return new ReadArticleCustomClass(article,type);
		}
	}
}