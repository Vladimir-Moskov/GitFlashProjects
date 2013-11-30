package controllers
{
	import components.GameEvent;
	import components.GameField;
	import components.GameInfoPanel;
	import components.GameMassage;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class GameController
	{
		private const LEVEL_URL: String = "../assets/servises/levels.xml";
		
		private var _mainView: OsmosGame;
		
		private var gameField: GameField;
		private var gameInfoPanel: GameInfoPanel;
		private var gameMes: GameMassage;
		
		private var level: Level;
		private var levelsXML: XML;
		private var currentLevel: int = 0;
		
		private var gameEnd: Boolean = true;
		
		public function GameController(mainView: OsmosGame)
		{
			_mainView = mainView
			init();
		}
		
		private function init(): void
		{
			drawComponents();
			loadLevels();
		}
		
		private function loadLevels(): void
		{
			var loader: URLLoader = new URLLoader();
			var request: URLRequest =  new URLRequest(LEVEL_URL);
			
			loader.addEventListener(Event.COMPLETE, onLevelSucces, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onLevelFault, false, 0, true);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onLevelFault, false, 0, true);
			
			loader.load(request);

		}
		
		private function onLevelSucces(event : Event): void
		{
			levelsXML =  new XML(event.target.data);
			nextLevel();
		}
		
		private function onLevelFault(event : Event): void
		{
			trace(event);
		}
		
		private function drawComponents(): void
		{
			gameField = new GameField(_mainView.stage.stageWidth - 150, _mainView.stage.stageHeight );
			_mainView.addChild(gameField);
			
			gameInfoPanel = new GameInfoPanel(150, _mainView.stage.stageHeight);
			gameInfoPanel.x = _mainView.stage.stageWidth - 150;
			_mainView.addChild(gameInfoPanel);
			
			_mainView.addEventListener(GameEvent.END_GAME_EVENT, onEndGame, true);
			gameField.addEventListener(GameEvent.WIN_GAME_EVENT, onWinGame);
			
			gameInfoPanel.addEventListener(GameEvent.PAUSE_GAME_EVENT, onPauseGame);
			gameInfoPanel.addEventListener(GameEvent.RESTART_GAME_EVENT, onRestartGame);
			gameInfoPanel.addEventListener(GameEvent.LEVEL_1_EVENT, onNextLevel);
			
			gameMes = new GameMassage();
			gameMes.x = (gameInfoPanel.x - gameMes.width)>>1
			gameMes.y = (_mainView.stage.stageHeight - gameMes.height)>>1
		}
		
		private function onEndGame(event: GameEvent): void
		{
			gameEnd = true;
			gameField.pause(true);
			gameMes.messageText = "You are lose!!!";
			_mainView.addChild(gameMes);
		}
		
		private function onWinGame(event: GameEvent): void
		{
			gameEnd = true;
			gameField.pause(true);
			gameMes.messageText = "You are win!!!";
			_mainView.addChild(gameMes);
		}
		
		private function onPauseGame(event: GameEvent): void
		{
			gameField.pause(event.pause);
		}
		
		private function onRestartGame(event: GameEvent): void
		{
			gameField.onStartGame();
			
			if(_mainView.contains(gameMes))
				_mainView.removeChild(gameMes);
		}
		
		private function nextLevel(): void
		{
			switch(currentLevel)
			{
				case 0:
				{
					level = new Level(gameField);
					break; 
				}
				case 1:
				{
					level = new Level_1(gameField);
					var level1: XML = levelsXML.level.(@id=="1")[0];
					level.setLevelXML(level1);
					break;  
				}
				case 2:
				{
					level = new Level_1(gameField);
					//var level1: XML = levelsXML.level.(@id=="2")[0];
					//level.setLevelXML(level1);
					break;
				}
			}
			
			currentLevel++;
			
		}
		
		private function onNextLevel(event: GameEvent): void
		{
			nextLevel();
		}
	}
}