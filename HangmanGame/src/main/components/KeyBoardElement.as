package main.components
{
	import fl.controls.Button;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	
	import main.MainView;
	
	public class KeyBoardElement extends Sprite
	{
		public function KeyBoardElement()
		{
			super();
			init();
		}
		
		private function init():void
		{
			drawButtons();
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function drawButtons():void{
			var textFormat:TextFormat = new TextFormat(); 
			textFormat.bold = true; 
			textFormat.size = 15;
			
			var tempBt: Button;
			for(var i:int = 0; i< 26; i ++){
				tempBt = new Button();
				tempBt.label = String.fromCharCode(65 + i);
				tempBt.width = 25;
				tempBt.height = 23;
				tempBt.setStyle("textFormat", textFormat);
				tempBt.x = (i % 8) * (tempBt.width + 2);
				tempBt.y = (i>>3) *( tempBt.height +2);
				addChild(tempBt);
			}
		}
		
		public function set enable(value: Boolean): void{
			for(var i:int = 0; i< numChildren; i ++){
				(getChildAt(i) as Button).enabled = value
			}
		}
		
		private function onMouseClick(event: MouseEvent): void{
			if(event.target is Button){
				MainView.cliskSoundInstanse.play();
				dispatchEvent(new GameEvent(GameEvent.KEY_PRESS_EVENT, false, false, (event.target as Button).label));
			}
		}
		
	}
}