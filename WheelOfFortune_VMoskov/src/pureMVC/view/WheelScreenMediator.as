package pureMVC.view
{
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import pureMVC.ApplicationFacade;
	import pureMVC.model.MainScreenDataProxy;
	import pureMVC.model.WelcomScreenDataProxy;
	import pureMVC.model.WheelScreenDataProxy;
	import pureMVC.view.components.WelcomeScreen;
	import pureMVC.view.components.WheelScreen;
	import pureMVC.view.components.WinScreen;

	public class WheelScreenMediator extends Mediator implements IMediator
	{
		// Cannonical name of the Mediator
		public static const NAME:String = 'WheelScreenMediator';
		
		private var wheelScreenDataProxy: WheelScreenDataProxy;
		private var winScreen: WinScreen;
		
		public function WheelScreenMediator(viewComponent:Object)
		{
			super( NAME, viewComponent );
			
			// Retrieve reference to frequently consulted Proxies
			wheelScreenDataProxy = facade.retrieveProxy( WheelScreenDataProxy.NAME ) as WheelScreenDataProxy;
			
			// Listen for events from the view component 
			wheelScreen.addEventListener( WheelScreen.WHEEL_CLOSE, onWheelClose );
			wheelScreen.addEventListener( WheelScreen.WHEEL_SPIN_START, onSpinStart );
			wheelScreen.addEventListener( WheelScreen.WHEEL_SPIN_STOP, onSpinViewStop );

		}
		override public function listNotificationInterests():Array 
		{
			return [ 
				ApplicationFacade.STAGE_REMOVE_WHEEL,
				ApplicationFacade.INJECT_SPIN_RESULT,
				ApplicationFacade.SPIN_STOP
				
			];
		}
		
		override public function handleNotification( note:INotification ):void 
		{
			switch ( note.getName() ) {
				
				case ApplicationFacade.STAGE_REMOVE_WHEEL:
					wheelScreen.parent.removeChild(wheelScreen);
					sendNotification( ApplicationFacade.LOAD_SPINTIME );
					break;
				case ApplicationFacade.INJECT_SPIN_RESULT:
					onSpinDataResult();
					break;
				case ApplicationFacade.INJECT_SPIN_RESULT:
					onSpinDataResult();
					break;
				case ApplicationFacade.SPIN_STOP:
					onSpinStop();
					break;
			}
		}
		
		private function onSpinDataResult(): void
		{
			wheelScreen.injectSpinResult(wheelScreenDataProxy.winSector);
		}
		
		private function onSpinStop(): void
		{
			if(!winScreen)
			{
				winScreen = new WinScreen();
				winScreen.addEventListener(WinScreen.COLLECT_COINS, onCollectCoins);
			}
			viewComponent.addChild( winScreen );
			winScreen.injectData(wheelScreenDataProxy.winCoins);
		}
		
		private function onCollectCoins(event: Event): void
		{
			(viewComponent as WheelScreen).removeChild(winScreen);
			var proxy: MainScreenDataProxy = facade.retrieveProxy( MainScreenDataProxy.NAME ) as MainScreenDataProxy;
			proxy.collectCoins(wheelScreenDataProxy.winCoins);
			
			var mediator: MainScreenMediator = facade.retrieveMediator( MainScreenMediator.NAME ) as MainScreenMediator;
			mediator.sendNotification(ApplicationFacade.INJECT_USER_INFO);
			
			sendNotification(ApplicationFacade.STAGE_REMOVE_WHEEL);
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
		protected function get wheelScreen(): WheelScreen
		{
			return viewComponent as WheelScreen;
		}
		private function onWheelClose(event: Event): void
		{
			sendNotification(ApplicationFacade.STAGE_REMOVE_WHEEL);
		}
		
		private function onSpinStart(event: Event): void
		{
			wheelScreenDataProxy.loadSpinData();
		}
		private function onSpinViewStop(event: Event): void
		{
			sendNotification(ApplicationFacade.SPIN_STOP);
		}
	}
}