package pureMVC.controller
{
    import flash.display.Stage;
    
    import org.puremvc.as3.interfaces.ICommand;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;
    
    import pureMVC.ApplicationFacade;
    import pureMVC.model.WelcomScreenDataProxy;
    import pureMVC.view.StageMediator;
    

    public class StartupCommand extends SimpleCommand implements ICommand
    {
        /**
         * Register the Proxies and Mediators.
         * 
         * Get the View Components for the Mediators from the app,
         * which passed a reference to itself on the notification.
         */
        override public function execute( note:INotification ) : void    
        {
			facade.registerProxy(new WelcomScreenDataProxy());
			
	    	var stage:WheelOfFortune_VMoskov = note.getBody() as WheelOfFortune_VMoskov;
            facade.registerMediator( new StageMediator( stage ) );
			sendNotification( ApplicationFacade.STAGE_ADD_WELCOM );
        }
    }
}