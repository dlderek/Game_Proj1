package Control 
{
	import starling.display.DisplayObjectContainer;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import Manager.LoadingManager;
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	/**
	 * ...
	 * @author hello
	 */
	public class BackgroundControlStatic extends BaseComponentControl
	{
		private var img:DisplayObject;
		public function BackgroundControlStatic(backgroundPoint:Sprite, img:DisplayObject) 
		{
			//while (backgroundPoint.numChildren > 0)
				//backgroundPoint.removeChildAt(0);
			
			this.img = img;
			super(backgroundPoint);
		}
		
		public function start():void
		{
			(ui as DisplayObjectContainer).addChild(img);
		}
		
		protected override function offStage(e:Event):void
		{
			super.offStage(e);
			if(img.parent)
				img.parent.removeChild(img);
		}
	}
}