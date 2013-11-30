/**
 *User Info Panel 
 */
package pureMVC.view.components.mainscreen
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.osmf.elements.ImageLoader;
	
	import pureMVC.model.vo.UserVO;
	
	public class UserInfo extends Sprite
	{
		private var avatarBm: Bitmap;
		private var nameTf: TextField;
		private var coinsTf: TextField;
		
		private var nameLbTf: TextField;
		private var coinsLbTf: TextField;
		
		private var format:TextFormat
		
		public function UserInfo()
		{
			super();
			
			init();
		}
		
		private function init(): void
		{
			format = new TextFormat();
			format.size = 30;
			
			nameLbTf = new TextField();
			nameLbTf.text = "Name:";
			nameLbTf.setTextFormat( format);
			nameLbTf.autoSize = TextFieldAutoSize.LEFT;
			nameLbTf.wordWrap = true; 
			nameLbTf.y = 200;
			addChild(nameLbTf);
			
			nameTf = new TextField();
			nameTf.y = 200;
			nameTf.x = 100;
			addChild(nameTf);
			
			coinsLbTf = new TextField();
			coinsLbTf.text = "Coins:";
			coinsLbTf.setTextFormat( format);
			coinsLbTf.autoSize = TextFieldAutoSize.LEFT;
			coinsLbTf.wordWrap = true; 
			coinsLbTf.y = 250;
			addChild(coinsLbTf);
			
			coinsTf = new TextField();
			coinsTf.y = 250;
			coinsTf.x = 100;
			addChild(coinsTf);
			
		}
		
		public function injectUser(userVo: UserVO): void
		{
			if(userVo)
			{
				nameTf.text = userVo.name;
				nameTf.setTextFormat( format);

				coinsTf.text = String(userVo.coins);
				coinsTf.setTextFormat( format);
			}
				
		}
		
		public function injectAvatar(avatar: Bitmap): void
		{
			if(avatar)
			{
				if(avatarBm && contains(avatarBm))
					removeChild(avatarBm);
				avatarBm = new Bitmap(avatar.bitmapData);
				avatarBm.x = 50;
				avatarBm.width = 200;
				avatarBm.height = 200;
				addChild(avatarBm);
			}
			
		}
	}
}