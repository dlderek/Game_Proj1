package View 
{
	import flash.display.DisplayObject;
	import Manager.LoadingManager;
	import Enum.AssetList;
	/**
	 * ...
	 * @author JL
	 */
	public class StageView extends BaseView
	{
		public var StagePage:Object;
		
		public function StageView() 
		{
			super();
			StagePage = LoadingManager.getItem(AssetList.UI_STAGEPAGE, AssetList.CLASS_STAGEPAGE) as Object;
		}
		
	}

}