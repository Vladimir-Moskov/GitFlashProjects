package pureMVC.model
{
    import org.puremvc.as3.interfaces.IProxy;
    import org.puremvc.as3.patterns.proxy.Proxy;

    public class WelcomScreenDataProxy extends Proxy implements IProxy
    {
        public static const NAME:String = 'WelcomScreenDataProxy';

		public var welcomMessage: String = "Welcom!";
		public var playBtText: String = "Play";
		
		public function WelcomScreenDataProxy( )
        {
			super(NAME);
        }
		
		
     }
}