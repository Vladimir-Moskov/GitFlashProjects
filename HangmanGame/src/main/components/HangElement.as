package main.components
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import flashx.textLayout.utils.CharacterUtil;
	
	public class HangElement extends Sprite
	{
		[Embed(source="./assets/images/V1.png")]
		public static var v1Image:Class;
		
		[Embed(source="./assets/images/V2.png")]
		public static var v2Image:Class;
		
		[Embed(source="./assets/images/V3.png")]
		public static var v3Image:Class;
		
		[Embed(source="./assets/images/V4.png")]
		public static var v4Image:Class;
		
		[Embed(source="./assets/images/V5.png")]
		public static var v5Image:Class;
		
		[Embed(source="./assets/images/V6.png")]
		public static var v6Image:Class;
		
		[Embed(source="./assets/images/man.png")]
		public static var manImage:Class;
		
		public static var v1Element: Bitmap;
		public static var v2Element: Bitmap;
		public static var v3Element: Bitmap;
		public static var v4Element: Bitmap;
		public static var v5Element: Bitmap;
		public static var v6Element: Bitmap;
		public static var manElement: Bitmap;
		
		public function HangElement()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			drawElements();
		}
		
		private function drawElements():void
		{
			v1Element = new v1Image as Bitmap;
			v1Element.visible = false;
			v1Element.x = 50;
			v1Element.y = 280;
			addChild(v1Element);
			
			v2Element = new v2Image as Bitmap;
			v2Element.visible = false;
			v2Element.x = 60;
			v2Element.y = 310;
			addChild(v2Element);
			
			v3Element = new v3Image as Bitmap;
			v3Element.visible = false;
			v3Element.x = 80;
			v3Element.y = 115;
			addChild(v3Element);
			
			v4Element = new v4Image as Bitmap;
			v4Element.visible = false;
			v4Element.x = 97;
			v4Element.y = 105;
			addChild(v4Element);
			
			v5Element = new v5Image as Bitmap;
			v5Element.visible = false;
			v5Element.x = 82;
			v5Element.y = 95;
			addChild(v5Element);
			
			v6Element = new v6Image as Bitmap;
			v6Element.visible = false;
			v6Element.x = 158;
			v6Element.y = 110;
			addChild(v6Element);
			
			manElement = new manImage as Bitmap;
			manElement.visible = false;
			manElement.x = 150;
			manElement.y = 110;
			addChild(manElement);
		}
		
		public function showElement(elementNum: int):void
		{
			if(numChildren > elementNum)
				getChildAt(elementNum).visible = true;
		}
		
		public function hideAllElements():void
		{
			for(var i: int = 0; i < numChildren; i++){
				getChildAt(i).visible = false;
			}
			
		}
	}
}