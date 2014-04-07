package Component.Block 
{
	import Manager.LoadingManager;
	import Enum.AssetList;
	/**
	 * ...
	 * @author hello
	 */
	public class Block14 extends BaseBlock
	{
		public function Block14() 
		{
			super(LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK14));
			stackLevel = 4;
			playerAction = BaseBlock.ACTION_FALL_AND_STACK;
			PhysicsKey = "block14";
		}
	}

}