package Component.Block 
{
	import Manager.LoadingManager;
	import Enum.AssetList;
	/**
	 * ...
	 * @author hello
	 */
	public class Block2 extends BaseBlock
	{
		public function Block2() 
		{
			super(LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK2));
			stackLevel = 2;
			playerAction = BaseBlock.ACTION_STACK;
			PhysicsKey = "block2";
		}
		
	}

}