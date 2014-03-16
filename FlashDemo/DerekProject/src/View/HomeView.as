package View 
{
	import flash.display.DisplayObject;
	import Manager.LoadingManager;
	import Enum.AssetList;
	/**
	 * ...
	 * @author JL
	 */
	public class HomeView extends BaseView
	{
		public var HomePage:Object;
		
		public function HomeView() 
		{
			super();
			HomePage = LoadingManager.getItem(AssetList.UI_HOMEPAGE, AssetList.CLASS_HOMEPAGE) as Object;
		}
		
	}

}