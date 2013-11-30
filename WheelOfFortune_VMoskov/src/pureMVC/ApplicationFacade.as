package pureMVC
{
    import flash.display.Sprite;
    
    import org.puremvc.as3.interfaces.IFacade;
    import org.puremvc.as3.patterns.facade.Facade;
    
    import pureMVC.controller.MainScreenPrepComand;
    import pureMVC.controller.StartupCommand;
    
    public class ApplicationFacade extends Facade implements IFacade
    {
        // Notification name constants
        public static const STARTUP:String  		= "startup";
		public static const STAGE_ADD_WELCOM:String	= "stageAddWelcomScreen";
		public static const STAGE_REMOVE_WELCOM:String = "stageRemoveWelcom";
		
		public static  const PLAY_START: String = "playStart";
		
		public static const STAGE_ADD_MAIN:String	= "stageAddMainScreen";
		public static const LOAD_USER_INFO:String	= "loadUserInfo";
		public static const LOAD_USER_AVATAR:String	= "loadUserAvatar";
		public static const INJECT_USER_INFO:String	= "injectUserInfo";
		public static const INJECT_USER_AVATAR:String	= "injectUserAvatar";
		public static const LOAD_SPINTIME:String	= "loadSpinTime";
		public static const INJECT_LOAD_SPINTIME:String	= "injectLoadSpinTime";
		
		public static const SPIN_START:String	= "spinStart";
		
		public static const STAGE_ADD_WHEEL:String	= "stageAddWheel";
		public static const STAGE_REMOVE_WHEEL:String	= "stageRemoveWheel";
		public static const INJECT_SPIN_RESULT:String	= "injectSpinResult";
		public static const SPIN_STOP:String	= "spinStop";

		
		/**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance() : ApplicationFacade {
            if ( instance == null ) 
				instance = new ApplicationFacade( );
            return instance as ApplicationFacade;
        }

        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController();     
			
            registerCommand( STARTUP, StartupCommand );
			registerCommand( STAGE_ADD_MAIN, MainScreenPrepComand );
        }
        
        public function startup( stage: Sprite ):void
        {
			sendNotification( STARTUP, stage );
        }
        
    }
}