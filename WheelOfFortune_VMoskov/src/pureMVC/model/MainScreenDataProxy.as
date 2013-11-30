package pureMVC.model
{
	
	import flash.display.Bitmap;
	
	import interfaces.IResponder;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import pureMVC.ApplicationFacade;
	import pureMVC.model.business.BaseLoadDelegat;
	import pureMVC.model.business.LoadUserAvatarDelegat;
	import pureMVC.model.vo.UserVO;
	import pureMVC.view.MainScreenMediator;

	public class MainScreenDataProxy extends Proxy implements IProxy, IResponder
	{
		public static const NAME:String = 'MainScreenDataProxy';
		public static const SPIN_COST:int = 10;
		
		public var userVO: UserVO;
		public var timeToNextSpin: int;
		private var avatarLoader: LoadAvatarResponder;
		private var timeLoader: LoadTimeResponder;
		
		public function MainScreenDataProxy()
		{
			super(NAME);
			avatarLoader = new LoadAvatarResponder(this);
			timeLoader = new LoadTimeResponder(this);
		}
		public function loadUser():void
		{
			// create a worker who will go get some data
			// pass it a reference to this proxy so the delegate knows where to return the data
			var delegate : BaseLoadDelegat = new BaseLoadDelegat( this );
			// make the delegate do some work
			delegate.loadService(BaseLoadDelegat.URL_USER);
		}
		
		public function loadUserAvatar(userVO: UserVO):void
		{
			// create a worker who will go get some data
			// pass it a reference to this proxy so the delegate knows where to return the data
			var delegate : LoadUserAvatarDelegat = new LoadUserAvatarDelegat( avatarLoader);
			// make the delegate do some work
			delegate.loadAvatarService(  userVO.avatarPath);
		}
		public function loadSpinTime():void
		{
			// create a worker who will go get some data
			// pass it a reference to this proxy so the delegate knows where to return the data
			var delegate : BaseLoadDelegat = new BaseLoadDelegat( timeLoader);
			// make the delegate do some work
			delegate.loadService(BaseLoadDelegat.URL_TIME_TO_SPIN);
		}
		public function result( rpcEvent : Object ) : void
		{
			var userXML: XML = new XML(rpcEvent);
			userVO = new UserVO(userXML.name, userXML.avatar, userXML.coins);
			var mediator: MainScreenMediator = (facade.retrieveMediator( MainScreenMediator.NAME ) as MainScreenMediator);
			mediator.sendNotification(ApplicationFacade.INJECT_USER_INFO);
			if(userVO &&  userVO.avatarPath)
				mediator.sendNotification(ApplicationFacade.LOAD_USER_AVATAR);
		}
		
		public function fail( rpcEvent : Object ) : void
		{
			trace(rpcEvent);
		}
		
		public function get avatar( ) : Bitmap
		{
			return avatarLoader.avatarBm;
		}
		
		public function collectCoins(coins:int): void
		{
			userVO.coins += coins;
		}
		
		public function loadTimeResult(rpcEvent : Object): void
		{
			timeToNextSpin = int(rpcEvent);
			var mediator: MainScreenMediator = (facade.retrieveMediator( MainScreenMediator.NAME ) as MainScreenMediator);
			mediator.sendNotification(ApplicationFacade.INJECT_LOAD_SPINTIME);
		}
		public function takeSpinCost(): void
		{
			userVO.coins -= SPIN_COST;
		}
		
	}
}