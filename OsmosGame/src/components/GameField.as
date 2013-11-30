package components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	public class GameField extends Sprite
	{
		
		private var clickTime: int;//in miliseconds
		
		private var defaulrBallsNum: int = 0;
		private var defaulrUserRadius: int = 25;
		private var defaulrRadiusVar: int = 5;
		
		private var ballsAr: Array;
		
		private var colorFrom: Array = [0, 0xFF, 0];
		private var colorTo: Array = [0xFF, 0, 0];
		
		private var fullSqear: int = 0;
		private var maxRadius: Number = 0;
		
		//private var level: Level;

		public function GameField( width: int, height: int)
		{
			super();
			
			drawField(width, height);
			init();
		}
		
		private function drawField(width: int, height: int): void
		{
			graphics.lineStyle(5, 0xffffff);
			graphics.beginFill(0xfff000);
			graphics.drawRoundRect(0, 0, width, height, 10, 10);
			graphics.endFill();
			
		}
		
		private function init(): void
		{
			createNewGame();
			addListeners();
		}
		
		private function addListeners(): void
		{
			addEventListener(Event.ENTER_FRAME, onFieldEnterFrame);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		private function removeListeners(): void
		{
			removeEventListener(Event.ENTER_FRAME, onFieldEnterFrame);
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function createNewGame(): void
		{
			generateBalls();
			randomizeBallsPlace();
			updateColors();
		}
		
		private function generateBalls(): void
		{
			ballsAr = [new UserBall(defaulrUserRadius, 0xff0000)];
			
			fullSqear = (ballsAr[0] as UserBall).squear;
			maxRadius = defaulrUserRadius;
			
			var newRadius: Number;
			for (var i: int = 0; i < defaulrBallsNum; i++)
			{
				newRadius = ((Math.random()*2) - 1) * defaulrRadiusVar + defaulrUserRadius;
				maxRadius = newRadius > maxRadius ? newRadius : maxRadius;
				ballsAr.push( new Ball(newRadius, 0x00ff00));
				fullSqear += (ballsAr[i] as Ball).squear;
			}
		}
		
		private function randomizeBallsPlace(): void
		{
			var xCell: int = (int(width / maxRadius)>>1);
			var yCell: int = (int(height / maxRadius)>>1);
			var len: int = xCell * yCell
			var placeVec: Vector.<Object> = new Vector.<Object>(len, true);
			
			for(var i: int = 0; i < len; i++)
			{
				placeVec[i] = {x: (i % (xCell)), y: int(i / xCell)};
			}
			
			var nextCell: int; 
			var cell: Object;
			
			for each(var ball: Ball in ballsAr)
			{
				if(len > 0)
				{
					nextCell = Math.random() * len;
					cell = (placeVec[nextCell])
				}
				else
				{
					cell = {x: (Math.random() * (xCell - 1)), y: (Math.random() * (yCell - 1))};
				}
			
				ball.x = ((cell.x * maxRadius)<<1) + maxRadius;
				ball.y = ((cell.y * maxRadius)<<1) + maxRadius;
				ball.direction = 270//Math.random()*360;
				
				len--;
				placeVec.splice(nextCell, 1);
				
				addChild(ball);
			}
		}
		
		private function updateColors(): void
		{
			var userBall: UserBall = ballsAr[0] as UserBall;
			var radius: Number = userBall.radius;
			
			for(var i: int = 1;  i < ballsAr.length; i++)
			{
				var ball: Ball = ballsAr[i];
				var _r: uint;
				var _g: uint;
				var _b: uint;
				var d: Number = ball.radius/radius;
				_r = colorFrom[0] > colorTo[0] ? (colorFrom[0] - colorTo[0]) : (colorTo[0] - colorFrom[0]);
				_g = colorFrom[1] > colorTo[1] ? (colorFrom[1] - colorTo[1]) : (colorTo[1] - colorFrom[1]);
				_b = colorFrom[2] > colorTo[2] ? (colorFrom[2] - colorTo[2]) : (colorTo[2] - colorFrom[2]);
				
				_r = colorFrom[0] > colorTo[0] ? (_r / 2) / d : (_r / 2) * d;
				_g = colorFrom[1] > colorTo[1] ? (_g / 2) / d : (_g / 2) * d;
				_b = colorFrom[2] > colorTo[2] ? (_b / 2) / d : (_b / 2) * d;
				
				var colObj: Object = {r: _r, g: _g, b: _b};
				ball.changeColor(RGBToHex(colObj));
			}
			
		}
		
		private function onFieldEnterFrame(event: Event = null): void
		{
			var ball: Ball;
			var ball_1: Ball;
			
			for(var k: int = 0;  k < ballsAr.length; k++)
			{
				ball = ballsAr[k];
				ball.onEnterFrame();
			}
			
			for(var i: int = 0;  i < ballsAr.length; i++)
			{
				ball = ballsAr[i];
				for(var j: int = i + 1;  j < ballsAr.length; j++)
				{
					ball_1 = ballsAr[j];
					if(hitBallTest(ball, ball_1))
					{
						var halfSquear: int = (fullSqear>>1);
						
						var maxball: Ball = ball.radius < ball_1.radius ? ball_1 : ball;
						var minball: Ball = Ball.ballsHit(ball, ball_1);
						
						if(minball.id == Ball.USER_ID)
						{
							dispatchEvent(new GameEvent(GameEvent.END_GAME_EVENT, true));
							return;
						}
							
						if(ball.radius > ball_1.radius)
						{
							ballsAr.splice(j,1);
						}
						else
						{
							ballsAr.splice(i,1);
						}
						
						if(maxball.squear > halfSquear)
						{
							if(maxball.id == Ball.USER_ID)
							{
								dispatchEvent(new GameEvent(GameEvent.WIN_GAME_EVENT));
							}
							else
							{
								dispatchEvent(new GameEvent(GameEvent.END_GAME_EVENT, true))
							}
							return;	
						}
						//TODO - optimization
						onFieldEnterFrame();
						updateColors();
						return;
					}
				}
			}
		}
	
		private function hitBallTest(ball1: Ball, ball2: Ball): Boolean
		{
			var ball1_x0: int = ball1.x - ball1.radius;
			var ball1_x1: int = ball1.x + ball1.radius;
			var ball2_x0: int = ball2.x - ball2.radius;
			var ball2_x1: int = ball2.x + ball2.radius;
			
			if(ball1_x1 < ball2_x0 || ball1_x0 > ball2_x1)
				return false;
			
			var ball1_y0: int = ball1.y - ball1.radius;
			var ball1_y1: int = ball1.y + ball1.radius;
			var ball2_y0: int = ball2.y - ball2.radius;
			var ball2_y1: int = ball2.y + ball2.radius;
			
			if(ball1_y1 < ball2_y0 || ball1_y0 > ball2_y1)
				return false;
			
			var distance: Number = (ball1.x - ball2.x)*(ball1.x - ball2.x) + (ball1.y - ball2.y)*(ball1.y - ball2.y);
			distance = Math.sqrt(distance);
			
			return distance < ball1.radius + ball2.radius;
		}
		
		private function onMouseDown(event: MouseEvent): void
		{
			clickTime = getTimer();
		}
		
		private function onMouseUp(event: MouseEvent): void
		{
			clickTime = getTimer() - clickTime;
			(ballsAr[0] as UserBall).chengeDirection(event.localX, event.localY, clickTime);
		}
	
		
		private function onEndGame(event: Event): void
		{
			var endTF: TextField = new TextField();
			var textFormat: TextFormat = new TextFormat();
			textFormat.size = 30;
			
			endTF.text = "You are loose";
			endTF.setTextFormat( textFormat);
			endTF.autoSize = TextFieldAutoSize.LEFT;
			endTF.border = true;
			endTF.borderColor = 0x0000ff;
			endTF.thickness = 3;
			endTF.x = 200;
			endTF.y = 200;
			addChild(endTF);
		}
		
		public function onStartGame(): void
		{
			removeChildren();
			createNewGame();
		}
		
		public function pause(paused: Boolean): void
		{
			if(!paused)
				addListeners();
			else
				removeListeners();
		}
		
		public static function HexToRGB(value:uint):Object{
			var rgb:Object = new Object();
			rgb.r = (value >> 16) & 0xFF
			rgb.g = (value >> 8 ) & 0xFF
			rgb.b = value & 0xFF
			return rgb;
		}
		public static function RGBToHex(value:Object):uint{
			var hex:uint = 0;
			hex += (value.r << 16);
			hex += (value.g << 8 );
			hex += value.b;
			return hex;
		}
	}
}