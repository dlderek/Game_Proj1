package Control 
{
	import Enum.AssetList;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
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
		public function BackgroundControlStatic(backgroundPoint:Object, img:DisplayObject) 
		{
			//while (backgroundPoint.numChildren > 0)
				//backgroundPoint.removeChildAt(0);
			
			this.img = img;
			super(backgroundPoint);
		}
		
		public function start():void
		{
			ui.addChild(img);
		}
		
		protected override function offStage(e:Event):void
		{
			super.offStage(e);
			if(img.parent)
				img.parent.removeChild(img);
		}
	}
}