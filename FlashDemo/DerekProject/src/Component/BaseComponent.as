package Component 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author JL
	 */
	public class BaseComponent extends MovieClip
	{
		
		public function BaseComponent(_ui:Object) 
		{
			if (_ui is InteractiveObject)
			{
				_ui.mouseEnabled = false;
				_ui.mouseChildren = false;
			}
			this.addChild(_ui as DisplayObject);
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