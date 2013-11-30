package view
{
	import events.UserActionEvent;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import model.FieldModel;
	
	import protobuf.Ball;
	import protobuf.Field;
	import protobuf.Player;
	
	public class FieldView extends Sprite
	{
		
		
		static private const DEFAULT_COLOR: uint = 0x00ff00;
		static private const DEFAULT_WIDTH: int = 700;
		static private const DEFAULT_HEIGHT: int = 500;
		static private const GATE_WIDTH: int = 100;
		static private const GATE_HEIGHT: int = 200;
		
		private var clickPointer: Shape;
		private var playrsDic: Object;
		private var ballView: BallView;
		
		public function FieldView()
		{
			super();
			
			init();
		}
		
		private function init(): void
		{
			drawField();
			
			addListeners();
			
			playrsDic = {};
		}
		
		private function drawField(): void
		{
			//draw field
			graphics.beginFill(DEFAULT_COLOR);
			graphics.lineStyle(2);
			graphics.drawRect(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT);
			graphics.endFill();
			
			//draw lines
			graphics.lineStyle(3, 0xffffff);
			graphics.moveTo(DEFAULT_WIDTH/2, 0);
			graphics.lineTo(DEFAULT_WIDTH/2, DEFAULT_HEIGHT);
			
			//draw centrCircl
			graphics.drawCircle(DEFAULT_WIDTH/2, DEFAULT_HEIGHT/2, 75);
			
			//draw gates
			graphics.moveTo(0, DEFAULT_HEIGHT/2 - GATE_HEIGHT/2);
			graphics.lineTo(GATE_WIDTH, DEFAULT_HEIGHT/2 - GATE_HEIGHT/2);
			graphics.lineTo(GATE_WIDTH, DEFAULT_HEIGHT/2 + GATE_HEIGHT/2);
			graphics.lineTo(0, DEFAULT_HEIGHT/2 + GATE_HEIGHT/2);
			
			graphics.moveTo(DEFAULT_WIDTH, DEFAULT_HEIGHT/2 - GATE_HEIGHT/2);
			graphics.lineTo(DEFAULT_WIDTH - GATE_WIDTH, DEFAULT_HEIGHT/2 - GATE_HEIGHT/2);
			graphics.lineTo(DEFAULT_WIDTH - GATE_WIDTH, DEFAULT_HEIGHT/2 + GATE_HEIGHT/2);
			graphics.lineTo(DEFAULT_WIDTH, DEFAULT_HEIGHT/2 + GATE_HEIGHT/2);
		}
		
		private function addListeners(): void
		{
			this.addEventListener(MouseEvent.CLICK, onMouseClick, false, 0, true);
		}
		
		private function onMouseClick(event: MouseEvent): void
		{
			if(!clickPointer)
			{
				clickPointer = new Shape();
				clickPointer.graphics.beginFill(0xffffff);
				clickPointer.graphics.drawCircle(0, 0, 10);
				clickPointer.graphics.endFill();
				clickPointer.x = event.localX;
				clickPointer.y = event.localY;
				addChild(clickPointer);
				
			}
			else
			{
				clickPointer.x = event.localX;
				clickPointer.y = event.localY;
				clickPointer.width = 20;
				clickPointer.height = 20;
			}
			addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
			
			dispatchEvent(new UserActionEvent(UserActionEvent.USER_ACTION, event.localX, event.localY));
		}
		
		private function onEnterFrame(event: Event): void
		{
			if(clickPointer.width > 0 && clickPointer.height > 0)
			{
				clickPointer.width -= 1;
				clickPointer.height -= 1;
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				
			}
			
		}
		
		public function updateView(field: Field): void
		{
			drawBall(field.ball);
			drawPlayers(field.players);
		}

		public function drawBall(ball: Ball): void
		{
			if(!ballView)
			{
				ballView = new BallView();
				addChild(ballView);
			}
			ballView.updateInfo(ball);
		}
		
		public function drawPlayers(players: Array): void
		{
			for each(var player: Player in players)
			{
				drawPlayer(player);
			}
		}
		
		public function drawPlayer(player: Player): void
		{
			var playerView:PlayerView  = playrsDic[player.id];
			if(!playerView)
			{
				var color: uint = player.id == FieldModel.userID ? PlayerView.DEFAULT_MY_COLOR : PlayerView.DEFAULT_COLOR;
				playerView = new PlayerView(color);
				playrsDic[player.id] = playerView;
				addChild(playerView);
			}
			playerView.updateInfo(player);
		}
	}
}