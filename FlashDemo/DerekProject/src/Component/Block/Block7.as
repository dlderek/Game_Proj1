package Component.Block 
{
	import Manager.LoadingManager;
	import Enum.AssetList;
	/**
	 * ...
	 * @author hello
	 */
	public class Block7 extends BaseBlock
	{
		public function Block7() 
		{
			super(LoadingManager.getItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK7));
			stackLevel = 0;
			type = BaseBlock.TYPE_wall_R;
			playerAction = BaseBlock.ACTION_PAUSE;
			PhysicsKey = "block7";
		}
	}

}