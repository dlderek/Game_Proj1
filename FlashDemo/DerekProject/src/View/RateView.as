package View 
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.text.TextField;
	import Manager.LoadingManager;
	import Utils.BTool;
	import Utils.TextTool;
	import Utils.ToolKit;
	
	public class RateView extends BaseView
	{
		public var RatePage:Sprite;
		
		public function RateView() 
		{
			super();
			InitRatePage();
		}
		
		private function InitRatePage():void
		{
			RatePage = new Sprite();
			
			var sp:Sprite = new Sprite();
			sp.name = "backgroundPoint"
			RatePage.addChild(sp);
			
			sp = new Sprite();
			sp.name = "ratePoint";
			sp.x = 75; sp.y = 170;
			RatePage.addChild(sp);
			
			var bm:Image = new Image(BTool.GetImage("RatePage_element", "bg"));
			RatePage.addChild(bm);
			
			var btn:Button = new Button(BTool.GetImage("RatePage_element", "theme1"));
			btn.x = 84.25;
			btn.y = 785.2;
			btn.name = "btn_theme1";
			RatePage.addChild(btn);
			
			btn = new Button(BTool.GetImage("RatePage_element", "theme2"));
			btn.x = 222.75; btn.y = 785.2;
			btn.name = "btn_theme2";
			RatePage.addChild(btn);
			
			btn = ToolKit.getDefaultButton("Back", "btn_back", 0, 160, 850, 1.5);
			RatePage.addChild(btn);
		}
	}

}