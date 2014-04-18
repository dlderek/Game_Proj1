package Manager 
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	/**
	 * ...
	 * @author JL
	 */
	public class XMLManager 
	{
		public static var config:XML;
		public static var files:XML;
		public static var obstacleGroup:XML;
		public static var obstacleGroup2:XML;
		
		public static function set ObstacleGroup(OG:XML):void
		{
			obstacleGroup = OG;
		}
		
		public static function set ObstacleGroup2(OG:XML):void
		{
			obstacleGroup2 = OG;
		}
		
		public static function SaveConfig():void
		{
			try
			{
				var fs : FileStream = new FileStream();
				//var targetPath : File = File.applicationDirectory;
				//var _url:String = "config.xml";
				trace(File.applicationStorageDirectory.nativePath);
				var targetFile:File = new File(File.applicationStorageDirectory.resolvePath("config.xml").nativePath );
				fs.open(targetFile, FileMode.WRITE);
				fs.writeUTFBytes(config);
				fs.close();
			}
			catch (e:Error)
			{
				GameLoopManager.Core.TraceMsg(e.message);
				SoundManager.PlaySound("die");
			}
		}
	}

}