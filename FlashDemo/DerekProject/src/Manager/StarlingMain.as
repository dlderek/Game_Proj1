package Manager
{
	import flash.display.Bitmap;
	import flash.display.LoaderInfo;
	import starling.display.DisplayObject;
	import flash.display.Loader;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import flash.net.URLRequest;
	import Manager.GameLoopManager;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import starling.textures.Texture;
	
	
	
	/**
	 * ...
	 * @author JL
	 */
	public class StarlingMain extends Sprite 
	{
		public function StarlingMain():void 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			this.removeEventListener(e.type, arguments.callee);
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			new GameLoopManager(this);
		}
		
		
	}
}