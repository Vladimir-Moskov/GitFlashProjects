package
{
	import flash.display.Sprite;
	
	import robotlegs.TicTacToeStrictContext;
	
	[SWF(width='800',height='600',backgroundColor='#ff00ff',frameRate='25')]
	public class TicTacToe extends Sprite
	{
		protected var context:TicTacToeStrictContext;
		
		public function TicTacToe()
		{
			this.context = new TicTacToeStrictContext(this);
		}
	}
}