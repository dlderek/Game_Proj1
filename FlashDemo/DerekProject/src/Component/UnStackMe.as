package Component 
{
	import com.greensock.TweenLite;
	import Enum.AssetList;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	import Manager.LoadingManager;
	import Utils.B2PlayerUnStackedEvent;
	import Utils.B2PlayerUnStackEvent;
	/**
	 * ...
	 * @author hello
	 */
	public class UnStackMe extends BaseComponent
	{
		private var ui:Sprite;
		private var stackLevel:int;
		private var currentStackLevel:int;
		
		public function UnStackMe(_stackLevel:int) 
		{
			stackLevel = _stackLevel;
			currentStackLevel = 0;
			ui = LoadingManager.getItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_UNSTACKME) as Sprite;
			super(ui);
		}
		
		protected override function onStage(e:Event):void
		{
			super.onStage(e);
			stage.addEventListener("B2PlayerUnStack", onPlayerUnStack);
			stage.addEventListener("B2PlayerUnStacked", onPlayerUnStacked);
		}
		
		protected override function offStage(e:Event):void
		{
			super.offStage(e);
			stage.removeEventListener("B2PlayerUnStack", onPlayerUnStack);
			stage.removeEventListener("B2PlayerUnStacked", onPlayerUnStacked);
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
			ui["block"].x = -100 * currentStackLevel / stackLevel;
		}
	}
}