package Manager 
{
	import Enum.CmdList;
	import Enum.LayerList;
	import flash.system.Capabilities;
	import flash.utils.setTimeout;
	import starling.core.StatsDisplay;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import flash.display.IBitmapDrawable;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import flash.system.System;
	//import flash.text.Font;
	//import flash.text.FontStyle;
	import starling.text.TextField;
	//import flash.text.TextField;
	//import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import flash.utils.setInterval;
	import Handler.*;
	import starling.textures.Texture;
	import Utils.BTool;
	/**
	 * ...This class is responsible for Handling SAO.
	 * @author JL
	 */
	public class GameLoopManager 
	{
		public static var Core:GameLoopManager;
		public var stage:Sprite;
		public var layers:Vector.<Sprite>;
		private var HandlerList:Vector.<BaseHandler>;
		
		public function GameLoopManager(stage:Sprite) 
		{
			Core = this;
			this.stage = stage;
			InitXML();
		}
		
		private function ConstructHandler():void
		{
			HandlerList = new Vector.<BaseHandler>();
			HandlerList.push(
			new PageHandler(this), 
			new BattleHandller(this), 
			new StageHandler(this), 
			new GameOverHandler(this),
			new RecordHandler(this),
			new SettingHandler(this)
			);
		}
		
		private function InitXML():void
		{
			LoadingManager.Init();
			LoadingManager.load("config.xml", "files.xml", "ObstacleGroup.xml", "ObstacleGroup2.xml");
			stage.addEventListener("LoadingComplete", XMLLoaded);
		}

		private function XMLLoaded(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			XMLManager.config = LoadingManager.getXML("config.xml");
			XMLManager.files = LoadingManager.getXML("files.xml");
			XMLManager.ObstacleGroup = LoadingManager.getXML("ObstacleGroup.xml");
			XMLManager.ObstacleGroup2 = LoadingManager.getXML("ObstacleGroup2.xml");
			ObstacleGroupManager.init(XMLManager.obstacleGroup, XMLManager.obstacleGroup2);
			stage.addEventListener("LoadingComplete", FilesLoaded);
			LoadingManager.loadFiles();
		}
		
		private function FilesLoaded(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			GameStart();
		}
		
		
		
		/**
		 * @Info Game Start here, At this point, all the files needed were loaded/ inited completely.
		 */
		private function GameStart():void
		{
			while (stage.numChildren > 0)
				stage.removeChildAt(0);
			
			if (Main.onDevice)
			{
				var sh:Shape = new Shape();
				sh.graphics.beginFill(0);
				sh.graphics.drawRect(0, 0, 600, 1000);
				sh.graphics.endFill();
				stage.addChild(sh);
				stage.width = Capabilities.screenResolutionX;
				stage.height = Capabilities.screenResolutionY * 0.95;
			}
			
			layers = new Vector.<Sprite>();
			for (var i:int = 0; i < 5; i ++)
			{
				var layer:Sprite = new Sprite();
				layers.push(layer);
				stage.addChild(layer);
			}
			
			ConstructHandler();
			addTask( { cmd:CmdList.CMD_INIT_HANDLER } );
			//setInterval(gc, 10000);
			//stage.addEventListener(Event.ENTER_FRAME, UselessLoop);
			Main.removeLoadingImage();
			addTask( { cmd:CmdList.CMD_SWICH_PAGE, page:"Stage" } );
		}
		
		
		public function addTask(task:Object):void
		{
			for each(var handler:BaseHandler in HandlerList)
			{
				if (handler.TaskList[task.cmd])
				{
					handler.process(task);
				}
			}
		}
		
		//private function UselessLoop(e:Event):void
		//{
			//for (var i:int = 0 ; i < 1; i++)
			//{
				//var bmd:BitmapData = new BitmapData(600,1000);
				//bmd.draw(layers[LayerList.UI] as IBitmapDrawable, null, null, null, null, true);
				//var bm:Bitmap = new Bitmap(bmd, "always", true);
			//}
		//}
		
		public function gc():Boolean
		{
			 try
			 {
			   System.gc()
			   return true;
			 }
			 catch (e:Error)
			 {
			   return false;
			 }
			 return true;
		}
	}
}