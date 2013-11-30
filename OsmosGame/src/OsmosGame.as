package
{
	import components.Ball;
	import components.GameField;
	import components.GameInfoPanel;
	
	import controllers.GameController;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	[SWF(width='1000',height='700',backgroundColor='#cccccc',frameRate='25')]
	public class OsmosGame extends Sprite
	{

		private var controller: GameController;
		
		public function OsmosGame()
		{
			init();
			
		}
		
		private function init(): void
		{
			createController();
		}
		
		private function createController(): void
		{
			controller = new GameController(this)
		}
		
		
	}
}