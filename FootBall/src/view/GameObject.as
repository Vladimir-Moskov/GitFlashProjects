package view
{
	import flash.display.Shape;
	
	
	public class GameObject extends Shape
	{
		public var color: uint;
		
		public function GameObject(color: uint = 0)
		{
			super();
			
			this.color = color;
			draw();
		}
		
		protected function draw(): void{
			
		}
		
		public function updateInfo(obj: Object): void
		{
			this.x = obj.x;
			this.y = obj.y;
		}
	}
}