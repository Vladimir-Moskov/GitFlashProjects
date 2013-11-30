package pureMVC.model.business
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import interfaces.IResponder;

	public class BaseLoadDelegat
	{
		static public const URL_SPIN_BEFORE: String = "assets/servises/SpinBefore.xml";
		static public const URL_SPIN_ROTATION: String = "assets/servises/SpinRotation.xml";
		static public const URL_TIME_TO_SPIN: String = "assets/servises/TimeToNextSpin.xml";
		static public const URL_USER: String = "assets/servises/User.xml";
		
		protected var service : URLRequest;
		protected var loader : URLLoader;
		protected var responder : IResponder;
		
		public function BaseLoadDelegat(responder : IResponder)
		{
			// constructor will store a reference to the service we're going to call
			
			this.responder = responder;
			// and store a reference to the proxy that created this delegate
		}
		
		public function loadService(url: String) : void 
		{
			if(!loader)
			{
				loader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, completeHandler);
				loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			}
			if(!service)
			{
				service = new URLRequest();
				service.url = url;
			}
			loader.load(service);
		}
		
		public function completeHandler(event: Event): void
		{
			responder.result(event.target.data)
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