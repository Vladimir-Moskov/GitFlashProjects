package robotlegs.controller.commands
{
	import org.robotlegs.mvcs.Command;
	
	import robotlegs.view.EndGameView;
	import robotlegs.controller.events.EndGameEvent;
	
	public class EndGameCommand extends Command
	{
		
		[Inject]
		public var event: EndGameEvent;
		
		override public function execute ():void
		{
			contextView.addChild(new EndGameView());
			
			dispatch(new EndGameEvent(EndGameEvent.END_GAME_MESSEGE, event.userId));
			
		}
	}
}