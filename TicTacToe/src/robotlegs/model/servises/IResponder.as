package robotlegs.model.servises
{
	public interface IResponder
	{
		function result( rpcEvent : Object ) : void;
		function fail( rpcEvent : Object ) : void;
	}
}