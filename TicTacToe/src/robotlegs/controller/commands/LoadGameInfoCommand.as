package robotlegs.controller.commands
{
	import org.robotlegs.mvcs.Command;
	
	import robotlegs.model.servises.LoadGameServises;
	
	public class LoadGameInfoCommand extends Command
	{
		[Inject]
		public var service:LoadGameServises;
		
		override public function execute ():void
		{
			service.loadGameInfo();
		}
	}
}