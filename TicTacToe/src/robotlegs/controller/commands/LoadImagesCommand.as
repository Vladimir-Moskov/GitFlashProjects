package robotlegs.controller.commands
{
	import org.robotlegs.mvcs.Command;
	
	import robotlegs.model.proxy.ImageLoaderProxy;
	import robotlegs.controller.events.LoadImageEvent;
	
	public class LoadImagesCommand extends Command
	{
		[Inject]
		public var proxy:ImageLoaderProxy;
		
		[Inject]
		public var event: LoadImageEvent;
		
		override public function execute ():void
		{
			proxy.loadImage(event.imageVO.path);
		}
	}
}