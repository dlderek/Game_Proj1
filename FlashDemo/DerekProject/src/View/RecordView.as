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
			
			var bm:Image = new Image(BTool.GetImage("RecordPage_element", "bg"));
			bm.width = 600;
			bm.height = 1000;
			RecordPage.addChild(bm);
			
			var sp:Sprite = new Sprite();
			sp.x = 31.3;
			sp.y = 39.1;
			sp.name = "ImagePoint";
			RecordPage.addChild(sp);
			
			var btn:Button = new Button(BTool.GetImage("RecordPage_element", "arrowbtn_up"), "", BTool.GetImage("RecordPage_element", "arrowbtn"));
			btn.x = 31.3; btn.y = 894;
			btn.name = "btn_previous";
			RecordPage.addChild(btn);
			
			btn = new Button(BTool.GetImage("RecordPage_element", "arrowbtn_up"), "", BTool.GetImage("RecordPage_element", "arrowbtn"));
			btn.scaleX = -1;
			btn.x = 387.3 + btn.width; btn.y = 894;
			btn.name = "btn_next";
			RecordPage.addChild(btn);
			
			btn = new Button(BTool.GetImage("RecordPage_element", "backbtn_up"), "", BTool.GetImage("RecordPage_element", "backbtn"));
			btn.x = 240.2; btn.y = 894;
			btn.name = "btn_back";
			RecordPage.addChild(btn);
		}
		
	}

}