package Component.Block 
{
	import Enum.AssetList;
	import Manager.LoadingManager;
	/**
	 * ...
	 * @author JL
	 */
	public class protect extends BaseBlock
	{
		
		public function protect() 
		{
			super(LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_PROTECT) );
			playerAction = BaseBlock.ACTION_PROTECT;
			PhysicsKey = "protect";
		}
		
	}

}