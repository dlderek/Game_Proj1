package Manager 
{
	import Enum.CmdList;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.system.System;
	import flash.text.Font;
	import flash.text.FontStyle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import Handler.*;
	import Utils.ToolBitmapClipping;
	/**
	 * ...This class is responsible for Handling SAO.
	 * @author JL
	 */
	public class GameLoopManager 
	{
		private static const TaskLimitPerFrame:int = 10;
		
		public static var Core:GameLoopManager;
		public var stage:Stage;
		public var layers:Vector.<Sprite>;
		private var HandlerList:Vector.<BaseHandler>;
		private var TaskQueue:Vector.<Object>;
		
		private var traceMsg:TextField;
		
		public function GameLoopManager(stage:Stage) 
		{
			Core = this;
			this.stage = stage;
			InitXML();
		}
		
		private function ConstructHandler():void
		{
			HandlerList = new Vector.<BaseHandler>();
			HandlerList.push(new HomeHandler(this), new PageHandler(this), new BattleHandller(this), new StageHandler(this), new GameOverHandler(this));
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
			InitGameElements();
			GameStart();
		}
		
		/**
		 * Create the bitmapAtlas
		 */
		private function InitGameElements():void
		{
			ToolBitmapClipping.Put("character", LoadingManager.getBitmap("atlas/character.png"), LoadingManager.getXML("atlas/character.xml"));
			ToolBitmapClipping.Put("waterfall", LoadingManager.getBitmap("atlas/waterfall.png"), LoadingManager.getXML("atlas/waterfall.xml"));
		}
		
		/**
		 * @Info Game Start here, At this point, all the files needed were loaded/ inited completely.
		 */
		private function GameStart():void
		{
			layers = new Vector.<Sprite>();
			for (var i:int = 0; i < 5; i ++)
			{
				var layer:Sprite = new Sprite();
				layers.push(layer);
				stage.addChild(layer);
			}
			
			traceMsg = new TextField();
			traceMsg.mouseEnabled = false;
			traceMsg.width = 300;
			traceMsg.height = 200;
			//layers[4].addChild(traceMsg);
			setMsg("hello");
			
			TaskQueue = new Vector.<Object>();
			ConstructHandler();
			addTask( { cmd:CmdList.CMD_INIT_HANDLER } );
			addTask( { cmd:CmdList.CMD_SWICH_PAGE, page:"Stage" } );
			stage.addEventListener(Event.ENTER_FRAME, TaskLoop);
		}
		
		
		public function addTask(task:Object):void
		{
			TaskQueue.push(task);
		}
		
		private function TaskLoop(e:Event):void
		{
			if (TaskQueue.length == 0)
				return;
			for (var i:int = 0; i < TaskLimitPerFrame; i ++)
			{
				var task:Object = TaskQueue.shift();
				if (!task)
					return;
				for each(var handler:BaseHandler in HandlerList)
				{
					if (handler.TaskList[task.cmd])
					{
						handler.process(task);
					}
				}
			}
		}
		
		public function setMsg(msg:*):void
		{
			traceMsg.text = msg.toString();
		}
	}
}