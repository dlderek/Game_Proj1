package Control 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	import com.greensock.TweenLite;
	import Component.B2World;
	import Component.Block.BaseBlock;
	import Component.UnStackMe;
	import Enum.LayerList;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import Manager.GameLoopManager;
	import Manager.SoundManager;
	import Utils.B2PlayerStackEvent;
	import Utils.PlayerCollectionEvent;
	import Utils.PlayerCollideEvent;
	/**
	 * ...
	 * @author hello
	 */
	public class B2WorldControl extends BaseComponentControl
	{
		private var world:B2World;
		private var unStackMe:UnStackMe;
		private var unStackMe2:UnStackMe;
		private var BlockGenerator:B2WordBlockGenerateControl;
		public var CurrentScore:Number = 0;
		public var CurrentCollection:int = 0;
		
		public function B2WorldControl(_origin:Object) 
		{
			super(_origin);
			world = new B2World();
			ui.addChild(world);
			BlockGenerator = new B2WordBlockGenerateControl(world);
			
		}
		
		protected override function onStage(e:Event):void
		{
			super.onStage(e);
			world.StartGame();
			BlockGenerator.start();
			GameLoopManager.Core.stage.addEventListener("B2PlayerStack", onPlayerStack);
			GameLoopManager.Core.stage.addEventListener("PlayerDie", onPlayerDie);
			GameLoopManager.Core.stage.addEventListener("PlayerCollide", onPlayerCollide);
			GameLoopManager.Core.stage.addEventListener("PlayerCollection", onPlayerCollection);
		}
		protected override function offStage(e:Event):void
		{
			super.offStage(e);
			GameLoopManager.Core.stage.removeEventListener("B2PlayerStack", onPlayerStack);
			GameLoopManager.Core.stage.removeEventListener("PlayerDie", onPlayerDie);
			GameLoopManager.Core.stage.removeEventListener("PlayerCollide", onPlayerCollide);
			GameLoopManager.Core.stage.removeEventListener("PlayerCollection", onPlayerCollection);
		}
		
		public function Reset():void
		{
			if (world.parent)
				world.parent.removeChild(world);
			world = new B2World();
			BlockGenerator = new B2WordBlockGenerateControl(world);
			ui.addChild(world);
			world.StartGame();
			BlockGenerator.start();
			CurrentScore = 0;
			CurrentCollection = 0;
		}
		
		private function onPlayerStack(e:B2PlayerStackEvent):void
		{
			if (unStackMe && unStackMe2 && unStackMe.parent && unStackMe2.parent)
			{
				unStackMe.parent.removeChild(unStackMe);
				unStackMe2.parent.removeChild(unStackMe2);
			}
			var targetMC:BaseBlock = e.stackObject.GetUserData().mc;
			unStackMe = new UnStackMe(e.stackLevel);
			unStackMe2 = new UnStackMe(e.stackLevel);
			unStackMe.alpha = 0.7;
			unStackMe2.alpha = 0.7;
			unStackMe.x = 5 + targetMC.width/2;
			unStackMe2.x = -5 + targetMC.width/2;
			unStackMe.scaleX = -1;
			targetMC.addChild(unStackMe);
			targetMC.addChild(unStackMe2);
			//GameLoopManager.Core.layers[LayerList.Popup].addChild(unStackMe);
		}
		
		private function onPlayerDie(e:Event):void
		{
			Reset();
		}
		
		private function onPlayerCollide(e:PlayerCollideEvent):void
		{
			//if (e.speed < 2.5)
				//return;
			var id:String = "BA";
			SoundManager.PlaySound(id);
		}
		
		private function onPlayerCollection(e:PlayerCollectionEvent):void
		{
			CurrentCollection++;
		}
	}
}
