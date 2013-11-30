package main.components
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class StatisticElement extends TextField
	{
		public static const WIN_TEXT: String = "Win: ";
		public static const LOST_TEXT: String = "Lost: ";
		
		private var win: int = 0;
		private var lost: int = 0;
		
		private var customTextFormat: TextFormat;

		
		public function StatisticElement()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			customTextFormat = new TextFormat();
			customTextFormat.size = 20;
			customTextFormat.color = 0xffffff;
			customTextFormat.bold = true;
			
			autoSize = TextFieldAutoSize.LEFT;
			
			rewriteText()
		}
		
		private function rewriteText():void
		{
			var newText = WIN_TEXT + win.toString() + " " + 
						  LOST_TEXT + lost.toString();
			
			text = newText;
			setTextFormat(customTextFormat);
			
		}
		
		public function set winNum(newNum: int): void
		{
			win = newNum;
			rewriteText();
		}
		public function set lostNum(newNum: int): void
		{
			lost = newNum;
			rewriteText();
		}
		
		
		
	}
}