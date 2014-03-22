package Component.Block 
{
	import Manager.LoadingManager;
	import Enum.AssetList;
	/**
	 * ...
	 * @author hello
	 */
	public class Block6 extends BaseBlock
	{
		public function Block6() 
		{
			super(LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK6));
			stackLevel = 0;
			playerAction = BaseBlock.ACTION_PAUSE;
			PhysicsKey = "block6";
		}
		
	}

}