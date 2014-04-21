package Component 
{
	import com.facebook.graph.FacebookMobile;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	import starling.display.Image;
	import starling.text.TextField;
	import Utils.TextTool;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author JL
	 */
	public class RateElement extends BaseComponent
	{
		private var id:String;
		private var userName:String;
		private var score:int;
		
		private var pic:Image;
		private var txt_name:TextField;
		private var txt_score:TextField;
		
		public function RateElement(id:String, userName:String, score:int) 
		{
			this.id = id;
			this.userName = userName;
			this.score = score;
			
			pic = new Image(Texture.fromColor(100,100,0xFFFFFF));
			txt_name = TextTool.DefaultTextfield(200, 55, 30, 0xFFFFFF);
			txt_name.x = 150; txt_name.y = 0;
			txt_name.text = userName;
			txt_score = TextTool.DefaultTextfield(200, 55, 30, 0xFFFFFF);
			txt_score.x = 150; txt_score.y = 60;
			txt_score.text = score.toString();
			
			super(pic);
			this.addChild(txt_name);
			this.addChild(txt_score);
			getImage();
		}
		
		private function getImage():void
		{
			var params:Object = 
			{
				fields:"picture"
			};
			FacebookMobile.api("/".concat(id), onGetImage, params);
		}
		
		private function onGetImage(response:Object, fail:Object):void
		{
			if (response)
			{
				var url:String = response.picture.data.url;
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
				loader.load(new URLRequest(url));
			}
			else
			{
				trace("get image fail");
			}
		}
		
		private function onImageLoaded(e:Event):void
		{
			e.target.removeEventListener(e.type, onImageLoaded);
			var bm:Bitmap = ((e.target as LoaderInfo).content as Bitmap);
			pic = new Image(Texture.fromBitmap(bm));
			pic.width = 100;
			pic.height = 100;
			this.addChild(pic);
		}
	}
}