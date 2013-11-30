package robotlegs.controller.events
{
	import flash.events.Event;
	
	public class LoadGameInfoEvent extends Event
	{
		public static const LOAD_GAME_INFO:String = 'LOAD_GAME_INFO';
		public static const LOAD_GAME_INFO_SUCCES:String = 'LOAD_GAME_INFO_SUCCES';
		
		public var gameAr: Array;
		
		public function LoadGameInfoEvent(type:String, gameAr: Array = null)
		{
			super(type, bubbles, cancelable);
			this.gameAr = gameAr;
		}
		
		override public function clone():Event
		{
			return new LoadGameInfoEvent(type, gameAr);
		}
	}
}