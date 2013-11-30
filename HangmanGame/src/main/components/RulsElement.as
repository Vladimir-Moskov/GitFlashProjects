package main.components
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class RulsElement extends Sprite
	{
		public static const RULES_TEXT: String = "As the game starts choose one letter of the alphabet. Your goal is to guess the word.\n"+
													"With each incorrect letter an element of the gallows appears. When the gallows are complete - you lose.\n"+
													"If you guess the letter, that latter will be opened.";
		
		private var ruleTextField: TextField;
		private var textFormat: TextFormat;
		
		public function RulsElement()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			drawBackGround();
			createText();
		}
		
		private function drawBackGround():void
		{
			graphics.lineStyle(3, 0xffffff); 
			graphics.beginFill(0xffffff, 0.5);
			graphics.drawRoundRect(0, 0, 280, 210, 8, 8);
			graphics.endFill();
		}
		
		private function createText():void{
			textFormat = new TextFormat();
			textFormat.size = 20;
			textFormat.leading = -1;
			
			ruleTextField = new TextField();
			ruleTextField.wordWrap = true;
			ruleTextField.multiline = true;
			ruleTextField.autoSize = TextFieldAutoSize.LEFT;
			ruleTextField.text = RULES_TEXT;
			ruleTextField.width = 260;
			ruleTextField.height = 190;
			ruleTextField.setTextFormat( textFormat);
			
			ruleTextField.x = 10;
			ruleTextField.y = 5;
			
			addChild(ruleTextField);
		}
	}
}