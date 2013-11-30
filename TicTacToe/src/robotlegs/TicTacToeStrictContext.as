package robotlegs
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	import robotlegs.controller.commands.EndGameCommand;
	import robotlegs.controller.events.EndGameEvent;
	import robotlegs.controller.events.FieldTurnEvent;
	import robotlegs.controller.commands.LoadGameInfoCommand;
	import robotlegs.controller.events.LoadGameInfoEvent;
	import robotlegs.controller.commands.LoadGraphicsCommand;
	import robotlegs.controller.events.LoadGraphicsEvent;
	import robotlegs.controller.events.LoadImageEvent;
	import robotlegs.controller.commands.LoadImagesCommand;
	import robotlegs.controller.commands.StartNewGameCommand;
	import robotlegs.controller.commands.StartUpCommand;
	import robotlegs.controller.commands.UserActionCommand;
	import robotlegs.model.FieldConteiner;
	import robotlegs.model.proxy.ImageLoaderProxy;
	import robotlegs.model.servises.LoadGameServises;
	import robotlegs.model.servises.LoadGraphicsServises;
	import robotlegs.view.EndGameMediator;
	import robotlegs.view.EndGameView;
	import robotlegs.view.FieldMediator;
	import robotlegs.view.FieldView;

	public class TicTacToeStrictContext extends Context
	{
		public function TicTacToeStrictContext(contextView:DisplayObjectContainer)
		{
			super(contextView);
		}
		
		override public function startup ():void
		{
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, StartUpCommand, ContextEvent);
			commandMap.mapEvent(LoadGraphicsEvent.LOAD_GRAPHICS, LoadGraphicsCommand, LoadGraphicsEvent);
			commandMap.mapEvent(LoadImageEvent.LOAD_IMAGE, LoadImagesCommand, LoadImageEvent);
			commandMap.mapEvent(LoadGameInfoEvent.LOAD_GAME_INFO, LoadGameInfoCommand, LoadGameInfoEvent);
			commandMap.mapEvent(FieldTurnEvent.MADE_TURN, UserActionCommand, FieldTurnEvent);
			commandMap.mapEvent(EndGameEvent.END_GAME, EndGameCommand, EndGameEvent);
			commandMap.mapEvent(EndGameEvent.START_NEW_GAME, StartNewGameCommand, EndGameEvent);
			
			injector.mapSingleton(ImageLoaderProxy);
			injector.mapSingleton(FieldConteiner);
			injector.mapSingleton(LoadGraphicsServises);
			injector.mapSingleton(LoadGameServises);
			
			mediatorMap.mapView(FieldView, FieldMediator);
			mediatorMap.mapView(EndGameView, EndGameMediator);
			
			super.startup();
		}
	}
}