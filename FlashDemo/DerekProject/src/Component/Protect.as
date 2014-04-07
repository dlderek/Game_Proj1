package Component 
{
	import Enum.AssetList;
	import flash.display.DisplayObject;
	import Manager.LoadingManager;
	/**
	 * ...
	 * @author JL
	 */
	public class Protect extends BaseComponent
	{
		
		public function Protect() 
		{
			var item:DisplayObject = LoadingManager.getBitmapItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_PROTECT);
			item.x -= item.width / 2;
			item.y -= item.height / 2;
			super(item);
			this.mouseEnabled = false;
		}
		
	}

}