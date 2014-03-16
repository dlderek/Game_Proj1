package Utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import Manager.LoadingManager;
	import Enum.AssetList;
	public class ToolKit 
	{
		public static function ConvertedSprite(sources:DisplayObject):Sprite
		{
			if (sources == null)
				return null;
			var BD:BitmapData = new BitmapData(sources.width, sources.height, true, 0x111111);
			BD.draw(sources, null, null, null, null, true);
			var BM:Bitmap = new Bitmap(BD);
			var sprite:Sprite = new Sprite();
			BM.x = -sources.width / 2;
			BM.y = -sources.height / 2;
			sprite.addChild(BM);
			sprite.mouseEnabled = false;
			sprite.mouseChildren = false;
			return sprite;
		}
		
		public static function getBgSprite():Bitmap
		{
			var bg:Bitmap = LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BG) as Bitmap;
			bg.cacheAsBitmap = true;
			return bg;
		}
		
		public static function getBg2Sprite():Bitmap
		{
			var bg:Bitmap = LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BG2) as Bitmap;
			bg.cacheAsBitmap = true;
			return bg;
		}
		
		public static function getBg3Sprite():Bitmap
		{
			var bg:Bitmap = LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BG3) as Bitmap;
			bg.cacheAsBitmap = true;
			return bg;
		}
		
		public static function getBg4Sprite():Bitmap
		{
			var bg:Bitmap = LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BG4) as Bitmap;
			bg.cacheAsBitmap = true;
			return bg;
		}
		
	}

}