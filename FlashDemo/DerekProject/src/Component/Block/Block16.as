package Component.Block 
{
	import Manager.LoadingManager;
	import Enum.AssetList;
	/**
	 * ...
	 * @author hello
	 */
	public class Block16 extends BaseBlock
	{
		public function Block16() 
		{
			super(LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK16));
			stackLevel = 1;
			playerAction = BaseBlock.ACTION_JUMP;
			PhysicsKey = "block16";
		}
	}

}