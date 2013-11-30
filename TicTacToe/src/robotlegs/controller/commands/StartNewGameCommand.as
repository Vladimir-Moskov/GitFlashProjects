package robotlegs.controller.commands
{
	import org.robotlegs.mvcs.Command;
	
	import robotlegs.controller.events.EndGameEvent;
	import robotlegs.model.FieldConteiner;
	import robotlegs.model.servises.LoadGameServises;
	
	public class StartNewGameCommand extends Command
	{
		[Inject]
		public var service:LoadGameServises;
		
		[Inject]
		public var model: FieldConteiner;
		
		override public function execute ():void
		{
			model.fieldArray = null;
			service.clear();
			dispatch(new EndGameEvent(EndGameEvent.CLEAR_FIELD));

		}
	}
}