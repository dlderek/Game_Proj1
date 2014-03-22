package Component.Block 
{
	import Manager.LoadingManager;
	import Enum.AssetList;
	/**
	 * ...
	 * @author hello
	 */
	public class Block4 extends BaseBlock
	{
		public function Block4() 
		{
			super(LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK4));
			stackLevel = 0;
			playerAction = BaseBlock.ACTION_JUMP;
			PhysicsKey = "block4";
		}
		
	}

}