package robotlegs.view
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import robotlegs.model.FieldConteiner;
	import robotlegs.model.ImageVO;
	import robotlegs.model.TurnVO;
	
	public class FieldView extends Sprite
	{
		private var fieldImage: Bitmap;
		private var crossImage: Bitmap;
		private var zeroImage: Bitmap;
		
		private var gameObjectAr: Array;
		
		private var turnTextTF: TextField;
		private var textFormat: TextFormat;
		
		public var fieldH: int = 400;
		public var fieldW: int = 400;
		
		
		public function FieldView()
		{
			super();
			init();
		}
		
		private function init(): void
		{
			graphics.beginFill(0xff0000);
			graphics.drawRect(0, 0, 600, 400);
			graphics.endFill();
			
			textFormat = new TextFormat();
			textFormat.size = 30;
			
			turnTextTF = new TextField
			turnTextTF.text = "Your Turn!";
			turnTextTF.setTextFormat( textFormat);
			turnTextTF.autoSize = TextFieldAutoSize.LEFT;
			turnTextTF.x = 500;
			turnTextTF.y = 300;
			addChild(turnTextTF);
			
			gameObjectAr = [];
		}
		
		public function addField(imageVO: ImageVO): void
		{
			this.fieldImage = new Bitmap(imageVO.image.bitmapData);
			this.fieldImage.width = fieldH;
			this.fieldImage.height = fieldW;
			
			addChild(fieldImage);
		}
		public function addZero(imageVO: ImageVO): void
		{
			this.zeroImage =  new Bitmap(imageVO.image.bitmapData);
		}
		public function addCross(imageVO: ImageVO): void
		{
			this.crossImage =  new Bitmap(imageVO.image.bitmapData);
		}
		
		public function startGame(fieldAr: Array): void
		{
			var subAr: Array;
			for(var i: int = 0; i < fieldAr.length; i ++)
			{
				subAr = fieldAr[i];
				for(var j: int = 0; j < subAr.length; j ++)
				{
					if(subAr[j] == FieldConteiner.USER_ID)
						setObject(new Bitmap(crossImage.bitmapData), i, j);
					else if(subAr[j] == FieldConteiner.AI_ID)
						setObject(new Bitmap(zeroImage.bitmapData), i, j);
				}
			}
		}
		
		private function setObject(image: Bitmap, cell_X: int, cell_Y:int): void
		{
			var newx: int = cell_X * (fieldW / 3);
			var newy: int = cell_Y * (fieldH / 3);
			image.x = newx + 15;
			image.y = newy + 15;
			addChild(image);
			gameObjectAr.push(image);
		}
		
		public function showTurn(turnVO: TurnVO): void
		{
			if(turnVO.palaeyrID == FieldConteiner.USER_ID)
			{
				setObject(new Bitmap(crossImage.bitmapData), turnVO.cell_x, turnVO.cell_y);
				turnTextTF.text = "AI Turn!";
				turnTextTF.setTextFormat( textFormat);
			}
				
			else if(turnVO.palaeyrID == FieldConteiner.AI_ID)
			{
				setObject(new Bitmap(zeroImage.bitmapData), turnVO.cell_x, turnVO.cell_y);
				turnTextTF.text = "Your Turn!";
				turnTextTF.setTextFormat( textFormat);
			}
				
		}
		
		public function clearView(): void
		{
			for each(var image: Bitmap in gameObjectAr)
				removeChild(image);
					
			gameObjectAr = [];
			
		}
		
	}
}