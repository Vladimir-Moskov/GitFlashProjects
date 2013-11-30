package components
{
	import fl.controls.Button;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class GameInfoPanel extends Sprite
	{
		private var statusPanel: Stats;
		private var pauseBt: Button;
		private var restartBt: Button;
		
		private var levelBt_1: Button;
		
		private var _isPaused: Boolean = false;

		public function GameInfoPanel(width: int, height: int)
		{
			super();
			
			drawPanel(width, height);
			init();
		}
		
		private function drawPanel(width: int, height: int): void
		{
			graphics.lineStyle(5, 0xffffff);
			graphics.beginFill(0x000fff);
			graphics.drawRoundRect(0, 0, width, height, 10, 10);
			graphics.endFill();
		}
		
		private function init(): void
		{
			addComponents()
		}
		
		private function addComponents(): void
		{
			var status: Stats = new Stats();
			status.x = 10;
			status.y = 10;
			addChild(status);
			
			pauseBt = new Button();
			pauseBt.x = 25;
			pauseBt.y = 150;
			pauseBt.label = "Pause";
			pauseBt.addEventListener(MouseEvent.CLICK, onPauseClick, false, 0, true);
			addChild(pauseBt);
			
			restartBt = new Button();
			restartBt.x = 25;
			restartBt.y = 200;
			restartBt.label = "Restart";
			restartBt.addEventListener(MouseEvent.CLICK, onRestart, false, 0, true);
			addChild(restartBt);
			
			levelBt_1 = new Button();
			levelBt_1.x = 25;
			levelBt_1.y = 300;
			levelBt_1.label = "Level 1";
			levelBt_1.addEventListener(MouseEvent.CLICK, onLevel1, false, 0, true);
			addChild(levelBt_1);
		}
		
		private function onPauseClick(event: MouseEvent): void
		{
			_isPaused = !_isPaused;
			
			pauseBt.label = _isPaused ? "Resume" : "Pause";
			
			dispatchEvent(new GameEvent(GameEvent.PAUSE_GAME_EVENT, _isPaused));
		}
		
		private function onRestart(event: MouseEvent): void
		{
			dispatchEvent(new GameEvent(GameEvent.RESTART_GAME_EVENT));
		}
		
		private function onLevel1(event: MouseEvent): void
		{
			dispatchEvent(new GameEvent(GameEvent.LEVEL_1_EVENT));
		}
	}
}