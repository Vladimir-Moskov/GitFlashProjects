package robotlegs.controller.events
{
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import robotlegs.model.ImageVO;
	
	public class LoadImageEvent extends Event
	{
		public static const LOAD_IMAGE:String = 'LOAD_IMAGE';
		public static const LOAD_IMAGE_SUCCES:String = 'LOAD_IMAGE_SUCCES';
		public static const LOAD_ALL_IMAGES_SUCCES:String = 'LOAD_ALL_IMAGES_SUCCES';

		public var imageVO: ImageVO;
		public var image: Bitmap;
		
		public function LoadImageEvent(type:String, imageVO: ImageVO = null, image: Bitmap = null)
		{
			super(type, bubbles, cancelable);
			this.imageVO = imageVO;
			this.image = image;
		}
		override public function clone():Event
		{
			return new LoadImageEvent(type, imageVO, image);
		}
	}
}