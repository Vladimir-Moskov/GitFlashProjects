package robotlegs.model
{
	import flash.display.Bitmap;

	public class ImageVO
	{
		
		public var path: String;
		public var name: String;
		public var image: Bitmap;
		
		public function ImageVO(name: String, path: String, image: Bitmap = null)
		{
			this.path = path;
			this.name = name;
			this.image = image;
		}
	}
}