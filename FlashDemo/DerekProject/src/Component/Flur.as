package Component 
{
	import com.greensock.TweenLite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	import idv.cjcat.stardust.common.clocks.SteadyClock;
	import idv.cjcat.stardust.threeD.handlers.DisplayObjectHandler3D;
	import idv.cjcat.stardust.threeD.initializers.DisplayObjectClass3D;
	import Utils.PlayerCollideEvent;
	import Manager.LoadingManager;
	import Enum.AssetList;
	
	public class Flur extends BaseComponent
	{
		
		private var flurEmitter:SakuraEmitter;
		private var handler:DisplayObjectHandler3D;
		private var steadyClock:SteadyClock;
		
		public function Flur(velocityM:Number) 
		{
			super(LoadingManager.getItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_FLUR));
			handler = new DisplayObjectHandler3D(this);
			steadyClock = new SteadyClock(1);
			flurEmitter = new SakuraEmitter(steadyClock, velocityM);
			flurEmitter.particleHandler = handler;
		}
		
		protected override function onStage(e:Event):void
		{
			super.onStage(e);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		protected override function offStage(e:Event):void
		{
			super.offStage(e);
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			steadyClock.ticksPerCall = 0;
			flurEmitter.active = false;
			flurEmitter.clearParticles();
			flurEmitter.clearInitializers();
			flurEmitter.clearActions();
			handler = null;
			flurEmitter = null;
		}
		
		private function onEnterFrame(e:Event):void
		{
			flurEmitter.step();
		}
		
	}

}
import Enum.AssetList;
import flash.display.*;
import idv.cjcat.stardust.threeD.zones.SphereZone;
import Manager.LoadingManager;

import idv.cjcat.stardust.common.actions.Age;
import idv.cjcat.stardust.common.actions.AlphaCurve;
import idv.cjcat.stardust.common.actions.DeathLife;
import idv.cjcat.stardust.common.clocks.Clock;
import idv.cjcat.stardust.common.emitters.Emitter;
import idv.cjcat.stardust.common.initializers.Life;
import idv.cjcat.stardust.common.initializers.Scale;
import idv.cjcat.stardust.common.math.UniformRandom;
import idv.cjcat.stardust.common.particles.Particle;
import idv.cjcat.stardust.threeD.actions.Move3D;
import idv.cjcat.stardust.threeD.actions.StardustSpriteUpdate3D;
import idv.cjcat.stardust.threeD.emitters.Emitter3D;
import idv.cjcat.stardust.threeD.initializers.DisplayObjectClass3D;
import idv.cjcat.stardust.threeD.initializers.Position3D;
import idv.cjcat.stardust.threeD.initializers.Velocity3D;
import idv.cjcat.stardust.threeD.zones.CubeZone;
import idv.cjcat.stardust.twoD.display.StardustSprite;

class SakuraEmitter extends Emitter3D {
    public function SakuraEmitter(clock:Clock, M:Number) {
        super(clock);
        //initializers
        addInitializer(new DisplayObjectClass3D(SakuraPetalWrapper));
        addInitializer(new Life(new UniformRandom(30,1)));
        addInitializer(new Position3D(new SphereZone(0,0,0,M)));
        addInitializer(new Velocity3D(new SphereZone(0,0,0,M)));
        addInitializer(new Scale(new UniformRandom(1.5, 0.2)));
        //actions
        addAction(new Age(1));
        addAction(new Move3D());
        addAction(new DeathLife());
        addAction(new StardustSpriteUpdate3D());
    }
}

class SakuraPetalWrapper extends StardustSprite {
    public function SakuraPetalWrapper() {
        phase = 0;
        petel = LoadingManager.getItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_FLUR);
        innerWrapper = new Sprite();
        innerWrapper.addChild(petel);
        petel.rotation = Math.random() * 360;
        rotation *= Math.random() * 360;
        selfOmega = Math.random() * 10;
        petalOmega = Math.random() * 1;
        scaleXRate = Math.random() * 0.02 + 0.02;
        addChild(innerWrapper);
    }
    private var innerWrapper:Sprite;
    private var petalOmega:Number;
    private var petel:DisplayObject;
    private var phase:Number;
    private var scaleXRate:Number;
    private var selfOmega:Number;
    
    override public function update(emitter:Emitter, particle:Particle, time:Number):void {
        petel.rotation += petalOmega * time;
        rotation += selfOmega * time;
        phase += time;
        innerWrapper.scaleX = Math.sin(scaleXRate * phase);
    }
}