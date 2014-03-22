package Component.Block 
{
	import Manager.LoadingManager;
	import Enum.AssetList;
	/**
	 * ...
	 * @author hello
	 */
	public class Block3 extends BaseBlock
	{
		public function Block3() 
		{
			super(LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK3));
			playerAction = BaseBlock.ACTION_SLIDE;
			PhysicsKey = "block3";
		}
		
	}

}