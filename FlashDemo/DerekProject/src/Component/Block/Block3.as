package Component.Block 
{
	import Manager.LoadingManager;
	import Enum.AssetList;
	/**
	 * ...
	 * @author hello
	 */
	public class Block3 extends BaseBlock
	{
		public function Block3() 
		{
			stackLevel = 2;
			super(LoadingManager.getItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK3));
			PhysicsKey = "block3";
		}
		
	}

}