package robotlegs.model.servises
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.mvcs.Actor;
	
	import robotlegs.controller.events.LoadGraphicsEvent;

	public class LoadGraphicsServises extends Actor
	{
		static private const URL_GRAPHICS: String = "./assets/servers/graphicsServise.xml"
		
		protected var service : URLRequest;
		protected var loader : URLLoader;
		
		public function LoadGraphicsServises()
		{
			super();
		}
		
		public function requestLoadGraphics(url: String = URL_GRAPHICS): void
		{
			if(!loader)
			{
				loader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
				loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true);
				loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			}
			if(!service)
			{
				service = new URLRequest();
				service.url = url;
			}
			loader.load(service);
		}
		
		private function completeHandler(event: Event): void
		{
			trace(event.target.data)
			dispatch(new LoadGraphicsEvent(LoadGraphicsEvent.LOAD_GRAPHICS_SUCCES, new XML(event.target.data)));
		}
		
		private function securityErrorHandler(event: SecurityErrorEvent): void
		{
			//responder.fail(event);
		}
		
		private function ioErrorHandler(event: IOErrorEvent): void
		{
			//responder.result(event);
		}
		private function removeListeners(): void
		{
			loader.removeEventListener(Event.COMPLETE, completeHandler);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);

		}
	}
}