package pureMVC.model
{
	import interfaces.IResponder;

	public class LoadTimeResponder implements IResponder
	{
		private var proxy: MainScreenDataProxy;
		
		public function LoadTimeResponder(proxy: MainScreenDataProxy)
		{
			this.proxy = proxy;
			
		}
		public function result( rpcEvent : Object ) : void
		{
			var timeXML: XML = new XML(rpcEvent);
			proxy.loadTimeResult(timeXML);
		}
		
		public function fail( rpcEvent : Object ) : void
		{
			trace(rpcEvent);
		}
	}
}