package Handler 
{
	import starling.display.DisplayObject;
	import flash.utils.Dictionary;
	import Manager.GameLoopManager;
	/**
	 * ...
	 * @author JL
	 */
	public class BaseHandler 
	{
		protected var GameMain:GameLoopManager;
		public var TaskList:Dictionary;
		
		public function BaseHandler(GameMain:GameLoopManager) 
		{
			this.GameMain = GameMain;
			TaskList = new Dictionary();
		}
		
		public function process(task:Object):void
		{
			
		}
		
		protected function addTask(task:Object):void
		{
			GameMain.addTask(task);
		}
		
		protected function addChildAt(child:Object, layer:int = 1):void
		{
			GameMain.layers[layer].addChild(child as DisplayObject);
		}
		
		protected function removeChild(child:Object):void
		{
			if (child.parent)
				child.parent.removeChild(child as DisplayObject);
		}
	}
}