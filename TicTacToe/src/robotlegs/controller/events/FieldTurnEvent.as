package robotlegs.controller.events
{
	import flash.events.Event;
	
	import robotlegs.model.TurnVO;
	
	public class FieldTurnEvent extends Event
	{
		public static const MADE_TURN:String = 'MADE_TURN';
		public static const SHOW_TURN:String = 'SHOW_TURN';
		
		public var turn: TurnVO;
		
		public function FieldTurnEvent(type:String,  turn: TurnVO)
		{
			super(type, bubbles, cancelable);
			this.turn = turn;
		}
		
		override public function clone():Event
		{
			return new FieldTurnEvent(type, turn);
		}
	}
}