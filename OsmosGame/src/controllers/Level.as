package controllers
{
	import components.Ball;
	import components.GameField;
	import components.LevelShape;
	
	import flash.geom.Rectangle;

	public class Level
	{
		protected  var recVec: Vector.<LevelShape>;
		protected var _gameField: GameField;
		
		public function Level(gameField : GameField)
		{
			_gameField = gameField;
			
			init();
		}
		
		private function init(): void
		{
			//drawRectangls();
		}
		/*
		protected function drawRectangls(): void
		{
			if(!levelRectangels || levelRectangels.length < 1 )
				return;
		}
		*/
		protected function hitTest(ball: Ball): Boolean
		{
			return rectanglsHitTest(ball);
		}
		
		protected function rectanglsHitTest(ball: Ball): Boolean
		{
			for each(var item:LevelShape in recVec)
			{
				if(item.hitTest(ball))
					return false;
			}
			return true;
		}
		
		public function setLevelXML(levelXml: XML): void
		{
			trace(levelXml);
		}
	}
}