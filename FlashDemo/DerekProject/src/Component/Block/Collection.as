package Component.Block 
{
	import Component.BaseComponent;
	import Enum.AssetList;
	import flash.display.MovieClip;
	import Manager.LoadingManager;
	/**
	 * ...
	 * @author JL
	 */
	public class Collection extends BaseBlock
	{
		
		public function Collection() 
		{
			super(LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_COLLECTION) );
			playerAction = BaseBlock.ACTION_GET;
			PhysicsKey = "collection";
		}
		
	}

}