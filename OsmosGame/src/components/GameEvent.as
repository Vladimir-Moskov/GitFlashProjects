package components
{
	import flash.events.Event;
	
	public class GameEvent extends Event
	{
		static public const END_GAME_EVENT: String = "END_GAME_EVENT";
		static public const WIN_GAME_EVENT: String = "WIN_GAME_EVENT";
		static public const PAUSE_GAME_EVENT: String = "PAUSE_GAME_EVENT";
		static public const RESTART_GAME_EVENT: String = "RESTART_GAME_EVENT";
		
		static public const LEVEL_1_EVENT: String = "LEVEL_1_EVENT";
		
		public var pause: Boolean;
		
		public function GameEvent(type:String, pause: Boolean = false, bubling: Boolean = false)
		{
			super(type, bubling, false);
			
			this.pause = pause;
		}
	}
}