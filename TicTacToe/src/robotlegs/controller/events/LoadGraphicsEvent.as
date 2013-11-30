package robotlegs.controller.events
{
	import flash.events.Event;
	
	public class LoadGraphicsEvent extends Event
	{
		public static const LOAD_GRAPHICS:String = 'LOAD_GRAPHICS';
		public static const LOAD_GRAPHICS_SUCCES:String = 'LOAD_GRAPHICS_SUCCES';

		public var graphicsXML: XML;
		
		public function LoadGraphicsEvent(type:String, graphicsXML: XML = null)
		{
			super(type, bubbles, cancelable);
			this.graphicsXML = graphicsXML
		}
		
		override public function clone():Event
		{
			return new LoadGraphicsEvent(type, graphicsXML);
		}
	}
}