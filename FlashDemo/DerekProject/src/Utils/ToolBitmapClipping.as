package Utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author JL
	 */
	public class ToolBitmapClipping 
	{
		public static var BitmapAtlas:Dictionary = new Dictionary();
		public static var BitmapXML:Dictionary = new Dictionary();
		
		public static function Put(key:String, bitmapAtla:Bitmap, bitmapXML:XML):void
		{
			BitmapAtlas[key] = bitmapAtla;
			BitmapXML[key] = bitmapXML;
			//trace(bitmapXML.SubTexture.length());
		}
		
		public static function GetImagePackage(key:String, label:String):Vector.<Bitmap>
		{
			var bms:Bitmap = BitmapAtlas[key] as Bitmap;
			var vals:XML = BitmapXML[key] as XML;
			
			var Frames:Vector.<Bitmap> = new Vector.<Bitmap>();
			
			for each(var val:XML in vals.SubTexture)
			{
				var name:String = val.@name;
				if (name.indexOf(label) > -1)
				{
					var x:Number = val.@x;
					var y:Number = val.@y;
					var width:Number = val.@width;
					var height:Number = val.@height;
					var sourceRect:Rectangle = new Rectangle(x,y,width,height);
					var bmd:BitmapData = new BitmapData(width, height);
					bmd.copyPixels(bms.bitmapData, sourceRect, new Point(0, 0));
					Frames.push(new Bitmap(bmd,"always", true));
				}
			}
			
			return Frames;
		}
	}

}