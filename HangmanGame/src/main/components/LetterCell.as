package main.components
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class LetterCell extends Sprite
	{
		private var letter: String = "";
		private var textField:TextField;
		private var textFormat:TextFormat;
		
		public function LetterCell()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			textFormat = new TextFormat(); 
			textFormat.bold = true; 
			textFormat.color = 0xFFFFFF; 
			textFormat.size = 22;
			textFormat.align = "center";
			
			textField = new TextField();
			textField.text = letter; 
			textField.setTextFormat(textFormat);
			textField.x = 0;
			textField.y = 0;
			textField.width = 28;
			textField.visible = false;
			addChild(textField);
			
			drawCell();
		}
		
		private function drawCell():void
		{
			graphics.lineStyle(1, 0xffffff); 
			graphics.beginFill(0xffffff, 0.3);
			graphics.drawRoundRect(0, 0, 25, 32, 2, 2);
			graphics.endFill();
		}
		
		public function setLetter(newLetter: String):void
		{
			letter = newLetter.toUpperCase();
			textField.text = letter; 
			textField.setTextFormat(textFormat);
		}
		public function get letterVisible(): Boolean
		{
			return textField.visible;
		}
		
		public function showLetter():void
		{
			textField.visible = true;
		}
		public function hideLetter():void
		{
			textField.visible = false;
		}
	}
}