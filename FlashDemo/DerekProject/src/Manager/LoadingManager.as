package Manager 
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.display.DisplayObject; 
	import starling.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.xml.XMLNode;
	import Utils.BTool;
	/**
	 * ...
	 * @author JL
	 * This Class is responsible for loading items from external sources; e.g. swf, jpg
	 */
	public class LoadingManager 
	{
		private static var loader:BulkLoader;
		
		public static function Init():void
		{
			loader = new BulkLoader();
		}
		
		public static function load(...paths):void
		{
			for each(var path:String in paths)
				loader.add(path);
			loader.addEventListener(BulkLoader.COMPLETE, loaded);
			loader.start();
		}
		
		private static function loaded(e:BulkProgressEvent):void
		{
			var worker:BulkLoader = (e.target as BulkLoader);
			worker.removeEventListener(e.type, arguments.callee);
			GameLoopManager.Core.stage.dispatchEvent(new Event("LoadingComplete"));
		}
		
		public static function get checkLoadComplete():Boolean
		{
			return loader.isFinished;
		}
		
		public static function loadFiles():void
		{
			var files:XML = XMLManager.files;
				
			for each(var item:String in files.png.*)
				loader.add("atlas/" + item + ".png");
				
			for each(item in files.xml.*)
				loader.add("atlas/" + item + ".xml");
				
			for each(item in files.swf.*)
				loader.add("swf/" + item + ".swf");
				
			//for each(item in files.wav.*)
				//loader.add("sound/" + item + ".wav");
			loader.addEventListener(BulkLoader.COMPLETE, loadedFiles);
			loader.start();
		}
		
		private static function loadedFiles(e:BulkProgressEvent):void
		{
			var worker:BulkLoader = (e.target as BulkLoader);
			worker.removeEventListener(e.type, arguments.callee);
			
			var files:XML = XMLManager.files;
			for each(var item:String in files.xml.*)
			{
				BTool.Put(item, getBitmapFromSwf(item), getXML("atlas/" + item + ".xml"));
			}
			trace(loader.remove("swf/Atlas.swf"));
			GameLoopManager.Core.stage.dispatchEvent(new Event("LoadingComplete"));
		}
		
		public static function getXML(key:String):XML
		{
			return loader.getXML(key, true);
		}
		
		public static function getClass(key:String, className:String):Class
		{
			var swf:LoadingItem = loader.get("swf/" + key + ".swf");
			var cls:Class = ImageItem(swf).getDefinitionByName(className) as Class;
			return cls;
		}
		
		public static function getBitmapFromSwf(asLink:String):Bitmap
		{
			var cls:Class = LoadingManager.getClass("Atlas", asLink);
			return new Bitmap(new cls() as BitmapData);
		}
		
		public static function getSound(key:String):Sound
		{
 			return loader.getSound(key);
		}
	}
}