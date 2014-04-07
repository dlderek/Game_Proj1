package View 
{
	import flash.display.DisplayObject;
	import Manager.LoadingManager;
	import Enum.AssetList;
	/**
	 * ...
	 * @author JL
	 */
	public class GameOverView extends BaseView
	{
		public var GameOverPage:Object;
		
		public function GameOverView() 
		{
			super();
			GameOverPage = LoadingManager.getItem(AssetList.UI_GAMEOVERPAGE, AssetList.CLASS_GAMEOVERPAGE) as Object;
		}
		
	}

}