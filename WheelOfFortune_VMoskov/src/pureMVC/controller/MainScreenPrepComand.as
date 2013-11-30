package pureMVC.controller
{
	import flash.display.Stage;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import pureMVC.model.MainScreenDataProxy;
	import pureMVC.view.MainScreenMediator;
	import pureMVC.view.components.MainScreen;

	public class MainScreenPrepComand extends SimpleCommand implements ICommand
	{
		/**
		 * Register the Proxies and Mediators.
		 * 
		 * Get the View Components for the Mediators from the app,
		 * which passed a reference to itself on the notification.
		 */
		override public function execute( note:INotification ) : void    
		{
			var stage:WheelOfFortune_VMoskov = note.getBody() as WheelOfFortune_VMoskov;
			
			var proxy: MainScreenDataProxy = new MainScreenDataProxy();
			facade.registerProxy(proxy);
			
			var mainScreen: MainScreen = new MainScreen();
			facade.registerMediator(new MainScreenMediator(mainScreen));
			stage.addChild( mainScreen );
			proxy.loadUser();
			//proxy.loadSpinTime();
		}
	}
}