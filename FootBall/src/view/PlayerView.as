package view
{
	public class PlayerView extends GameObject
	{
		static public const DEFAULT_COLOR: uint = 0xff0000;
		static public const DEFAULT_MY_COLOR: uint = 0xff00ff;
		
		public function PlayerView(color: uint = DEFAULT_COLOR)
		{
			super(color);
		}
		
		override protected function draw(): void
		{
			graphics.beginFill(color);
			graphics.drawCircle(0, 0, 20);
			graphics.endFill();
		}
	}
}