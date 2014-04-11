package Control 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author JL
	 */
	public class AnimationPlayer extends BaseComponentControl
	{
		public function get canvas():Sprite{return ui as Sprite};
		public var AnimationPackage:Vector.<Image>;
		public var fps:int;
		public var loop:Boolean;
		public var pivot:Point;
		public var ClearMemoryAfterRemoved:Boolean;
		
		private var AnimationHandler:uint;
		private var currentFrame:Image;
		private var stopped:Boolean;
		private var currentFrameId:int = 0;
		private var alignToCenter:Boolean;
		
		public function AnimationPlayer(canvas:Sprite, AnimationPackage:Vector.<Texture>, fps:int, loop:Boolean, alignToCenter:Boolean = true, pivot:Point = null, ClearMemoryAfterRemoved:Boolean = true) 
		{
			super(canvas);
			this.AnimationPackage = new Vector.<Image>();
			for (var i:int = 0 ; i < AnimationPackage.length; i++)
				this.AnimationPackage.push(new Image(AnimationPackage[i]));
			this.fps = fps;
			this.loop = loop;
			this.alignToCenter = alignToCenter;
			this.pivot = pivot?pivot:new Point(0, 0);
			this.ClearMemoryAfterRemoved = ClearMemoryAfterRemoved;
		}
		
		protected override function onStage(e:Event):void
		{
			super.onStage(e);
			AnimationHandler = setInterval(update, 1000/fps);
		}
		
		protected override function offStage(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			if(!ClearMemoryAfterRemoved)
				ui.addEventListener(Event.ADDED_TO_STAGE, onStage);
			clearInterval(AnimationHandler);
		}
		
		private function update():void
		{
			if (stopped)
				return;
				
			var newFrame:Image = AnimationPackage[currentFrameId];
				
			if (alignToCenter)
			{
				newFrame.x = -newFrame.width / 2;
				newFrame.y = -newFrame.height / 2;
			}
			else
			{
				newFrame.x = pivot.x;
				newFrame.y = pivot.y;
			}
			
			canvas.addChild(newFrame);
			if (currentFrame && currentFrame.parent)
				currentFrame.parent.removeChild(currentFrame);
			currentFrame = newFrame;
			currentFrameId++;
			if (currentFrameId >= AnimationPackage.length)
			{
				currentFrameId = 0;
				stopped = !loop;
				canvas.dispatchEvent(new Event("AnimationComplete"));
			}
		}
		
		public function stop():void
		{
			stopped = true;
			if (currentFrame && currentFrame.parent)
				currentFrame.parent.removeChild(currentFrame);
		}
		
		public function gotoAndPlay(id:int):void
		{
			stopped = false;
			currentFrameId = id;
		}
		
		public function play():void
		{
			stopped = false;
		}
	}
}