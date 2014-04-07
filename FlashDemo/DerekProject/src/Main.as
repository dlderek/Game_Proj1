package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import Manager.GameLoopManager;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author JL
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			stage.quality = "high"
			new GameLoopManager(stage);
		}
		
	}
	
}