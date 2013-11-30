/**
 * 
 */
package
{
	import flash.display.Sprite;
	
	import pureMVC.ApplicationFacade;
	
	[SWF(width='800',height='600',backgroundColor='#bbbbbb',frameRate='25')]
	public class WheelOfFortune_VMoskov extends Sprite
	{
		public function WheelOfFortune_VMoskov()
		{
			init();
		}
		
		private function init(): void
		{
			//initialise PureMVC Flow
			ApplicationFacade.getInstance().startup( this );
		}
	}
}