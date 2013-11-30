package main.components
{
	import flash.display.Sprite;
	
	public class WordElement extends Sprite
	{
		private var guessedWord: String;
		private var cellVec: Vector.<LetterCell>;
		
		public function WordElement()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			cellVec = new Vector.<LetterCell>();
			var tempCell: LetterCell;
			for(var i: int = 0; i < 10; i++)
			{
				tempCell = new LetterCell();
				tempCell.x = i * tempCell.width + 5;
				cellVec.push(tempCell);
				addChild(tempCell);
			}
		}
		
		public function showWord(newWord: String): void{
			guessedWord = newWord;
			hideAllCells();
			addCells();
			showGuessedWord();
		}
		
		public function checkLetter(letter: String): Boolean{
			var isCorrect: Boolean = false;
			var index: int = guessedWord.indexOf(letter); 
			if(index > -1 ){
				isCorrect = true
				if(!cellVec[index].letterVisible){
					while(index > -1 ){
						cellVec[index].showLetter();
						index =  guessedWord.indexOf(letter, index + 1);
					}
				}
			}
			return isCorrect;
		}
		public function checkWin(): Boolean{
			var isWin: Boolean = true;
			for(var i: int = 0; i < guessedWord.length; i++)
			{
				if(	!cellVec[i].letterVisible){
					isWin = false;
					break;
				}
			}
			return isWin;
		}
		
		private function addCells(): void{
			var delta: int = guessedWord.length - cellVec.length;
			if(delta > 0)
			{
				var tempCell: LetterCell;
				for(var i: int = 0; i < delta; i++)
				{
					tempCell = new LetterCell();
					tempCell.x = (i + cellVec.length) * tempCell.width + 5;
					cellVec.push(tempCell);
					addChild(tempCell);
				}
			}
		}
		
		private function hideAllCells(): void{
			for(var i: int = 0; i < cellVec.length; i++)
			{
				cellVec[i].visible = false;
				cellVec[i].hideLetter();
			}
		}
		
		private function showGuessedWord(): void{
			var char: String;
			for(var i: int = 0; i < guessedWord.length; i++)
			{
				char = guessedWord.charAt(i);
				cellVec[i].setLetter(char);
				cellVec[i].visible = true;
			}
		}
		
		
	}
}