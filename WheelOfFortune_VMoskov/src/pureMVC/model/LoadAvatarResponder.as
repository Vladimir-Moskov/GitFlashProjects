package pureMVC.model
{
	import flash.display.Bitmap;
	
	import interfaces.IResponder;
	
	import pureMVC.ApplicationFacade;

	public class LoadAvatarResponder implements IResponder
	{
		public var avatarBm:Bitmap;
		private var proxy: MainScreenDataProxy;
		
		public function LoadAvatarResponder(proxy: MainScreenDataProxy)
		{
			this.proxy = proxy
		}
		
		public function result( rpcEvent : Object ) : void
		{
			avatarBm = rpcEvent as Bitmap;
			proxy.sendNotification(ApplicationFacade.INJECT_USER_AVATAR);
		}
		
		public function fail( rpcEvent : Object ) : void
		{
			trace(rpcEvent);
		}
	}
}