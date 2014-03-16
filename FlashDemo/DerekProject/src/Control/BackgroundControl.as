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
	import Utils.PlayerYChangeEvent;
	/**
	 * ...
	 * @author hello
	 */
	public class BackgroundControl extends BaseComponentControl
	{
		private var bgList:Array = []
		private var oneLoopTime:Number = 10;
		private var fz:Number;
		public function set OneLoopTime(value:Number):void
		{ 
			if (oneLoopTime == value)
				return;
			oneLoopTime = value;
			for (var i:int = 0 ; i < bgList.length; i++)
			{
				TweenLite.killTweensOf(bgList[i]);
				StartTweenBg(bgList[i], bgList[i].y);
			}
		};
		
		public function BackgroundControl(backgroundPoint:Object, img:DisplayObject, period:Number, AppearFreqency:Number) 
		{
			super(backgroundPoint);
			oneLoopTime = period;
			fz = AppearFreqency;
			bgList.push(img);
		}
		
		protected override function onStage(e:Event):void
		{
			super.onStage(e);
			ui.stage.addEventListener("PlayerYChange", onPlayerYResponse);
			for (var i:int = 0 ; i < bgList.length; i++)
			{
				StartTweenBg(bgList[i], Math.random() * 1000);
				ui.addChild(bgList[i]);
			}
		}
		
		protected override function offStage(e:Event):void
		{
			super.offStage(e);
			ui.stage.removeEventListener("PlayerYChange", onPlayerYResponse);
			for (var i:int = 0 ; i < bgList.length; i++)
			{
				TweenLite.killTweensOf(bgList[i]);
				if(bgList[i].parent)
					bgList[i].parent.removeChild(bgList[i]);
			}
		}
		
		private function StartTweenBg(bg:DisplayObject, originalY:Number):void
		{
			bg.y = originalY;
			TweenLite.to(bg, oneLoopTime * ( (originalY + 1100)/ 2100), { y:-1100, ease:Linear.easeNone,  onComplete:function():void
			{
				TweenLite.killTweensOf(bg);
				StartTweenBg(bg, 1000 + Math.random() * 1000 * (1/fz));
			}} );
		}
		
		private function onPlayerYResponse(e:PlayerYChangeEvent):void
		{
			var newLoopTime:Number = Math.round((20 - e.TweenSpeedRatio * 10)*10)/10;
			OneLoopTime = newLoopTime;
		}
		
		
	}
}