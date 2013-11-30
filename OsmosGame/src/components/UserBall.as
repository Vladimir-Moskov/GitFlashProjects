package components
{
	import flash.events.Event;

	public class UserBall extends Ball
	{
		private var _maxSpeed: Number = MAX_SPEED;
		private var _speedDelta: Number = 0;
		private var _directionDelta: Number = 0;
		
		private var braking: Number;
		private var acceleration: Number;
		private var anglSpeed: Number;
		
		private var isChangeDir: Boolean = false;
		
		public function UserBall(radius:Number, color:uint)
		{
			super(radius, color, id);
			id = USER_ID;
		}
		
		override public function onEnterFrame(): void
		{
			if(_speedDelta > 0 )
			{
				speed += acceleration;
				_speedDelta -= acceleration;
			}
			else if(speed > _maxSpeed )
			{
				speed -= braking;
			}
			/*
			if(isChangeDir)
			{
				if(_directionDelta > anglSpeed && anglSpeed > 0 ||
					_directionDelta < anglSpeed && anglSpeed < 0)
				{
					direction += anglSpeed;
					_directionDelta -= anglSpeed;
				}
				else if(_directionDelta < anglSpeed && anglSpeed > 0 ||
					_directionDelta > anglSpeed && anglSpeed < 0) 
				{
					isChangeDir = false;
					direction += _directionDelta;
					_directionDelta = 0;
					anglSpeed = 0;
				}
				if(direction < 0)
					direction += 360;
				if(direction > 360)
					direction -= 360;
			}
			*/
			
			if(isChangeDir)
			{
				var newDir: Number = direction;
				var absAnglSpeed: Number = anglSpeed > 0 ? anglSpeed : -anglSpeed
				
				if(_directionDelta > absAnglSpeed )
				{
					newDir += anglSpeed;
					_directionDelta = anglSpeed > 0 ? _directionDelta - anglSpeed : _directionDelta + anglSpeed;
				}
				else if(_directionDelta > 0)
				{
					newDir = anglSpeed > 0 ? newDir + _directionDelta : newDir - _directionDelta;
					_directionDelta = 0;
					isChangeDir = false;
				}
				
				if(newDir < 0)
					newDir += 360;
				if(newDir > 360)
					newDir -= 360;
				
				direction = newDir;
			}
			super.onEnterFrame();
			
		}
		
		public function chengeDirection(x: Number, y: Number, power: int): void
		{
			if(power < MIN_CLICK)
				power = MIN_CLICK;
			else if(power > MAX_CLICK)
				power = MAX_CLICK;
			
			_speedDelta = MAX_SPEED - speed;
			_speedDelta *= power/MAX_CLICK
			
			acceleration = (_speedDelta * 2/ stage.frameRate ) * (25/radius);
			braking = (_speedDelta / (stage.frameRate * 3)) * (radius  / 25 );
			
			var newDirect: Number = Math.atan2(this.y - y, this.x - x)/ Math.PI * 180
			

			newDirect = newDirect > 0 ? 360 - newDirect : -newDirect;
			_directionDelta = newDirect;
			//trace("old newDirect = " + newDirect);
			//trace("old direction = "+ direction);
			//direction = newDirect;
			
			isChangeDir = true;
			
			//_directionDelta = _directionDelta - direction;
			if(_directionDelta > direction)
			{
				_directionDelta = _directionDelta - direction;
				if(_directionDelta > 180)
				{
					_directionDelta = 360 - _directionDelta;
					anglSpeed = - _directionDelta * speed / (radius * 2);
				}
				else
				{
					anglSpeed = _directionDelta * speed / (radius * 2);
				}
			}
			else
			{
				_directionDelta = direction -_directionDelta;
				if(_directionDelta > 180)
				{
					_directionDelta = 360 - _directionDelta;
					anglSpeed = _directionDelta * speed / (radius * 2);
				}
				else
				{
					anglSpeed = -_directionDelta * speed/ (radius * 2);
				}
			}
			/*
			trace("new newDirect = " + newDirect);
			trace("new direction = " + direction);
			trace("anglSpeed = "+ anglSpeed);
			trace("_directionDelta = " + _directionDelta);
			trace("------------- ");
			*/
		}
		override public function remove():void
		{
			dispatchEvent(new GameEvent(GameEvent.END_GAME_EVENT, false, true));
		}
	}
}