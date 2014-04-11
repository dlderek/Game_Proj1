package View 
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.DisplayObject;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.text.TextField;
	//import flash.text.TextFormat;
	import Manager.LoadingManager;
	import Utils.BTool;
	import Utils.TextTool;
	/**
	 * ...
	 * @author JL
	 */
	public class BattleView extends BaseView
	{
		public var BattlePage:Sprite;
		public var BattlePageMask:Sprite;
		
		public function BattleView() 
		{
			super();
			InitBattlePage();
			InitBattlePageMask();
			//BattlePage = LoadingManager.getItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BATTLEPAGE) as Object;
		}
		
		private function InitBattlePage():void
		{
			BattlePage = new Sprite();
			
			var sp:Sprite = new Sprite();
			sp.name = "backgroundPoint2";
			BattlePage.addChild(sp);
			
			sp = new Sprite();
			sp.name = "backgroundPoint";
			BattlePage.addChild(sp);
			
			sp = new Sprite();
			sp.name = "origin";
			sp.x = 30.05; sp.y = 30.2;
			BattlePage.addChild(sp);
			
			var bm:Image = new Image(BTool.GetImage("BattlePage_element", "roof"));
			bm.x = -25.95; bm.y = -48.8;
			BattlePage.addChild(bm);
			
			var btn:Button = new Button(BTool.GetImage("BattlePage_element", "btnreset"));
			btn.x = 478.15; btn.y = 38.6;
			btn.name = "btn_reset";
			BattlePage.addChild(btn);
			
			btn = new Button(BTool.GetImage("BattlePage_element", "btnback"));
			btn.x = 348.7; btn.y = 53.4;
			btn.name = "btn_back";
			BattlePage.addChild(btn);
			
			bm = new Image(BTool.GetImage("BattlePage_element", "count"));
			bm.x = -1.95; bm.y = 45.9;
			BattlePage.addChild(bm);
			
			var text:TextField = TextTool.DefaultTextfield(167, 41.15);
			//text.width = 167; text.height = 41.15;
			text.x = 113; text.y = 57.9;
			text.name = "score";
			BattlePage.addChild(text);
			
			text = TextTool.DefaultTextfield(99.05, 41.15);
			//text.width = 99.05; text.height = 41.15;
			text.x = 130; text.y = 117.6;
			text.name = "score2";
			BattlePage.addChild(text);
			
		}
		
		private function InitBattlePageMask():void
		{
			BattlePageMask = new Sprite();
			
			var sh:Shape = new Shape();
			sh.graphics.beginFill(0);
			sh.graphics.drawRect(0, 0, 600, 1000);
			sh.graphics.endFill();
			
			BattlePageMask.addChild(sh);
		}
	}
}