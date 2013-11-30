package robotlegs.controller.commands
{
	import org.robotlegs.mvcs.Command;
	
	import robotlegs.model.FieldConteiner;
	import robotlegs.model.servises.LoadGameServises;
	import robotlegs.controller.events.FieldTurnEvent;
	
	public class UserActionCommand extends Command
	{
		[Inject]
		public var service:LoadGameServises;
		
		[Inject]
		public var event: FieldTurnEvent;
		
		[Inject]
		public var model: FieldConteiner;
		
		override public function execute ():void
		{
			model.makeTurn(event.turn);
			service.saveGameInfo(model.fieldArray);
		}
	}
}