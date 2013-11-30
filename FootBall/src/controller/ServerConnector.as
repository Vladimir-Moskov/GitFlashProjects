package controller
{
	import com.netease.protobuf.Message;
	import com.netease.protobuf.ReadUtils;
	
	import events.IncommingDataEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import model.FieldModel;
	
	import protobuf.Login;
	import protobuf.Logout;

	public class ServerConnector extends EventDispatcher
	{
		static private const HOST: String = "host";
		static private const PORT: int = 8080;
		
		static private var _instance: ServerConnector;
		
		private var _socket: Socket;
		
		
		public function ServerConnector(singeltonHelper: SingeltonHelper)
		{
		}
		
		static public function get instance(): ServerConnector
		{
			if(!_instance)
				_instance = new ServerConnector(new SingeltonHelper());
			
			return _instance;
		}
		
		public function createConnection(): void
		{
			_socket = new Socket();
			
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onDataRecieve);
			
			_socket.addEventListener(Event.CONNECT, socketConnected);
			_socket.addEventListener(Event.CLOSE, socketClosed);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, socketError);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, socketError);
			
			_socket.connect(HOST, PORT);
		}
		
		private function onDataRecieve(socketEvent: ProgressEvent): void
		{
			trace(onDataRecieve + " = " + socketEvent);
			var byteAr: ByteArray = new ByteArray();
			_socket.readBytes(byteAr, 0, _socket.bytesAvailable);
			
			byteAr.position = 0; 
			
			dispatchEvent(new IncommingDataEvent(IncommingDataEvent.INCOMMING_DATA, byteAr));
			/*
			bytes.position = 0; 
			//read
			var message:Message  = new Message();
			//читаем не всё сообщение, а только имя псевдонима
			var alias:String = message.readClassAliasFromDataOutput(bytes);
			
			var classRef:Class = getClassByAlias(alias) as Class;
			var item:* = new  classRef();
			
			bytes.position = 0; 
			item.readFromDataOutput(bytes);
			// выполняем метод конкретного класса
			item.changeModel();	*/
			
			
		}
		
		private function socketConnected(socketEvent: Event): void
		{
			trace(socketConnected + " = " + socketEvent);
			
			sendToServer(new Login())
		}
		
		public function logout(): void
		{
			
			if(_socket && _socket.connected)
			{
				var logout: Logout = new Logout();
				logout.userId = FieldModel.userID;
				sendToServer(logout);
				
				_socket.close();
			}
				
		}
		
		private function socketClosed(event: Event): void
		{
			trace(socketClosed + " = " + event);
		}
		
		private function socketError(event: ProgressEvent): void
		{
			trace(socketError + " = " + event);
		}
		
		public function sendToServer(message: Message): void
		{

			if(_socket && _socket.connected)
			{
				try {
					var bytes:ByteArray = new ByteArray();
					
					message.writeTo(bytes);
					
					_socket.writeBytes(bytes);
					_socket.writeMultiByte('\n', 'UTF-8');
				
				} catch(e:Error) {
					
				}
			
				_socket.flush();
			}
		}
	}
	
}

class SingeltonHelper
{
	
}
