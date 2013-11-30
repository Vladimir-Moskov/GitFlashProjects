package robotlegs.controller.events
{
	import flash.events.Event;
	
	public class EndGameEvent extends Event
	{
		public static const END_GAME:String = 'END_GAME';
		public static const END_GAME_MESSEGE:String = 'END_GAME_MESSEGE';
		public static const START_NEW_GAME:String = 'START_NEW_GAME';
		public static const CLEAR_FIELD:String = 'CLEAR_FIELD';
		
		public var  userId: int;
		
		public function EndGameEvent(type:String, userId: int = 0)
		{
			super(type, bubbles, cancelable);
			this.userId = userId;
		}
		override public function clone():Event
		{
			return new EndGameEvent(type, userId);
		}
	}
}