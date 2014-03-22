package Component.Block 
{
	import Manager.LoadingManager;
	import Enum.AssetList;
	/**
	 * ...
	 * @author hello
	 */
	public class Block5 extends BaseBlock
	{
		public function Block5() 
		{
			super(LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK5));
			stackLevel = 0;
			playerAction = BaseBlock.ACTION_JUMP;
			PhysicsKey = "block5";
		}
	}

}