package Component.Block 
{
	import Manager.LoadingManager;
	import Enum.AssetList;
	/**
	 * ...
	 * @author hello
	 */
	public class Block15 extends BaseBlock
	{
		public function Block15() 
		{
			super(LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK15));
			stackLevel = 5;
			playerAction = BaseBlock.ACTION_FALL_AND_STACK;
			PhysicsKey = "block15";
		}
	}

}