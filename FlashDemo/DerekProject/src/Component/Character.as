package Component 
{
	import Control.AnimationPlayer;
	import Manager.GameLoopManager;
	import starling.display.Image;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	import Manager.LoadingManager;
	import starling.textures.Texture;
	import Utils.B2PlayerStackEvent;
	import Utils.B2PlayerUnStackedEvent;
	import Utils.PlayerCollideEvent;
	import com.greensock.TweenMax;
	import Utils.BTool;
	/**
	 * ...
	 * @author hello
	 */
	public class Character extends BaseComponent
	{
		private var ui:Sprite;
		private static var flyingAnim:Vector.<Texture>;
		
		private var flyingAnimPlayer:AnimationPlayer;
		
		public function Character() 
		{
			ui = new Sprite();
			if (!flyingAnim)
				flyingAnim = BTool.GetImagePackage("character", "flying");
			flyingAnimPlayer = new AnimationPlayer(ui, BTool.CloneBitmaps(flyingAnim), 30, true);
			super(ui);
		}
		
		protected override function onStage(e:Event):void
		{
			super.onStage(e);
			GameLoopManager.Core.stage.addEventListener("B2PlayerStack", onPlayerStack);
			GameLoopManager.Core.stage.addEventListener("B2PlayerUnStacked", onPlayerUnStacked);
		}
		protected override function offStage(e:Event):void
		{
			super.offStage(e);
			GameLoopManager.Core.stage.removeEventListener("B2PlayerStack", onPlayerStack);
			GameLoopManager.Core.stage.removeEventListener("B2PlayerUnStacked", onPlayerUnStacked);
		}
		
		
		private function onPlayerStack(e:B2PlayerStackEvent):void
		{
			//var panda:MovieClip = ui["ui"];
		}
		
		private function onPlayerUnStacked(e:B2PlayerUnStackedEvent):void
		{
			//var panda:MovieClip = ui["ui"];
		}
	}
}

