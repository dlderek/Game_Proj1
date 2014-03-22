package Component 
{
	import Enum.AssetList;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	import Manager.LoadingManager;
	import Utils.B2PlayerStackEvent;
	import Utils.B2PlayerUnStackedEvent;
	import Utils.PlayerCollideEvent;
	import com.greensock.TweenMax;
	/**
	 * ...
	 * @author hello
	 */
	public class Character extends BaseComponent
	{
		private var ui:MovieClip;
		private var currentStatus:String = "flying"; //flying, collision
		public function Character() 
		{
			ui = LoadingManager.getItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_CHARACTER) as MovieClip;
			super(ui);
			ui.stop();
		}
		
		protected override function onStage(e:Event):void
		{
			super.onStage(e);
			stage.addEventListener("PlayerCollide", onPlayerCollide);
			stage.addEventListener("B2PlayerStack", onPlayerStack);
			stage.addEventListener("B2PlayerUnStacked", onPlayerUnStacked);
		}
		protected override function offStage(e:Event):void
		{
			super.offStage(e);
			stage.removeEventListener("PlayerCollide", onPlayerCollide);
			stage.removeEventListener("B2PlayerStack", onPlayerStack);
			stage.removeEventListener("B2PlayerUnStacked", onPlayerUnStacked);
		}
		
		private function onPlayerCollide(e:PlayerCollideEvent):void
		{
			if (currentStatus != "collision")
			{
				currentStatus = "collision";
				ui.gotoAndStop("collision");
				var panda:MovieClip = ui["ui"];
				TweenMax.fromTo(panda, panda.totalFrames/60, { frame:1 }, { frame:panda.totalFrames, onComplete:function():void
				{
					ui.gotoAndStop("flying");
					currentStatus = "flying";
				}});
			}
		}
		
		private function onPlayerStack(e:B2PlayerStackEvent):void
		{
			var panda:MovieClip = ui["ui"];
		}
		
		private function onPlayerUnStacked(e:B2PlayerUnStackedEvent):void
		{
			var panda:MovieClip = ui["ui"];
		}
	}
}

