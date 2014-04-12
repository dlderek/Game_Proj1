package Component 
{
	import com.greensock.TweenLite;
	import Manager.GameLoopManager;
	import starling.display.Image;
	import starling.extensions.pixelmask.PixelMaskDisplayObject;
	import starling.textures.Texture;
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.utils.setTimeout;
	import Manager.LoadingManager;
	import Utils.B2PlayerUnStackedEvent;
	import Utils.B2PlayerUnStackEvent;
	import Utils.BTool;
	/**
	 * ...
	 * @author hello
	 */
	public class UnStackMe extends BaseComponent
	{
		private static var upbmd:Texture;
		private static var bgbmd:Texture;
		private static var mbmd:Texture;
		
		private var ui:Sprite;
		private var up:Image;
		private var down:Image;
		//private var m:Image;
		private var stackLevel:int;
		private var currentStackLevel:int;
		
		public function UnStackMe() 
		{
			if (!upbmd)
				upbmd = BTool.GetImage("BattlePage_element", "colorarrow");
			if (!bgbmd)
				bgbmd = BTool.GetImage("BattlePage_element", "arrowbg");
			if (!mbmd)
				mbmd = BTool.GetImage("BattlePage_element", "colorbox");
			//stackLevel = _stackLevel;
			//currentStackLevel = 0;
			ui = new Sprite();
			super(ui);
			
			up = new Image(upbmd);
			up.x = -100; up.y = -31.65;
			down = new Image(bgbmd);
			down.x = -101.5; down.y = -33.15;
			//m = new Image(mbmd);
			//m.y = -45.15;
			
			ui.addChild(down);
			ui.addChild(up);
			//ui.addChild(m);
			
			//var maskedDisplayObject:PixelMaskDisplayObject = new PixelMaskDisplayObject( -1, false);
			//maskedDisplayObject.addChild(up);
			//maskedDisplayObject.mask = m;
			//up.mask = m;
		}
		
		public function set StackLevel(v:int):void 
		{ 
			stackLevel = v;
			currentStackLevel = 0;
			refreshDisplay();
			ui.alpha = 1;
		}
		
		protected override function onStage(e:Event):void
		{
			super.onStage(e);
			GameLoopManager.Core.stage.addEventListener("B2PlayerUnStack", onPlayerUnStack);
			GameLoopManager.Core.stage.addEventListener("B2PlayerUnStacked", onPlayerUnStacked);
			refreshDisplay();
		}
		
		protected override function offStage(e:Event):void
		{
			super.offStage(e);
			GameLoopManager.Core.stage.removeEventListener("B2PlayerUnStack", onPlayerUnStack);
			GameLoopManager.Core.stage.removeEventListener("B2PlayerUnStacked", onPlayerUnStacked);
		}
		
		private function onPlayerUnStack(e:B2PlayerUnStackEvent):void
		{
			currentStackLevel ++;
			refreshDisplay();
		}
		
		private function onPlayerUnStacked(e:B2PlayerUnStackedEvent):void
		{
			TweenLite.to(ui, 1, { alpha:0 } );
		}
		
		private function refreshDisplay():void
		{
			up.alpha = currentStackLevel / stackLevel;
			//up.setVertexAlpha(0, currentStackLevel / stackLevel);
			//up.setVertexAlpha(2, currentStackLevel / stackLevel);
			//m.x = -100 * currentStackLevel / stackLevel;
		}
	}
}