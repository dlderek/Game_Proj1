package Component.Block 
{
	import Manager.LoadingManager;
	import Enum.AssetList;
	/**
	 * ...
	 * @author hello
	 */
	public class Block13 extends BaseBlock
	{
		public function Block13() 
		{
			super(LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK13));
			stackLevel = 3;
			playerAction = BaseBlock.ACTION_FALL_AND_STACK;
			PhysicsKey = "block13";
		}
	}

}