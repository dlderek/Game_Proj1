package Component.Block 
{
	import Manager.LoadingManager;
	import Enum.AssetList;
	/**
	 * ...
	 * @author hello
	 */
	public class Block10 extends BaseBlock
	{
		public function Block10() 
		{
			super(LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK10));
			stackLevel = 2;
			playerAction = BaseBlock.ACTION_STACK;
			PhysicsKey = "block10";
		}
	}

}