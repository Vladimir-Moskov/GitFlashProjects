package pureMVC.model.vo
{
	import flash.display.Bitmap;

	public class UserVO
	{
		public var name: String;
		public var avatarPath: String;
		public var coins: Number;
		
		public function UserVO(name: String, avatarPath: String, coins: Number)
		{
			this.name = name;
			this.avatarPath = avatarPath;
			this.coins = coins;
		}
	}
}