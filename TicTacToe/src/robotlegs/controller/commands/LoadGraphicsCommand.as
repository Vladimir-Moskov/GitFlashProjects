package robotlegs.controller.commands
{
	import org.robotlegs.mvcs.Command;
	
	import robotlegs.model.proxy.ImageLoaderProxy;
	import robotlegs.model.servises.LoadGraphicsServises;
	
	public class LoadGraphicsCommand extends Command
	{
		[Inject]
		public var service:LoadGraphicsServises;
		
		override public function execute ():void
		{
			service.requestLoadGraphics();
		}
	}
}