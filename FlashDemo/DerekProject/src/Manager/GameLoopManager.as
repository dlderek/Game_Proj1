package Manager 
{
	import Enum.CmdList;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import Handler.*;
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
		
		public function GameLoopManager(stage:Stage) 
		{
			Core = this;
			this.stage = stage;
			InitXML();
		}
		
		private function ConstructHandler():void
		{
			HandlerList = new Vector.<BaseHandler>();
			HandlerList.push(new HomeHandler(this), new PageHandler(this), new BattleHandller(this));
		}
		
		private function InitXML():void
		{
			LoadingManager.Init();
			LoadingManager.load("config.xml", "files.xml", "ObstacleGroup.xml");
			stage.addEventListener("LoadingComplete", XMLLoaded);
		}

		private function XMLLoaded(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			XMLManager.config = LoadingManager.getXML("config.xml");
			XMLManager.files = LoadingManager.getXML("files.xml");
			XMLManager.ObstacleGroup = LoadingManager.getXML("ObstacleGroup.xml");
			stage.addEventListener("LoadingComplete", FilesLoaded);
			LoadingManager.loadFiles();
		}
		
		private function FilesLoaded(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			GameStart();
		}
		
		/**
		 * @Info Game Start here, At this point, all the files needed were loaded completely.
		 */
		private function GameStart():void
		{
			layers = new Vector.<Sprite>();
			for (var i:int = 0; i < 4; i ++)
			{
				var layer:Sprite = new Sprite();
				layers.push(layer);
				stage.addChild(layer);
			}
			
			
			TaskQueue = new Vector.<Object>();
			ConstructHandler();
			addTask( { cmd:CmdList.CMD_INIT_HANDLER } );
			addTask( { cmd:CmdList.CMD_SWICH_PAGE, page:"Home" } );
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
	}
}