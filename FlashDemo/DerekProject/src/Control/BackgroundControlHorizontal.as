package Control 
{
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;
	import Manager.LoadingManager;
	/**
	 * ...
	 * @author hello
	 */
	public class BackgroundControlHorizontal extends BaseComponentControl
	{
		private var bgList:Array = []
		private var oneLoopTime:Number;
		private var random:Boolean;
		
		public function BackgroundControlHorizontal(backgroundPoint:Sprite, imgs:Array, period:Number, _random:Boolean = false) 
		{
			super(backgroundPoint);
			oneLoopTime = period;
			random = _random;
			bgList = imgs.concat();
		}
		public function start():void
		{
			for (var i:int = 0 ; i < bgList.length; i++)
			{
				bgList[i].y = 0;
				bgList[i].x = i * (bgList[i].width - 5);
				(ui as DisplayObjectContainer).addChild(bgList[i]);
			}
			ui.removeEventListener(Event.ADDED_TO_STAGE, onStage);
			ui.addEventListener(Event.REMOVED_FROM_STAGE, offStage);
			ui.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected override function offStage(e:Event):void
		{
			super.offStage(e);
			for (var i:int = 0 ; i < bgList.length; i++)
			{
				if(bgList[i].parent)
					bgList[i].parent.removeChild(bgList[i]);
			}
			ui.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			for each(var img:DisplayObject in bgList)
			{
				img.x --;
				if (img.x < -img.width + 5)
				{
					img.x = img.width - 5;
				}
			}
		}
	}
}