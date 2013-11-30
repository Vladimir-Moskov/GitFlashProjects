package pureMVC.model
{
	import interfaces.IResponder;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import pureMVC.ApplicationFacade;
	import pureMVC.model.business.BaseLoadDelegat;
	import pureMVC.model.vo.PreSpinVO;
	import pureMVC.view.WheelScreenMediator;

	public class WheelScreenDataProxy extends Proxy implements IProxy, IResponder
	{
		public static const NAME:String = 'WheelScreenProxy';
		
		private var preSpinVO: PreSpinVO;
		public var winSector: int;
		
		public function WheelScreenDataProxy()
		{
			super(NAME);
		}
		
		public function loadPreSpinData(): void
		{
			// create a worker who will go get some data
			// pass it a reference to this proxy so the delegate knows where to return the data
			var delegate : BaseLoadDelegat = new BaseLoadDelegat( this );
			// make the delegate do some work
			delegate.loadService(BaseLoadDelegat.URL_SPIN_BEFORE);
		}
		public function loadSpinData(): void
		{
			// create a worker who will go get some data
			// pass it a reference to this proxy so the delegate knows where to return the data
			var delegate : BaseLoadDelegat = new BaseLoadDelegat( new LoadSpinDataResponder(this) );
			// make the delegate do some work
			delegate.loadService(BaseLoadDelegat.URL_SPIN_ROTATION);
		}
		
		public function loadSpinDataResult(rpcEvent : Object): void
		{
			var spinsXML: XML = new XML(rpcEvent as String);
			var len: int =  (spinsXML.win as XMLList).length();
			var index: int = int(Math.random() * (len - 1));
			var spin: XML = spinsXML.win[index];
			winSector = int(spin);
			//var mediator: WheelScreenMediator = (facade.retrieveMediator( WheelScreenMediator.NAME ) as WheelScreenMediator);
			//mediator.sendNotification(ApplicationFacade.INJECT_SPIN_RESULT);
			
			sendNotification(ApplicationFacade.INJECT_SPIN_RESULT, winSector);
		}
		
		public function result( rpcEvent : Object ) : void
		{
			var spinsXML: XML = new XML(rpcEvent as String);
			var len: int =  (spinsXML.spin as XMLList).length();
			var index: int = int(Math.random() * (len - 1))
			var spin: XML = spinsXML.spin[index];
			
			preSpinVO = new PreSpinVO(spin.@coins, spin.@probability);
		}
		
		public function fail( rpcEvent : Object ) : void
		{
			trace("fail  " + rpcEvent);
		}
		
		public function get winCoins(): Number{
			return preSpinVO.coins*preSpinVO.probability;
		}
		
	}
}