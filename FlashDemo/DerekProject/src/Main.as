package 
{
	import flash.display.Bitmap;
	import flash.display.LoaderInfo;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import Manager.GameLoopManager;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import Manager.SoundManager;
	import Manager.StarlingMain;
	import starling.core.Starling;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import flash.system.Capabilities;
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author JL
	 */
	
	[SWF(width="600", height="1000", frameRate="60", backgroundColor="#000000")]
	public class Main extends Sprite 
	{
		
		private var intilStarling:Starling;
		public static var fstage:Stage;
		private var loader:Loader = new Loader();
		private static var loadingImage:Bitmap;
		
		public static var onDevice:Boolean = true;
		
		public function Main():void 
		{
			if (Capabilities.version.indexOf("WIN")>-1)
				onDevice = false;
				
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			fstage = stage;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoader);
			loader.load(new URLRequest("atlas/home.png"));
			fstage.addEventListener(Event.ACTIVATE, onAppActivated);
            fstage.addEventListener(Event.DEACTIVATE, onAppDeactivated);
		}
		
		private function onLoader(e:Event):void
		{
			loadingImage = (e.target as LoaderInfo).content as Bitmap;
			loadingImage.alpha = 0;
			stage.addChild(loadingImage);
			TweenLite.to(loadingImage, 0.5, {alpha:1, onComplete:StarlingSetup});
			e.target.removeEventListener(e.type, arguments.callee);
		}
		
		private function StarlingSetup():void
		{
			if(onDevice)
				Starling.handleLostContext = true;
			intilStarling = new Starling(StarlingMain, stage);
			//intilStarling.showStats = true;
			intilStarling.antiAliasing = 1;
			intilStarling.start();

			if (onDevice)
			{
				stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
				loadingImage.width = Capabilities.screenResolutionX;
				loadingImage.height = Capabilities.screenResolutionY;
				var viewPortRectangle:Rectangle = new Rectangle();
				viewPortRectangle.width = Capabilities.screenResolutionX;
				viewPortRectangle.height = Capabilities.screenResolutionY;
				Starling.current.viewPort = viewPortRectangle;
			}
		}
		
		public static function removeLoadingImage():void
		{
			TweenLite.killTweensOf(loadingImage);
			TweenLite.to(loadingImage, 2, { alpha:0, onComplete:function():void
			{
				if (loadingImage.parent)
					loadingImage.parent.removeChild(loadingImage);
			}})
		}
		
		private function onAppActivated(e:Event):void
		{
			SoundManager.ResumeBGM();
		}
		
		private function onAppDeactivated(e:Event):void
		{
			SoundManager.PauseBGM();
		}
	}
}