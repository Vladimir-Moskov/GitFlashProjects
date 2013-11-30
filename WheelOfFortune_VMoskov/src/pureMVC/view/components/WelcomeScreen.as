package pureMVC.view.components
{
	import fl.controls.Button;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class WelcomeScreen extends Sprite
	{
		static public const PLAY_START: String = "playStart";
		
		private var playBt: Button; 
		public var welcomMessage: String;
		public var playBtText: String;
		
		private var format:TextFormat;
		
		public function WelcomeScreen(id:String ="")
		{
			super();
			init();
		}
		
		private function init(): void
		{
			format = new TextFormat();
			format.size = 25;
			
			playBt = new Button();
			playBt.x = 50;
			playBt.y = 50;
			playBt.label = "Play";
			playBt.width = 200;
			playBt.height = 200;
			playBt.setStyle("textFormat", format);
			playBt.setSize(200, 75);
			playBt.addEventListener(MouseEvent.CLICK, onBtClickHandler, false, 0, true);
			addChild(playBt);
		}
		
		private function onBtClickHandler(event: MouseEvent ): void
		{
			startGame();
		}
		
		private function startGame(): void
		{
			dispatchEvent(new Event(PLAY_START));
		}
	}
}