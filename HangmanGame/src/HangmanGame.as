package
{
	import flash.display.Sprite;
	
	import main.MainView;
	
	[SWF(width='310',height='450',backgroundColor='#ffffff',frameRate='25')]
	public class HangmanGame extends Sprite
	{
		public function HangmanGame()
		{
			init();
		}
		
		private function init(): void
		{
			addChild(new MainView());
		}
		
		
	}
}