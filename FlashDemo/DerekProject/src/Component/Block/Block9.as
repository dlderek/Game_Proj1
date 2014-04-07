package Component.Block 
{
	import Manager.LoadingManager;
	import Enum.AssetList;
	/**
	 * ...
	 * @author hello
	 */
	public class Block9 extends BaseBlock
	{
		public function Block9() 
		{
			super(LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK9));
			stackLevel = 0;
			playerAction = BaseBlock.ACTION_SLIDE;
			PhysicsKey = "block9";
		}
	}

}