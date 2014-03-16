package Control 
{
	import Enum.AssetList;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import Manager.LoadingManager;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	/**
	 * ...
	 * @author hello
	 */
	public class BackgroundControlHorizontal extends BaseComponentControl
	{
		private var bgList:Array = []
		private var oneLoopTime:Number;
		private var random:Boolean;
		
		public function BackgroundControlHorizontal(backgroundPoint:Object, imgs:Array, period:Number, _random:Boolean = false) 
		{
			super(backgroundPoint);
			oneLoopTime = period;
			random = _random;
			bgList = imgs.concat();
		}
		
		protected override function onStage(e:Event):void
		{
			super.onStage(e);
			for (var i:int = 0 ; i < bgList.length; i++)
			{
				bgList[i].y = 0;
				StartTweenBg(bgList[i], i * bgList[i].width);
				ui.addChild(bgList[i]);
			}
		}
		
		protected override function offStage(e:Event):void
		{
			super.offStage(e);
			for (var i:int = 0 ; i < bgList.length; i++)
			{
				TweenMax.killTweensOf(bgList[i]);
				if(bgList[i].parent)
					bgList[i].parent.removeChild(bgList[i]);
			}
		}
		
		private function StartTweenBg(bg:DisplayObject, originalX:Number):void
		{
			TweenMax.fromTo(bg, oneLoopTime * ( (originalX + 600)/ (bg.width + 600)), {x:originalX}, { x:-bg.width, ease:Linear.easeNone,  onComplete:function():void
			{
				TweenMax.killTweensOf(bg);
				StartTweenBg(bg, random?600 + bg.width * Math.random():bg.width);
			}} );
		}
	}
}