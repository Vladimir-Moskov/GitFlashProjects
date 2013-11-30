package pureMVC.view.components
{
	import fl.controls.Button;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.sensors.Accelerometer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class WinScreen extends Sprite
	{
		static public const COLLECT_COINS: String = "collectCoins";
		
		private var collectBt: Button;
		private var titleTF: TextField;
		private var coinsTF: TextField;
		private var format:TextFormat;
		
		public function WinScreen()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			graphics.beginFill(0xcccccc);
			graphics.drawRect(0, 0, 800, 600);
			graphics.endFill();
			
			format = new TextFormat();
			format.size = 25;
			
			titleTF = new TextField();
			titleTF.text = "Great!";
			titleTF.setTextFormat(format);
			titleTF.y = 50;
			titleTF.x = 50;
			addChild(titleTF);
			
			coinsTF = new TextField();
			coinsTF.text = "";
			coinsTF.y = 150;
			coinsTF.x = 50;
			addChild(coinsTF);
			
			collectBt = new Button();
			collectBt.label = "Collect";
			collectBt.setStyle("textFormat", format);
			collectBt.setSize(200, 75);
			collectBt.y = 250;
			collectBt.x = 50;
			addChild(collectBt);
			
			collectBt.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
		}
		
		private function onButtonClick(event: Event): void
		{
			dispatchEvent(new Event(COLLECT_COINS));
		}
		public function injectData(coins: int): void
		{
			coinsTF.text = String(coins);
			coinsTF.setTextFormat(format);
		}
	}
}