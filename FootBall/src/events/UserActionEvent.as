package events
{
	import flash.events.Event;
	
	public class UserActionEvent extends Event
	{
		static public const USER_ACTION: String = "userAction";
		
		public var x: Number;
		public var y: Number;
		
		public function UserActionEvent(type:String, x: Number, y: Number)
		{
			super(type, bubbles, cancelable);
			
			this.x = x;
			this.y = y;
		}
		
		override public function clone(): Event
		{
			return new UserActionEvent(type, x, y);
		}
	}
}