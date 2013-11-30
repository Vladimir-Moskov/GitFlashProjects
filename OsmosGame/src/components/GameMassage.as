package components
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	
	public class GameMassage extends Sprite
	{
		private var mesTF: TextField;
		private var textFormat: TextFormat;
		
		public function GameMassage()
		{
			super();
			
			drawBack(500, 300);
			init();
		}
		
		private function drawBack(width: int, height: int): void
		{
			graphics.lineStyle(5, 0xaaaaaa);
			graphics.beginFill(0xf0000f);
			graphics.drawRoundRect(0, 0, width, height, 10, 10);
			graphics.endFill();
		}
	
		private function init(): void
		{
			mesTF = new TextField();
			textFormat = new TextFormat();
			textFormat.size = 30;
			textFormat.color = 0x00ff00;
			
			mesTF.wordWrap = true;
			mesTF.autoSize = TextFieldAutoSize.LEFT;
			mesTF.border = true;
			mesTF.borderColor = 0x0000ff;
			mesTF.thickness = 3;
			mesTF.x = (width >> 1);
			mesTF.y = (height >> 1);
			addChild(mesTF);
			
		}
		
		public function set messageText(str: String): void
		{
			mesTF.text = str;
			mesTF.setTextFormat( textFormat);
		}
	}
}