package Utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import Manager.GameLoopManager;
	import starling.display.Image;
	import flash.display.IBitmapDrawable;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author JL
	 */
	public class BTool 
	{
		//public static var BitmapAtlas:Dictionary = new Dictionary();
		//public static var BitmapXML:Dictionary = new Dictionary();
		
		private static var TAtlas:Dictionary = new Dictionary();
		private static var T:Dictionary = new Dictionary();
		
		public static function Put(key:String, bitmapAtla:Bitmap, bitmapXML:XML):void
		{
			TAtlas[key] = new TextureAtlas(Texture.fromBitmap(bitmapAtla), bitmapXML);
			//BitmapAtlas[key] = bitmapAtla;
			//BitmapXML[key] = bitmapXML;
			//trace(bitmapXML.SubTexture.length());
		}
		
		public static function GetImagePackage(key:String, label:String):Vector.<Texture>
		{
			var DKey:String = key.concat(label);
			if (T[DKey])
				return T[DKey] as Vector.<Texture>;
				
			var at:TextureAtlas = TAtlas[key];
			var ts:Vector.<Texture> = at.getTextures(label);
			T[DKey] = ts;
			return ts;
		}
		
		public static function GetImage(key:String, label:String ):Texture
		{
			var DKey:String = key.concat(label);
			if (T[DKey])
				return T[DKey] as Texture;
				
			var at:TextureAtlas = TAtlas[key];
			var t:Texture = at.getTexture(label);
			T[DKey] = t;
			return t;
		}
		
		public static function CloneBitmaps(bms:Vector.<Texture>):Vector.<Texture>
		{
			return bms.concat();
		}
	}
}