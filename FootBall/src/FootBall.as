package
{
	import controller.FieldController;
	import controller.ServerConnector;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.dns.AAAARecord;
	
	import view.BallView;
	import view.FieldView;
	import view.PlayerView;
	
	[SWF(width='800',height='600',backgroundColor='#cccccc',frameRate='25')]
	public class FootBall extends Sprite
	{
		private var field: FieldView;
		private var fieldController: FieldController;
		
		public function FootBall()
		{
			init();
			//stage.nativeWindow.addEventListener(Event.CLOSING, closeApplication, false, 0, true);
			NativeApplication.nativeApplication.addEventListener(Event.EXITING, onClose);
		}
		
		
		private function init(): void
		{
			createSocetConnection();
		}
		
		private function onClose(event: Event): void
		{
			ServerConnector.instance.logout();
		}
		
		public function closeApplication(e:Event):void
		{      
			//trace("don't exit");
			e.preventDefault();
			
			//here is where i can add my prompt
			
			var windowOptions:NativeWindowInitOptions = new NativeWindowInitOptions();
			windowOptions.systemChrome = NativeWindowSystemChrome.STANDARD;
			windowOptions.type = NativeWindowType.NORMAL;
			
			var newWin:NativeWindow = new NativeWindow(windowOptions);
			newWin.width = 300;
			newWin.height = 100;
			newWin.title = "Are you sure?";
			newWin.activate();
			newWin.addEventListener(Event.CLOSING, exitAll);
		}
		
		public function exitAll(e:Event):void
		{
			NativeApplication.nativeApplication.exit();
			
		}
		private function createSocetConnection():void
		{
			//ServerConnector.instance.createConnection();
			
			field = new FieldView();
			field.x = 15;
			field.y = 15;
			this.addChild(field);
			
			fieldController = new FieldController(field);
			/*
			var pl: Player = new Player(0xff0000);
			pl.x = 150;
			pl.y = 150;
			field.addChild(pl);
			
			var bl: Ball = new Ball(0xffff00);
			bl.x = 250;
			bl.y = 250;
			field.addChild(bl);
			*/
		}
	}
}