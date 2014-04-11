package Component 
{
	import starling.display.Image;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer
	import starling.display.Sprite;
	import starling.events.Event;
	/**
	 * ...
	 * @author JL
	 */
	public class BaseComponent extends Sprite
	{
		public function BaseComponent(_ui:DisplayObject) 
		{
			_ui.touchable = false;
			this.addChild(_ui);
			this.addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		protected function onStage(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			this.addEventListener(Event.REMOVED_FROM_STAGE, offStage);
		}
		
		protected function offStage(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			this.addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
	}

}