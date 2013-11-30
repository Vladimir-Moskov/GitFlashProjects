package pureMVC.view
{
    import flash.display.Stage;
    import flash.events.Event;
    import flash.geom.Rectangle;
    
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;
    
    import pureMVC.ApplicationFacade;
    import pureMVC.model.WelcomScreenDataProxy;
    import pureMVC.view.components.WelcomeScreen;
   
    /**
     * A Mediator for interacting with the HelloSprite.
     */
    public class WelcomScreenMediator extends Mediator implements IMediator
    {
		private var welcomeScreenDataProxy: WelcomScreenDataProxy;

	   /**
         * Constructor. 
         */
        public function WelcomScreenMediator( viewComponent:Object ) 
        {
            // pass the viewComponent to the superclass where 
            // it will be stored in the inherited viewComponent property
            //
            // *** Note that the name of the mediator is the same as the
            // *** id of the HelloSprite it stewards. It does not use a
            // *** fixed 'NAME' constant as most single-use mediators do
            super( WelcomeScreen(viewComponent).name, viewComponent );
    
			// Retrieve reference to frequently consulted Proxies
			welcomeScreenDataProxy = facade.retrieveProxy( WelcomScreenDataProxy.NAME ) as WelcomScreenDataProxy;

			// Listen for events from the view component 
			welcomeScreen.addEventListener( WelcomeScreen.PLAY_START, onPlayStartHandler );
            
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
            return [ 
            		 ApplicationFacade.PLAY_START
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
                
                case ApplicationFacade.PLAY_START:
					(facade.retrieveMediator(StageMediator.NAME) as StageMediator).sendNotification(ApplicationFacade.STAGE_REMOVE_WELCOM, welcomeScreen);
					break;
            }
        }
		
		/**
		 * Sprite divide.
		 * <P>
		 * User is dragging the sprite, send a notification to create a new sprite
		 * and pass the state the new sprite should inherit.
		 */
		private function onPlayStartHandler(event:Event):void
		{
			sendNotification( ApplicationFacade.PLAY_START, welcomeScreen );
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
         * (and subclassed instance) access to a 
         * strongly typed reference with a meaningful
         * name.</P>
         * 
         * @return stage the viewComponent cast to HelloSprite
         */
        protected function get welcomeScreen():WelcomeScreen
        {
            return viewComponent as WelcomeScreen;
        }

    }
}