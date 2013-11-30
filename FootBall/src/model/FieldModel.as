package model
{
	import flash.sampler.NewObjectSample;
	
	import protobuf.Ball;
	import protobuf.Field;
	import protobuf.Player;

	public class FieldModel
	{
		static public var userID: int;
		
		public var field: Field;
		
		
		public function FieldModel()
		{
			
		}
		
		public function mockInit(): void
		{
			userID = 1;
			
			field = new Field();
			field.players = [];
			
			var ball: Ball = new Ball();
			ball.x = 300;
			ball.y = 200;
			field.ball = ball;
			
			var player1: Player = new Player();
			player1.x = 100;
			player1.y = 200;
			player1.id = 1;
			field.players.push(player1);
			
			var player2: Player = new Player();
			player2.x = 100;
			player2.y = 100;
			player2.id = 2;
			field.players.push(player2);
			
			var player3: Player = new Player();
			player3.x = 300;
			player3.y = 300;
			player3.id = 3;
			field.players.push(player3);
			
			var player4: Player = new Player();
			player4.x = 100;
			player4.y = 300;
			player4.id = 4;
			field.players.push(player4);
			
		}
		
	}
}