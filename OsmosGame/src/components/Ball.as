package components
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.net.dns.AAAARecord;
	
	public class Ball extends Shape
	{
		static public const USER_ID: int = 1;
		static public const AI_ID: int = 0;
		
		//pixels per frame
		static public const DEFAULT_SPEED: int = 2;
		static public const MAX_SPEED: int = 4;
		static public const MAX_CLICK: int = 1000;
		static public const MIN_CLICK: int = 100;
		
		public var id: int;
		private var _radius: Number;
		private var color: uint;
		public var squear: Number;
		
		private var _speed: Number = DEFAULT_SPEED;
	
		private var _direction: Number;//angel of ball move
		private var _curXDelta: Number;
		private var _curYDelta: Number;
		
		private var removeDelta: Number = 0;//pixels per frame
		private var _eatRadius: Number = 0;

		
		public function Ball(radius: Number, color: uint, id: int = AI_ID)
		{
			super();
			
			this.radius = radius;
			this.id = id;
			this.color = color;
			
			init();
		}
		
		private function init(): void
		{
			draw();
		}
		
		private function draw(): void
		{
			graphics.clear();
			graphics.beginFill(color);
			graphics.drawCircle(0, 0, _radius);
			graphics.endFill();
		}
		
		public function set radius(newRadius: Number): void
		{
			_radius = newRadius;
			squear = Math.PI * newRadius * newRadius;
		}
		public function get radius(): Number
		{
			return _radius;
		}
		public function set direction(direction: Number): void
		{
			if(_direction != direction)
			{
				_direction = direction;
				_curXDelta = _speed * Math.cos(direction * Math.PI/180);
				_curYDelta = _speed * Math.sin(direction * Math.PI/180) * (-1);
				//trace("new direction = " + _direction);
			}
			
		}
		
		public function get direction(): Number
		{
			return _direction;
		}
		
		public function get speed(): Number
		{
			return _speed;
		}
		
		public function set speed(speed: Number): void
		{
			if(_speed != speed)
			{	
				_speed = speed;
				_curXDelta = _speed * Math.cos(direction * Math.PI/180);
				_curYDelta = _speed * Math.sin(direction * Math.PI/180) * (-1);
			}
		}
		
		

		public function onEnterFrame(): void
		{
			checkBorder();
			checkLevelShape();
			
			if(_eatRadius > _speed)
			{
				radius += _speed;
				_eatRadius -= _speed;
				draw();
			}
			else if(_eatRadius > 0)
			{
				radius += _eatRadius;
				_eatRadius = 0;
				draw();
			}
			
			x += _curXDelta;
			y += _curYDelta;
			
			//if(id == USER_ID)
			//	trace("speed = " + _speed);
		}

		private function checkBorder(): void
		{
			var tempDirec: Number = direction;
			if((x - _radius) < 0)
			{
				tempDirec = 180 - tempDirec;
				tempDirec = tempDirec > 0 ? tempDirec : 360 + tempDirec;
				x += 2;
			}
			else if((x + _radius) >= 1050)
			{
				tempDirec = 180 - tempDirec;
				tempDirec = tempDirec > 0 ? tempDirec : 360 + tempDirec;
				x -= 2;
			}
			else if((y - _radius) < 0)
			{
				tempDirec = 360 - tempDirec;
				y += 2;
			}
			else if((y + _radius) >= 900)
			{
				tempDirec = 360 - tempDirec;
				y -= 2;
			}
			direction = tempDirec;
		}
		private function checkLevelShape(): void
		{
			var tempDirec: Number = direction;
			
			direction = tempDirec;
		}
		
		public function eatBall(ball: Ball): void
		{
			var s1: Number = squear;
			var s2: Number = ball.squear;
			var s0: Number = s1 + s2;
			
			_eatRadius = Math.sqrt(s0/Math.PI) - radius;
			ball.remove();
		}
		
		public function remove():void
		{
			removeDelta = (DEFAULT_SPEED<<2);
			addEventListener(Event.ENTER_FRAME, onRemove, false, 0, true); 
		}
		private function onRemove(event: Event):void
		{
			if (width > removeDelta)
			{
				width -= removeDelta;
				height -= removeDelta;
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, onRemove); 
				parent.removeChild(this);
			}
		}
		
		
		public function changeColor(newColor: uint): void
		{
			color = newColor;
			draw();
		}
		
		static public function ballsHit(bal1: Ball, bal2: Ball): Ball 
		{
			if(bal1.radius > bal2.radius)
			{
				bal1.eatBall(bal2);
				return bal2;
			}
			else
			{
				bal2.eatBall(bal1);
				return bal1;
			}
				
		}
			
	}
}