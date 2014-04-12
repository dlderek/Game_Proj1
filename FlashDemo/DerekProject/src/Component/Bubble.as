package Component 
{
	import Manager.GameLoopManager;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.display.Sprite;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	import Utils.BTool;
	import Utils.Particle.ParticleConfig;
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author JL
	 */
	public class Bubble
	{
		private static var bmd:Texture;
		private var PS:PDParticleSystem;
		
		public function Bubble() 
		{
			if (!bmd)
				bmd = BTool.GetImage("Particle", "bubble");
			PS = new PDParticleSystem(ParticleConfig["bubble"], bmd);
		}
		
		public function set x(v:Number):void 
		{ 
			PS.emitterX = v * (Main.onDevice?Capabilities.screenResolutionX / 600:1);
		}
		public function set y(v:Number):void 
		{ 
			PS.emitterY = v * (Main.onDevice?Capabilities.screenResolutionY / 1000:1);
		}
		
		public function start(time:Number = 0.1):void
		{
			GameLoopManager.Core.stage.stage.addChild(PS);
			Starling.juggler.add(PS);
			PS.start(time);
		}
		
		public function stop():void
		{
			PS.stop();
		}
		
		public function dispose():void
		{
			PS.clear();
			PS.stop();
			GameLoopManager.Core.stage.stage.removeChild(PS);
			Starling.juggler.remove(PS);
			PS.dispose();
		}
	}
}