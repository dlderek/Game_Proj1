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
			super(LoadingManager.getItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK4));
			stackLevel = 0;
			playerAction = BaseBlock.ACTION_JUMP;
			type = BaseBlock.TYPE_wall_L;
			PhysicsKey = "block4";
		}
		
	}

}