package Handler 
{
	import com.greensock.TweenLite;
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
		
		protected function addChildAt(child:DisplayObject, layer:int = 1):void
		{
			child.alpha = 0;
			GameMain.layers[layer].addChild(child as DisplayObject);
			TweenLite.to(child, 1, {alpha:1})
		}
		
		protected function removeChild(child:DisplayObject):void
		{
			TweenLite.to(child, 1, { alpha:0, onComplete:function():void
			{
				TweenLite.killTweensOf(child);
				if (child.parent)
					child.parent.removeChild(child as DisplayObject);
			}})
		}
	}
}