package Component 
{
	import Enum.AssetList;
	import Manager.LoadingManager;
	/**
	 * ...
	 * @author JL
	 */
	public class Arrow extends BaseComponent
	{
		
		public function Arrow() 
		{
			super(LoadingManager.getItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_ARROW));
			this.mouseEnabled = false;
		}
		
	}

}