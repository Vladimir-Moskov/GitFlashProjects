package robotlegs.model
{
	public class TurnVO
	{
		public var palaeyrID: int;
		public var cell_x: int;
		public var cell_y: int;
		
		public function TurnVO(palaeyrID: int, cell_x: int, cell_y: int)
		{
			this.palaeyrID = palaeyrID; 
			this.cell_x = cell_x, 
			this.cell_y = cell_y;
		}
	}
}