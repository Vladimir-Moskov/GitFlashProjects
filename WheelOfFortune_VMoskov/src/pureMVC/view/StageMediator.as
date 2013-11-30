package pureMVC.view
{
    import flash.display.Stage;
    
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;
    
    import pureMVC.ApplicationFacade;
    import pureMVC.model.WelcomScreenDataProxy;
    import pureMVC.view.components.WelcomeScreen;

    
    /**
     * A Mediator for interacting with the Stage.
     */
    public class StageMediator extends Mediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = 'StageMediator';

		private var welcomScreenDataProxy:WelcomScreenDataProxy;
        /**
         * Constructor. 
         */
        public function StageMediator( viewComponent:Object ) 
        {
            // pass the viewComponent to the superclass where 
            // it will be stored in the inherited viewComponent property
            super( NAME, viewComponent );
    
			// Retrieve reference to frequently consulted Proxies
			welcomScreenDataProxy = facade.retrieveProxy( WelcomScreenDataProxy.NAME ) as WelcomScreenDataProxy;
			
            // Listen for events from the view component 
            
        }


        /**
         * List all notifications this Mediator is interested in.
         * <P>
         * Automatically called by the framework when the mediator
         * is registered with the view.</P>
         * 
         * @return Array the list of Nofitication names
         */
        override public function listNotificationInterests():Array 
        {
            return [ ApplicationFacade.STAGE_ADD_WELCOM,
				     ApplicationFacade.STAGE_REMOVE_WELCOM
                   ];
        }

        /**
         * Handle all notifications this Mediator is interested in.
         * <P>
         * Called by the framework when a notification is sent that
         * this mediator expressed an interest in when registered
         * (see <code>listNotificationInterests</code>.</P>
         * 
         * @param INotification a notification 
         */
        override public function handleNotification( note:INotification ):void 
        {
            switch ( note.getName() ) {
                
                // Create a new HelloSprite, 
				// Create and register its HelloSpriteMediator
				// and finally add the HelloSprite to the stage
                case ApplicationFacade.STAGE_ADD_WELCOM:
					var welcomeScreen: WelcomeScreen = new WelcomeScreen();
					facade.registerMediator(new WelcomScreenMediator(welcomeScreen));
					stage.addChild( welcomeScreen );
                    break;
				
				case ApplicationFacade.STAGE_REMOVE_WELCOM:
					stage.removeChild( note.getBody() as  WelcomeScreen);
					facade.sendNotification( ApplicationFacade.STAGE_ADD_MAIN, stage);
					break;
            }
        }

                   
        /**
         * Cast the viewComponent to its actual type.
         * 
         * <P>
         * This is a useful idiom for mediators. The
         * PureMVC Mediator class defines a viewComponent
         * property of type Object. </P>
         * 
         * <P>
         * Here, we cast the generic viewComponent to 
         * its actual type in a protected mode. This 
         * retains encapsulation, while allowing the instance
         * (and subclassed instance) access to a 5
         * strongly typed reference with a meaningful
         * name.</P>
         * 
         * @return stage the viewComponent cast to flash.display.Stage
         */
        public function get stage():WheelOfFortune_VMoskov{
            return viewComponent as WheelOfFortune_VMoskov;
        }
		
    }
}