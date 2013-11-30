package pureMVC.view
{
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import pureMVC.ApplicationFacade;
	import pureMVC.model.MainScreenDataProxy;
	import pureMVC.model.WheelScreenDataProxy;
	import pureMVC.model.vo.UserVO;
	import pureMVC.view.components.MainScreen;
	import pureMVC.view.components.WheelScreen;

	public class MainScreenMediator extends Mediator implements IMediator
	{
		// Cannonical name of the Mediator
		public static const NAME:String = 'MainScreenMediator';
		
		private var mainScreenDataProxy: MainScreenDataProxy;
		private var wheelScreen: WheelScreen;
		
		public function MainScreenMediator(viewComponent:Object)
		{
			super( NAME, viewComponent );
			
			// Retrieve reference to frequently consulted Proxies
			mainScreenDataProxy = facade.retrieveProxy( MainScreenDataProxy.NAME ) as MainScreenDataProxy;
			
			// Listen for events from the view component 
			mainScreen.addEventListener( MainScreen.SPIN_START, onSpinStart );
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
				ApplicationFacade.LOAD_USER_INFO,
				ApplicationFacade.INJECT_USER_INFO,
				ApplicationFacade.LOAD_USER_AVATAR,
				ApplicationFacade.INJECT_USER_AVATAR,
				ApplicationFacade.SPIN_START,
				ApplicationFacade.LOAD_SPINTIME,
				ApplicationFacade.INJECT_LOAD_SPINTIME
			];
		}
		
		override public function handleNotification( note:INotification ):void 
		{
			switch ( note.getName() ) {
				
				case ApplicationFacade.LOAD_USER_INFO:
					mainScreenDataProxy.loadUser();
					break;
				case ApplicationFacade.LOAD_SPINTIME:
					mainScreenDataProxy.loadSpinTime();
					break;
				case ApplicationFacade.INJECT_LOAD_SPINTIME:
					mainScreen.injectSpinTime(mainScreenDataProxy.timeToNextSpin);
					break;
				case ApplicationFacade.INJECT_USER_INFO:
					mainScreen.injectUser(mainScreenDataProxy.userVO);
					break;
				case ApplicationFacade.LOAD_USER_AVATAR:
					mainScreenDataProxy.loadUserAvatar(mainScreenDataProxy.userVO);
					break;
				case ApplicationFacade.INJECT_USER_AVATAR:
					mainScreen.injectAvatar(mainScreenDataProxy.avatar);
					break;
				case ApplicationFacade.SPIN_START:
					sendNotification( ApplicationFacade.STAGE_ADD_WHEEL, mainScreen );
					createWheelScreen();
					mainScreenDataProxy.takeSpinCost();
					break;
			}
		}
		private function createWheelScreen(): void
		{
			var proxy: WheelScreenDataProxy;
			if(!wheelScreen)
			{
				proxy = new WheelScreenDataProxy();
				facade.registerProxy(proxy);
				
				wheelScreen = new WheelScreen();
				facade.registerMediator(new WheelScreenMediator(wheelScreen));
				mainScreen.addChild( wheelScreen );
				proxy.loadPreSpinData();
			}
			else
			{
				mainScreen.addChild( wheelScreen );
				proxy = facade.retrieveProxy(WheelScreenDataProxy.NAME) as WheelScreenDataProxy;
				proxy.loadPreSpinData();
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
		 * (and subclassed instance) access to a 
		 * strongly typed reference with a meaningful
		 * name.</P>
		 * 
		 * @return stage the viewComponent cast to HelloSprite
		 */
		protected function get mainScreen(): MainScreen
		{
			return viewComponent as MainScreen;
		}
		
		private function onLoadUserInfo(event: Event): void
		{
			sendNotification(ApplicationFacade.LOAD_USER_INFO);
		}
		private function onSpinStart(event: Event): void
		{
			sendNotification(ApplicationFacade.SPIN_START);
		}
	}
		

}