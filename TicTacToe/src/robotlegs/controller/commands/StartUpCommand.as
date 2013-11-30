package robotlegs.controller.commands
{
	import org.robotlegs.mvcs.Command;
	
	import robotlegs.model.servises.LoadGraphicsServises;
	import robotlegs.view.FieldView;
	import robotlegs.controller.events.LoadGraphicsEvent;
	
	public class StartUpCommand extends Command
	{
		
		override public function execute ():void
		{
			contextView.addChild(new FieldView());
			
			dispatch(new LoadGraphicsEvent(LoadGraphicsEvent.LOAD_GRAPHICS));
			
		}
	}
}