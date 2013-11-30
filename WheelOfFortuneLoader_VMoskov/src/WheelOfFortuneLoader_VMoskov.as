/**
 * 
 */
package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	[SWF(width='800',height='600',backgroundColor='#cccbbb',frameRate='25')]
	public class WheelOfFortuneLoader_VMoskov extends Sprite
	{
		private var contentLoader:Loader; 
		private var url: String = "WheelOfFortune_VMoskov.swf"; 
		private var progressbar: ProgressBar;
		private var loadingTF: TextField;
		
		/**
		 * 
		 * 
		 */		
		public function WheelOfFortuneLoader_VMoskov()
		{
			init()
		}
	
		private function init(): void
		{
			var format:TextFormat = new TextFormat();
			format.size = 30;
			
			loadingTF = new TextField();
			loadingTF.text = "LOADING ...."
			loadingTF.setTextFormat(format);
			loadingTF.x = 150;
			loadingTF.y = 100;	
			loadingTF.width = 300;
			addChild(loadingTF);
			
			progressbar = new ProgressBar();
			progressbar.x = 50;
			progressbar.y = 150;
			progressbar.width = 400;
			progressbar.height = 100;
			progressbar.bar.scaleX = 0;
			addChild(progressbar);
			
			contentLoader = new Loader(); 
			contentLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loading); 
			contentLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, contentLoaded); 
			//just coment it - to chek loading on the local space
			contentLoader.load(new URLRequest(url)); 
			
			//Mock - to chek loading on the local space
			var timer: Timer = new Timer(200);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			//just remove coment - to chek loading on the local space
			//timer.start();
		}
		private function onTimer(evt:TimerEvent):void 
		{
			setBarProgress(progressbar.bar.scaleX + 0.1)
			if(progressbar.bar.scaleX == 1)
				(evt.target as Timer).stop();
		}
		
		/**
		 * Success swf loading
		 */		
		private function contentLoaded(evt:Event):void {
			addChild(contentLoader); 
			removeChild(progressbar);
			removeChild(loadingTF);
		} 
		
		/**
		 * 
		 */		
		private function loading(evt:ProgressEvent):void { 
			var loaded:Number = evt.bytesLoaded / evt.bytesTotal; 
			setBarProgress(loaded); 
		} 
		
		/**
		 * 
		 * 
		 */		
		private function setBarProgress(value:Number) : void{ 
			progressbar.bar.scaleX = value;
		}
	}
}