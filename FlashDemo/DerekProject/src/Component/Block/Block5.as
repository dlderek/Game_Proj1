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
			super(LoadingManager.getItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK5));
			stackLevel = 0;
			type = BaseBlock.TYPE_wall_L;
			playerAction = BaseBlock.ACTION_PAUSE;
			PhysicsKey = "block5";
		}
	}

}