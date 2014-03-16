package Control 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import Manager.GameLoopManager;
	import Manager.LoadingManager;
	/**
	 * ...
	 * @author JL
	 */
	public class BaseComponentControl extends Sprite
	{
		public var ui:Object;
		public function BaseComponentControl(_ui:Object) 
		{
			ui = _ui;
			ui.addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		protected function onStage(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			ui.addEventListener(Event.REMOVED_FROM_STAGE, offStage);
		}
		
		protected function offStage(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			ui.addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
	}

}