package events
{
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	public class IncommingDataEvent extends Event
	{
		static public const INCOMMING_DATA: String = "incommingData";
		
		private var dataBA: ByteArray;
		
		public function IncommingDataEvent(type:String, dataBA: ByteArray)
		{
			super(type, bubbles, cancelable);
			this.dataBA = dataBA;
		}
		
		override public function clone(): Event
		{
			return new IncommingDataEvent(type, dataBA);
		}
	}
}