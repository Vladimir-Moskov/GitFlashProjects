package pureMVC.model
{
	import interfaces.IResponder;
	
	import org.puremvc.as3.patterns.facade.Facade;
	
	import pureMVC.ApplicationFacade;
	import pureMVC.view.WheelScreenMediator;

	public class LoadSpinDataResponder implements IResponder
	{
		public var winSector: int;
		private var proxy: WheelScreenDataProxy;
		
		public function LoadSpinDataResponder(proxy: WheelScreenDataProxy)
		{
			this.proxy = proxy;
		}
		
		public function result( rpcEvent : Object ) : void
		{
			proxy.loadSpinDataResult(rpcEvent);
		}
		
		public function fail( rpcEvent : Object ) : void
		{
			trace(rpcEvent);
		}
	}
}