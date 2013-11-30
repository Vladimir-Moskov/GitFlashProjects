package controller
{
	import events.IncommingDataEvent;
	import events.UserActionEvent;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import model.FieldModel;
	
	import protobuf.Player;
	import protobuf.UserAction;
	
	import view.FieldView;

	public class FieldController
	{
		private var _field: FieldView;
		private var _fieldModel: FieldModel;
		
		
		public function FieldController(field: FieldView)
		{
			this._field = field;
			_fieldModel = new FieldModel();
			
			ServerConnector.instance.addEventListener(IncommingDataEvent.INCOMMING_DATA, onDataRecieve);
			_field.addEventListener(UserActionEvent.USER_ACTION, onUserAcrion);
			
			useMock();
		}
		
		private function onDataRecieve(event: IncommingDataEvent): void
		{
			//TODO - incomiing data hendler
			_field.updateView(_fieldModel.field)
		}
		private function onUserAcrion(event: UserActionEvent): void
		{
			var userAction: UserAction = new UserAction();
			userAction.x = event.x;
			userAction.y = event.y;
			ServerConnector.instance.sendToServer(userAction);
		}
		
		private function useMock(): void
		{
			_fieldModel.mockInit();
			_field.updateView(_fieldModel.field);
			var timer: Timer = new Timer(50);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}
		
		private function onTimer(event: Event): void
		{
			_fieldModel.field.ball.x += (Math.random()*2 - 1);
			_fieldModel.field.ball.y += (Math.random()*2 - 1);
			for each(var player: Player in _fieldModel.field.players)
			{
				player.x += (Math.random()*2 - 1);
				player.y += (Math.random()*2 - 1);
			}
			_field.updateView(_fieldModel.field);
		}
		
		
	}
}