package pureMVC.model.business
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import interfaces.IResponder;
	
	import org.puremvc.as3.interfaces.IProxy;
	
	
	public class LoadUserAvatarDelegat 
	{
		private var service : URLRequest;
		private var loader : Loader;
		private var responder : IResponder;
		
		public function LoadUserAvatarDelegat( responder : IResponder) 
		{
			// constructor will store a reference to the service we're going to call
			
			this.responder = responder;
			// and store a reference to the proxy that created this delegate
		}
		
		public function loadAvatarService(avatarPath: String) : void 
		{
			if(!loader)
			{
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
				loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			}
			if(!service)
			{
				service = new URLRequest();
				service.url = avatarPath;
			}
			loader.load(service);
		}
		
		public function completeHandler(event: Event): void
		{
			responder.result(loader.content)
		}
		
		public function securityErrorHandler(event: SecurityErrorEvent): void
		{
			responder.fail(event);
		}
		
		public function ioErrorHandler(event: IOErrorEvent): void
		{
			responder.result(event);
		}
	}
}