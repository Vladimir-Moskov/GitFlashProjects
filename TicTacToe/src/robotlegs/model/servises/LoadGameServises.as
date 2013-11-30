package robotlegs.model.servises
{
	import flash.net.SharedObject;
	
	import org.robotlegs.mvcs.Actor;
	
	import robotlegs.controller.events.EndGameEvent;
	import robotlegs.controller.events.FieldTurnEvent;
	import robotlegs.controller.events.LoadGameInfoEvent;
	import robotlegs.model.FieldConteiner;
	import robotlegs.model.servises.IResponder;

	public class LoadGameServises  extends Actor
	{
		
		private var shareObject: SharedObject;
		
		public function LoadGameServises()
		{
			
		}
		
		public function loadGameInfo(): void
		{
			shareObject = SharedObject.getLocal("TicTacToe");
			dispatch(new LoadGameInfoEvent(LoadGameInfoEvent.LOAD_GAME_INFO_SUCCES, shareObject.data.gameInfoAr));
		}
		
		public function saveGameInfo(gameinfoAr: Array): void
		{
			shareObject = SharedObject.getLocal("TicTacToe");
			shareObject.data.gameInfoAr = gameinfoAr;
			shareObject.flush();
		}
		public function clear(): void
		{
			shareObject = SharedObject.getLocal("TicTacToe");
			shareObject.clear();
		}
	}
}