package components
{
	import flash.display.Shape;
	
	public class LevelShape extends Shape
	{
		public function LevelShape(x: int, y: int, width: int, height: int)
		{
			this.x = x;
			this.y = y;
			super();
			
			draw(width, height);
		}
		
		private function draw(width: int, height: int): void
		{
			graphics.beginFill(0x00ff00);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill(); 
		}
		
		public function hitTest(ball: Ball): Boolean
		{
			var ball_x0: int = ball.x - ball.radius;
			var ball_x1: int = ball.x + ball.radius;
			var shape_x0: int = this.x;
			var shape_x1: int = this.x + this.width;
			
			if(ball_x1 < shape_x0 || ball_x0 > shape_x1)
				return false;
			
			var ball_y0: int = ball.y - ball.radius;
			var ball_y1: int = ball.y + ball.radius;
			var shape_y0: int = this.y;
			var shape_y1: int = this.y + this.height;
			
			if(ball_y1 < shape_y0 || ball_y0 > shape_y1)
				return false;
			
					
			return hitTestObject(ball);
		}
	}
}