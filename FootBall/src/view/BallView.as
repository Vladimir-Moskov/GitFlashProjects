package view
{
	public class BallView extends GameObject
	{
		static public const DEFAULT_COLOR: uint = 0x0000ff;
		
		public function BallView(color: uint = DEFAULT_COLOR)
		{
			super(color);
		}
		
		override protected function draw(): void
		{
			graphics.beginFill(color);
			graphics.drawCircle(0, 0, 10);
			graphics.endFill();
		}
		
		
	}
}