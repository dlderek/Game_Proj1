package View 
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import Manager.LoadingManager;
	import Utils.BTool;
	/**
	 * ...
	 * @author JL
	 */
	public class SettingView extends BaseView
	{
		public var SettingPage:Sprite;
		
		public function SettingView() 
		{
			super();
			InitSettingPage();
			//SettingPage = LoadingManager.getItem(AssetList.UI_SETTINGPAGE, AssetList.CLASS_SETTINGPAGE) as Object;
		}
		
		private function InitSettingPage():void
		{
			SettingPage = new Sprite();
			var bm:Image = new Image( BTool.GetImage("SettingPage_element", "bg"));
			SettingPage.addChild(bm);
			
			var btn:Button = new Button(BTool.GetImage("SettingPage_element", "btnback"));
			btn.x = 104.05; btn.y = 852.4;
			btn.name = "btn_back";
			SettingPage.addChild(btn);
			
			btn = new Button(BTool.GetImage("SettingPage_element", "btnset1"));
			btn.x = 86.65; btn.y = 206.55;
			btn.name = "btn_set1";
			SettingPage.addChild(btn);
			
			btn = new Button(BTool.GetImage("SettingPage_element", "btnset2"));
			btn.x = 87.65; btn.y = 485.9;
			btn.name = "btn_set2";
			SettingPage.addChild(btn);
		}
		
	}

}