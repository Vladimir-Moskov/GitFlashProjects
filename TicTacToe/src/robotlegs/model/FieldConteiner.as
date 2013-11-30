package robotlegs.model
{
	import flash.display.Bitmap;
	
	import org.robotlegs.mvcs.Actor;
	
	import robotlegs.controller.events.EndGameEvent;
	import robotlegs.controller.events.FieldTurnEvent;

	public class FieldConteiner extends Actor
	{
		static public const FIELD_IMAGE_NAME: String = "field";
		static public const CROSS_IMAGE_NAME: String = "cross";
		static public const ZERO_IMAGE_NAME: String = "zero";
		
		static public const USER_ID: int = 1;
		static public const AI_ID: int = -1;
		static public const EMPTY_ID: int = 0;
		
		private var _fieldArray: Array = [[0, 0, 0],[0, 0, 0],[0, 0, 0]];
		private var _graphicsXML: XML;
		
		private var _imagesDic: Object;
		private var loadingAr: Array;
		private var curLoadingIndex: int = 0;
		
		public function FieldConteiner()
		{
			
		}
		public function set fieldArray(value: Array): void
		{
			if(value)
				_fieldArray = value;
			else
				_fieldArray = [[0, 0, 0],[0, 0, 0],[0, 0, 0]];
		}
		public function get fieldArray(): Array
		{
			return _fieldArray;
		}
		public function graphics(graphicsXML: XML): void
		{
			_graphicsXML = graphicsXML;
			loadingAr = [];
			_imagesDic = {};
			var index: int = 0;
			var xmlList: XMLList = _graphicsXML.children();
			for each(var item: XML in xmlList)
			{
				loadingAr.push(new ImageVO(item.localName(), String(item)));
				_imagesDic[item.localName()] = index;
				index++;
			}
			
		}
		
		public function currentImageBm(imageBm: Bitmap): void
		{
			(loadingAr[curLoadingIndex - 1] as ImageVO).image = imageBm;
		}
		
		public function loadNextImage(): ImageVO
		{
			if(curLoadingIndex == loadingAr.length)
				return null;
			
			curLoadingIndex ++;
			return loadingAr[curLoadingIndex - 1]
		}
		public function getImageByName(name: String): ImageVO
		{
			return loadingAr[_imagesDic[name]];
		}
		
		public function makeTurn(turn: TurnVO): void
		{
			_fieldArray[turn.cell_x][turn.cell_y] = turn.palaeyrID;
			dispatch(new FieldTurnEvent(FieldTurnEvent.SHOW_TURN, turn));
		
			if(checkVictory(turn.palaeyrID))
			{
				dispatch(new EndGameEvent(EndGameEvent.END_GAME, turn.palaeyrID));
			}
			else if(turn.palaeyrID == USER_ID)
			{
				madeAITurn();
			}
			
		}
		private function madeAITurn(): void
		{

			var turnVO: TurnVO = searchNextCellTurn();
			if(turnVO)
			{
				turnVO.palaeyrID = AI_ID
				dispatch(new FieldTurnEvent(FieldTurnEvent.MADE_TURN, turnVO));
			}
			else
			{
				dispatch(new EndGameEvent(EndGameEvent.END_GAME, EMPTY_ID));
			}
		}
		private function arraySum(array: Array): int
		{
			var sum: int = 0;
			for(var i: int = 0; i < array.length; i ++)
			{
				sum += array[i];
			}
			return sum;
		}
		
		private function  checkVictory(userId: int): Boolean
		{
			var vicInt: int = userId*3;
			var isVic: Boolean = false;
			var i: int;
			for(i = 0; i < _fieldArray.length; i ++)
			{
				if(arraySum(_fieldArray[i]) == vicInt)
				{
					isVic = true;
					break;
				}
				else if(arraySum([_fieldArray[0][i], _fieldArray[1][i], _fieldArray[2][i]]) == vicInt)
				{
					isVic = true;
					break;
				}
				
			}
			
			if(arraySum([_fieldArray[0][0], _fieldArray[1][1], _fieldArray[2][2]]) == vicInt)
				isVic = true;
			else if(arraySum([_fieldArray[0][2], _fieldArray[1][1], _fieldArray[2][0]]) == vicInt)
				isVic = true; 
				
			return isVic;
		}
		
		/**
		 * It's just stupid AI logic - nothing Special
		 * @return - new cell to AI turn
		 * 
		 */		
		private function searchNextCellTurn(): TurnVO
		{
			var subAr: Array;
			for(var i: int = 0; i < _fieldArray.length; i ++)
			{
				subAr = _fieldArray[i];
				for(var j: int = 0; j < subAr.length; j ++)
				{
					if(subAr[j] == EMPTY_ID)
					{
						return new TurnVO(EMPTY_ID, i, j)
					}
				}
			}
			
			return null;
		}
		
		public function isTurnPossible(turn: TurnVO) : Boolean
		{
			if(turn.cell_x < 3 && turn.cell_y < 3)
				return  _fieldArray[turn.cell_x][turn.cell_y] == EMPTY_ID;
			
			return false;
		}
	}
}