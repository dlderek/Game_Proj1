package View 
{
	import flash.display.DisplayObject;
	import Enum.AssetList;
	import Manager.LoadingManager;
	/**
	 * ...
	 * @author JL
	 */
	public class BattleView extends BaseView
	{
		public var BattlePage:Object;
		
		public function BattleView() 
		{
			super();
			BattlePage = LoadingManager.getItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BATTLEPAGE) as Object;
		}
	}

}