package View 
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import Manager.LoadingManager;
	import Utils.BTool;
	import Utils.ToolKit;
	/**
	 * ...
	 * @author JL
	 */
	public class RecordView extends BaseView
	{
		public var RecordPage:Sprite;
		
		public function RecordView() 
		{
			super();
			InitRecordPage();
			//RecordPage = LoadingManager.getItem(AssetList.UI_RECORDPAGE, AssetList.CLASS_RECORDPAGE) as Object;
		}
		
		private function InitRecordPage():void
		{
			RecordPage = new Sprite();
			
			var sp:Sprite = new Sprite();
			sp.name = "backgroundPoint";
			RecordPage.addChild(sp);
			
			var bm:Image = new Image( BTool.GetImage("RecordPage_element", "frame"));
			RecordPage.addChild(bm);
			
			var btn:Button = new Button(BTool.GetImage("RecordPage_element", "btntheme1"));
			btn.x = 135.4; btn.y = 207.15;
			btn.name = "btn_theme1";
			RecordPage.addChild(btn);
			
			btn = new Button(BTool.GetImage("RecordPage_element", "btntheme2"));
			btn.x = 304.05; btn.y = 207.15;
			btn.name = "btn_theme2";
			RecordPage.addChild(btn);
			
			btn = ToolKit.getDefaultButton("Back", "btn_back", 0, 160, 850, 1.5);
			RecordPage.addChild(btn);
		}
		
	}

}