package robotlegs.view
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class EndGameView extends Sprite
	{
		private var endGameTF: TextField;
		private var startGameTF: TextField;
		
		private var textFormat: TextFormat;
		public function EndGameView()
		{
			super();
			init();
		}
	
		private function init(): void
		{
			graphics.beginFill(0xffff00);
			graphics.drawRect(0, 0, 600, 400);
			graphics.endFill();
			
			textFormat = new TextFormat();
			textFormat.size = 30;
			
			endGameTF = new TextField
			endGameTF.text = "";
			endGameTF.setTextFormat( textFormat);
			endGameTF.autoSize = TextFieldAutoSize.LEFT;
			endGameTF.x = 300;
			endGameTF.y = 200;
			addChild(endGameTF);
			
			startGameTF = new TextField
			startGameTF.text = "Click to start new game...";
			startGameTF.setTextFormat( textFormat);
			startGameTF.autoSize = TextFieldAutoSize.LEFT;
			startGameTF.x = 300;
			startGameTF.y = 300;
			addChild(startGameTF);
		}
		
		public function setMessage (str: String):void 
		{
			endGameTF.text = str;
			endGameTF.setTextFormat( textFormat);
		}
		
	}
}