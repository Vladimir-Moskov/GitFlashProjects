package pureMVC.view.components
{
	import fl.controls.Button;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import pureMVC.model.vo.UserVO;
	import pureMVC.view.components.mainscreen.UserInfo;
	
	public class MainScreen extends Sprite
	{
		static public const SPIN_START: String = "spinStart";
		
		private var spinBt: Button; 
		private var userInfoPanel: UserInfo;
		private var timerTF: TextField;
		private var timer: Timer;
		
		private var format:TextFormat;
		
		public function MainScreen()
		{
			super();
			
			init()
		}
		
		private function init(): void
		{
			format = new TextFormat();
			format.size = 25;
			
			userInfoPanel = new  UserInfo();
			addChild(userInfoPanel);
			
			spinBt = new Button();
			spinBt.label = "Spin";
			spinBt.y = 400;
			spinBt.x = 100;
			spinBt.setStyle("textFormat", format);
			spinBt.setSize(200, 75);
			
			spinBt.addEventListener(MouseEvent.CLICK, onBtClickHandler, false, 0, true);
			addChild(spinBt);
			
			timerTF	= new TextField();
			timerTF.text = "";
			timerTF.y = 400;
			timerTF.x = 100;
			timerTF.visible = false;
			addChild(timerTF);
		}
		
		private function onBtClickHandler(event: MouseEvent ): void
		{
			startSpin();
		}
		
		private function startSpin(): void
		{
			dispatchEvent(new Event(SPIN_START));
		}
		public function injectUser(userVo: UserVO): void
		{
			userInfoPanel.injectUser(userVo);
		}
		public function injectAvatar(avatar: Bitmap): void
		{
			userInfoPanel.injectAvatar(avatar);
		}
		
		public function injectSpinTime(time: int): void
		{
			timerTF.visible = true;
			spinBt.visible = false;

			timer = new Timer(1000, time);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete, false, 0, true);
			timer.addEventListener(TimerEvent.TIMER, onTimerChange, false, 0, true);

			timer.start();
		}
		
		private function onTimerComplete(event: TimerEvent): void
		{
			(event.target as Timer).stop();
			timerTF.visible = false;
			spinBt.visible = true;
			
		}
		private function onTimerChange(event: TimerEvent): void
		{
			timerTF.text = (timer.repeatCount -  timer.currentCount) + " sec." ;
			timerTF.setTextFormat(format);
		}
		
	}
}