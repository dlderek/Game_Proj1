package Control 
{
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import Manager.GameLoopManager;
	import Manager.LoadingManager;
	/**
	 * ...
	 * @author JL
	 */
	public class BaseComponentControl extends Sprite
	{
		public var ui:DisplayObject;
		public function BaseComponentControl(_ui:DisplayObject) 
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