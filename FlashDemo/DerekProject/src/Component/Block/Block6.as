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
			super(LoadingManager.getItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK6));
			stackLevel = 0;
			playerAction = BaseBlock.ACTION_JUMP;
			type = BaseBlock.TYPE_wall_R;
			PhysicsKey = "block6";
		}
		
	}

}