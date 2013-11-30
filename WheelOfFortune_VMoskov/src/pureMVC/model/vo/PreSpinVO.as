package pureMVC.model.vo
{
	public class PreSpinVO
	{
		public var coins: int;
		public var probability: Number;
		
		public function PreSpinVO(coins: int, probability: Number)
		{
			this.coins = coins;
			this.probability = probability;
		}
	}
}