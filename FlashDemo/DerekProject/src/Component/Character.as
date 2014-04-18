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
		private static var collideAnim:Vector.<Texture>;
		
		private var flyingAnimPlayer:AnimationPlayer;
		private var collideAnimPlayer:AnimationPlayer;
		
		public function Character() 
		{
			ui = new Sprite();
			if (!flyingAnim)
				flyingAnim = BTool.GetImagePackage("character", "flying");
			if (!collideAnim)
				collideAnim = BTool.GetImagePackage("character2", "collision");
			
			flyingAnimPlayer = new AnimationPlayer(ui, BTool.CloneBitmaps(flyingAnim), 30, true);
			collideAnimPlayer = new AnimationPlayer(ui, BTool.CloneBitmaps(collideAnim), 60, true);
			collideAnimPlayer.stop();
			super(ui);
		}
		
		protected override function onStage(e:Event):void
		{
			super.onStage(e);
			GameLoopManager.Core.stage.addEventListener("PlayerCollide", onPlayerCollide);
		}
		protected override function offStage(e:Event):void
		{
			super.offStage(e);
			GameLoopManager.Core.stage.removeEventListener("PlayerCollide", onPlayerCollide);
			ui.removeEventListener("AnimationComplete", resetAnimation);
		}
		
		
		private function onPlayerCollide(e:PlayerCollideEvent):void
		{
			collideAnimPlayer.play();
			flyingAnimPlayer.stop();
			ui.addEventListener("AnimationComplete", resetAnimation);
		}
		
		private function resetAnimation(e:Event):void
		{
			flyingAnimPlayer.play();
			collideAnimPlayer.stop();
		}
	}
}

