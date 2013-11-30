package robotlegs.model.proxy
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.mvcs.Actor;
	
	import robotlegs.controller.events.LoadImageEvent;
	
	public class ImageLoaderProxy extends Actor
	{
		private var _loader: Loader;
		private var _graphicsXML: XML;
		
		private var current: Bitmap;
		
		private var crossBm: Bitmap;
		private var zeroBm: Bitmap;
		private var field: Bitmap;
		
		public function ImageLoaderProxy()
		{
			super();
		}

		public function loadImage(url: String):void
		{
			var urlRequest:URLRequest = new URLRequest(url);
			 if(!_loader)
			 {
				 _loader = new Loader();
				 _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onXMLContentLoaded);
			 }
			
			_loader.load(urlRequest);
		}
		
		private function onXMLContentLoaded(event:Event):void 
		{
			dispatch(new LoadImageEvent(LoadImageEvent.LOAD_IMAGE_SUCCES, null, _loader.content as Bitmap));
		}
	}
}