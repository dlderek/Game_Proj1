package Utils 
{
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import starling.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import Manager.LoadingManager;
	public class ToolKit 
	{
		public static const APP_ID:String = '211416619068748';
		
		//public static function ConvertedSprite(sources:DisplayObject):Sprite
		//{
			//if (sources == null)
				//return null;
			//var BD:BitmapData = new BitmapData(sources.width, sources.height, true, 0x111111);
			//BD.draw(sources, null, null, null, null, true);
			//var BM:Bitmap = new Bitmap(BD);
			//var sprite:Sprite = new Sprite();
			//BM.x = -sources.width / 2;
			//BM.y = -sources.height / 2;
			//sprite.addChild(BM);
			//sprite.mouseEnabled = false;
			//sprite.mouseChildren = false;
			//return sprite;
		//}
		
		public static function getBgSprite(id:int = 1):Image
		{
			var bg:Image;
			try{
				bg = new Image( BTool.GetImage("BattlePage_bg", "bg".concat(id)));
			}catch (e:Error)
			{
				bg = new Image( BTool.GetImage("BattlePage_bg2", "bg".concat(id)));
			}
				
			return bg;
		}
		
	}

}