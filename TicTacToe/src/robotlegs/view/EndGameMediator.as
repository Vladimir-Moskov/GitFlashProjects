package robotlegs.view
{
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import robotlegs.controller.events.EndGameEvent;
	import robotlegs.model.FieldConteiner;
	
	public class EndGameMediator extends Mediator
	{
		[Inject]
		public var view: EndGameView;
		
		public function EndGameMediator()
		{
			super();
		}
		override public function onRegister ():void
		{
			addViewListener(MouseEvent.CLICK, onClick);
			eventMap.mapListener(eventDispatcher, EndGameEvent.END_GAME_MESSEGE, endGame);
		}
		
		protected function onClick (event: MouseEvent):void 
		{
			contextView.removeChild(view);
			dispatch(new EndGameEvent(EndGameEvent.START_NEW_GAME));
		}
		
		protected function endGame (event: EndGameEvent):void 
		{
			if(event.userId == FieldConteiner.EMPTY_ID)
				view.setMessage("There is no winner");
			else if(event.userId == FieldConteiner.USER_ID)
				view.setMessage("You are WIN!!!");
			else
				view.setMessage("You are Lose!!!");
		}
	
	}
}