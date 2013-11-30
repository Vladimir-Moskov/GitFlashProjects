package main
{
	import fl.controls.Button;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import main.components.GameEvent;
	import main.components.HangElement;
	import main.components.KeyBoardElement;
	import main.components.RulsElement;
	import main.components.StatisticElement;
	import main.components.WordElement;

	public class MainView extends Sprite
	{
		[Embed(source="./assets/images/bg.jpg")]
		public static var backGroundImage:Class;
		
		[Embed(source="./assets/images/hangman.png")]
		public static var hangmanImage:Class;
		
		[Embed(source="./assets/sounds/click.mp3")]
		public static var cliskSound:Class;
		
		[Embed(source="./assets/sounds/win.mp3")]
		public static var winSound:Class;
		
		[Embed(source="./assets/sounds/lose.mp3")]
		public static var lostSound:Class;
		
		public static const WIN_MESSAGE: String = "Congratulations\n you guessed the word";
		public static const LOST_MESSAGE: String = "You are LOST";
		
		public static var cliskSoundInstanse: Sound;
		
		private var winSoundInstanse: Sound;
		private var lostSoundInstanse: Sound;
		private var soundChannel:SoundChannel;
		
		private var rulsElement: RulsElement;
		private var statisticElement: StatisticElement;
		private var playButton: Button;
		private var hangElement: HangElement;
		private var wordElement: WordElement;
		private var keyBoardElement: KeyBoardElement;
		private var endGameMessage: TextField;
		private var endGameMessageFormat: TextFormat;
		
		private var wordsVec: Vector.<String>;
		private var currentWord: String;
		private var currentStep: int = 0;
		private var win: int = 0;
		private var lost: int = 0;
		
		public function MainView()
		{
			init();
		}
		
		private function init():void
		{
			drawBackGround();
			createStartView();
			cliskSoundInstanse = new cliskSound();
			lostSoundInstanse = new lostSound();
			winSoundInstanse = new winSound();
			

		}
		
		private function drawBackGround():void
		{
			var back: Bitmap = new backGroundImage as Bitmap;
			addChild(back);
		}
		
		private function createStartView():void
		{
			rulsElement = new RulsElement();
			rulsElement.x = 15;
			rulsElement.y = 80;
			
			addChild(rulsElement);
			
			var hangman: Bitmap = new hangmanImage as Bitmap;
			hangman.x = 5;
			hangman.y = 280;
			addChild(hangman);
			
			statisticElement = new StatisticElement();
			statisticElement.x = 110;
			statisticElement.y = 420;
			addChild(statisticElement);
			
			var textFormat:TextFormat = new TextFormat(); 
			textFormat.bold = true; 
			textFormat.color = 0xFFFFFF; 
			textFormat.size = 28;
			
			playButton = new Button();
			playButton.setStyle("disabledSkin", SimpleButton_disabledSkin);
			playButton.setStyle("upSkin", SimpleButton_upSkin);
			playButton.setStyle("downSkin", SimpleButton_downSkin);
			playButton.setStyle("overSkin", SimpleButton_overSkin);
			playButton.label = "PLAY";
			playButton.useHandCursor = true;
			playButton.setSize(175, 60);
			playButton.move(130, 320);
			playButton.setStyle("textFormat", textFormat);
			playButton.addEventListener(MouseEvent.CLICK, onPlayBtClick);
			
			addChild(playButton);
		}
		
		private function onPlayBtClick(event: MouseEvent): void{
			cliskSoundInstanse.play();
			playButton.visible = false;
			rulsElement.visible = false;
			
			if(wordsVec)
				showGamesElements();
			else	
				loadWords();
			
		}
		
		private function loadWords(): void{
			var strUrl: String = "assets/servises/wordList.xml";
			var service : URLRequest;
			var loader : URLLoader;

			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, completeHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);

			service = new URLRequest();
			service.url = strUrl;

			loader.load(service);
		}
			
		private function completeHandler(event: Event): void
		{
			var wordXML: XML = new XML(event.target.data as String);
			var wordXmlList: XMLList = wordXML.word;
			
			wordsVec = new Vector.<String>(wordXmlList..length())
			var i: int = 0;
			for each(var word: String in wordXmlList)
			{
				wordsVec[i] = word.toUpperCase();
				i++;
			}
			showGamesElements();
		}
		
		private function errorHandler(event: Event): void
		{
			trace(errorHandler);
		}
		
		private function showGamesElements(): void{
			if(!hangElement){
				hangElement = new HangElement();
				addChildAt(hangElement, 1);
			}

			takeNewWord();
			showWordElement();
			showKeyBoardElement();
			
			if(!endGameMessage){
				
				endGameMessageFormat = new TextFormat();
				endGameMessageFormat.size = 26;
				endGameMessageFormat.bold = true; ;
				endGameMessageFormat.color = 0xFFFFFF;
					
				endGameMessage = new TextField();
				endGameMessage.x = 50;
				endGameMessage.y = 150;
				endGameMessage.wordWrap = true;
				endGameMessage.multiline = true;
				endGameMessage.autoSize = TextFieldAutoSize.LEFT;
				endGameMessage.width = 260;
				endGameMessage.height = 190;
				endGameMessage.setTextFormat( endGameMessageFormat);
				endGameMessage.visible = false;
				
				addChild(endGameMessage);
			}
			
		}
		
		private function takeNewWord(): void{
			var newIndex: int = int(Math.random() * (wordsVec.length - 1));
			currentWord = wordsVec[newIndex];
		}
		
		private function showWordElement(): void{
			if(!wordElement){
				wordElement = new WordElement();
				wordElement.x = 10;
				wordElement.y = 30;
				addChild(wordElement);
			}
			wordElement.visible = true;
			wordElement.showWord(currentWord);
		}
		
		private function showKeyBoardElement(): void{
			if(!keyBoardElement){
				keyBoardElement = new KeyBoardElement();
				keyBoardElement.x = 95;
				keyBoardElement.y = 300;
				keyBoardElement.addEventListener(GameEvent.KEY_PRESS_EVENT, onKeyPress);
				addChild(keyBoardElement);
			}
			keyBoardElement.visible = true;
		}
		
		private function onKeyPress(event: GameEvent): void{
			var isCorrect: Boolean = wordElement.checkLetter(event.data);
			if(!isCorrect){
				hangElement.showElement(currentStep);
				currentStep++;
				if(currentStep == 7)
					showLost();
			}
			var isWin:Boolean =  wordElement.checkWin();	
			if(isWin){
				showWin();
			}
		}
		
		private function showLost(): void{
			endGameMessage.text = LOST_MESSAGE;
			endGameMessage.setTextFormat(endGameMessageFormat);
			endGameMessage.visible = true;
			
			keyBoardElement.enable = false;
			soundChannel = lostSoundInstanse.play();
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComlete, false, 0, true);
			lost++;
			statisticElement.lostNum = lost;
		}
		
		private function showWin(): void{
			endGameMessage.text = WIN_MESSAGE;
			endGameMessage.setTextFormat(endGameMessageFormat);
			endGameMessage.visible = true;
			
			keyBoardElement.enable = false;
			soundChannel = winSoundInstanse.play();
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComlete, false, 0, true);
			win++;
			statisticElement.winNum = win;
		}
		
		private function onSoundComlete(event: Event): void{
			soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComlete);
			restartGame();
		}
		
		private function restartGame(): void{
			playButton.visible = true;
			rulsElement.visible = true;
			currentStep = 0;
			hangElement.hideAllElements();
			wordElement.visible = false;
			keyBoardElement.visible = false;
			keyBoardElement.enable = true;
			endGameMessage.visible = false;
		}
		
	}
}