package main.components
{
	import flash.events.Event;
	
	public class GameEvent extends Event
	{
		public static const KEY_PRESS_EVENT: String = "KEY_PRESS_EVENT";
		
		public var data: String;
		
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, data: String = null)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
		public override function clone ():Event {
			return new GameEvent(type, bubbles, cancelable, data);
		}
	}
}