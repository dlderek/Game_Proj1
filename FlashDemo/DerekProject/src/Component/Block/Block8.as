package Component.Block 
{
	import Manager.LoadingManager;
	import Enum.AssetList;
	/**
	 * ...
	 * @author hello
	 */
	public class Block8 extends BaseBlock
	{
		public function Block8() 
		{
			super(LoadingManager.getItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK8));
			stackLevel = 0;
			type = BaseBlock.TYPE_free;
			playerAction = BaseBlock.ACTION_NONE;
			PhysicsKey = "block8";
		}
	}

}