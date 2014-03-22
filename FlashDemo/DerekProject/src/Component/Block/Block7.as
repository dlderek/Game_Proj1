package Component.Block 
{
	import flash.display.DisplayObject;
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
			var img:DisplayObject = LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK7);
			img.x = -img.width;
			super(img);
			stackLevel = 0;
			playerAction = BaseBlock.ACTION_PAUSE;
			PhysicsKey = "block7";
			flip = true;
		}
	}

}