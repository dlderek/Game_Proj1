package Component 
{
	import Enum.AssetList;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.setTimeout;
	import Manager.LoadingManager;
	/**
	 * ...
	 * @author hello
	 */
	public class Bird extends BaseComponent
	{
		public function Bird() 
		{
			super(LoadingManager.getItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BIRD));
		}
	}
}

