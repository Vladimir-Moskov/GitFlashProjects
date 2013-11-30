package pureMVC.view.components
{
	import fl.controls.Button;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.sensors.Accelerometer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class WheelScreen extends Sprite
	{
		static public const WHEEL_SPIN_START: String = "wheelSpinStart";
		static public const WHEEL_CLOSE: String = "wheelClose";
		static public const WHEEL_SPIN_STOP: String = "wheelSpinStop";
		
		static public const ROTATION_SPEED: int = 5;
		static public const MIN_FULL_CIRCLS: int = 1;
		
		private var wheelSp: Wheel;
		private var winPointerSp: Pointer;
		private var closeBt: Button;
		private var spinBt: Button;
		
		private var currAngl: int = 0;
		private var currSpinSpeed: int = 0;
		private var currWinAngl: int = 0;
		
		private var curDelRotAngl: int = 0;
		private var curDelPoint: int = 0;
		
		private var format:TextFormat;
		
		public function WheelScreen()
		{
			super();
			
			init();
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage, false, 0, true)
		}
		
		private function onAddToStage(event: Event):void
		{
			currAngl = 0;
			currWinAngl = 0;
			curDelRotAngl = 0;
			curDelPoint = 0;
			if(wheelSp)
				wheelSp.rotation = 0;
		}
		
		private function init(): void
		{
			format = new TextFormat();
			format.size = 25;
			
			graphics.beginFill(0xbbbbbb);
			graphics.drawRect(0, 0, 800, 600);
			graphics.endFill();
			
			wheelSp = new Wheel();
			wheelSp.x = 200;
			wheelSp.y = 250;
			wheelSp.width = 300;
			wheelSp.height = 300;
			addChild(wheelSp);
			
			winPointerSp = new Pointer();
			winPointerSp.width = 50;
			winPointerSp.height = 50;
			winPointerSp.x = 220;
			winPointerSp.y = 80;
			addChild(winPointerSp);
			
			closeBt = new Button();
			closeBt.label = "Close";
			closeBt.x =250;
			closeBt.setStyle("textFormat", format);
			closeBt.setSize(200, 75);
			addChild(closeBt);
			closeBt.addEventListener(MouseEvent.CLICK, onCloseHadler);
			
			spinBt = new Button();
			spinBt.label = "SPIN!";
			spinBt.x = 150;
			spinBt.y = 400;
			spinBt.setStyle("textFormat", format);
			spinBt.setSize(200, 75);
			addChild(spinBt);
			
			spinBt.addEventListener(MouseEvent.CLICK, onSpinHadler);
			
		}
		
		private function createwheel(): void
		{
			wheelSp = new Wheel();
			wheelSp.width = 300;
			wheelSp.height = 300;
		}
		
		private function createPointer(): void
		{
			winPointerSp = new Pointer();
			winPointerSp.width = 50;
			winPointerSp.height = 50;
			/*winPointerSp.graphics.beginFill(0xff0000);
			winPointerSp.graphics.lineStyle(3);
			winPointerSp.graphics.moveTo(0, 0);
			winPointerSp.graphics.lineTo(20, 0);
			winPointerSp.graphics.lineTo(10, 15);
			winPointerSp.graphics.lineTo(0, 0);
			
			winPointerSp.graphics.endFill();*/
		}
		
		public function injectSpinResult(winSector: int):void
		{
			currWinAngl = (winSector - 1/2) * (360/ 12) - 10;
			trace("winSector = " + winSector);
			trace("currWinAngl = " + currWinAngl);
		}
		
		private function onCloseHadler(event: MouseEvent): void
		{
			dispatchEvent(new Event(WHEEL_CLOSE));
		}
		
		private function onSpinHadler(event: MouseEvent): void
		{
			dispatchEvent(new Event(WHEEL_SPIN_START));
			startSpin();
		}
		
		private function startSpin(): void
		{
			currSpinSpeed = ROTATION_SPEED;
			addEventListener(Event.ENTER_FRAME, onRotation, false, 0, true);
			
		}
		
		private function onRotation(event: Event): void
		{
			wheelSp.rotation -= currSpinSpeed;
			currAngl += currSpinSpeed;
			
			if(currAngl >=  MIN_FULL_CIRCLS*360 + currWinAngl)
			{
				removeEventListener(Event.ENTER_FRAME, onRotation);
				curDelPoint = 360/2;
				addEventListener(Event.ENTER_FRAME, onDelay, false, 0, true);
			}
		}
		
		private function onDelay(event: Event): void
		{
			wheelSp.rotation -= currSpinSpeed;
			curDelRotAngl += currSpinSpeed;
			if(currSpinSpeed > 0 && curDelPoint < curDelRotAngl)
			{
				curDelPoint = curDelPoint /2;
				curDelRotAngl = 0;
				currSpinSpeed -= 1;
			}
			if(currSpinSpeed == 0)
			{
				stopRotation();
			}
				
		}
		
		private function stopRotation(): void
		{
			removeEventListener(Event.ENTER_FRAME, onDelay);
			dispatchEvent(new Event(WHEEL_SPIN_STOP));
			
		}
	}
}