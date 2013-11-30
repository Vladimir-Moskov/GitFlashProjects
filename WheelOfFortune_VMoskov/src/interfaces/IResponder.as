package interfaces
{
	public interface IResponder
	{
		function result( rpcEvent : Object ) : void;
		function fail( rpcEvent : Object ) : void;
	}
}