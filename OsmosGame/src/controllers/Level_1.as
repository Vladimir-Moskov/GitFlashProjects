package controllers
{
	import components.GameField;
	import components.LevelShape;
	
	public class Level_1 extends Level
	{
		public function Level_1(gameField:GameField)
		{
			super(gameField);
		}
		
		override public function setLevelXML(levelXml: XML): void
		{
			var rectXmlLict: XMLList = levelXml.rectangels.rectangel;
			recVec = new Vector.<LevelShape>(rectXmlLict.length(), true);
			var recXML: XML;
			for (var i: int = 0; i <  recVec.length; i++)
			{
				recXML = rectXmlLict[i];
				recVec[i] = new LevelShape(recXML.@x, recXML.@y, recXML.@width, recXML.@height);
				_gameField.addChild(recVec[i]);
			}
			
			
		}
	}
}