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
		
		public function BattleView() 
		{
			super();
			InitBattlePage();
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
			
			sp = new Sprite();
			sp.x = -25.95;
			sp.y = -48.8;
			sp.name = "roof";
			BattlePage.addChild(sp);
			
			var bm:Image = new Image(BTool.GetImage("BattlePage_element", "btnback"));
			bm.scaleX = 3 / 4; bm.scaleY = 3 / 4;
			bm.x = 400.25; bm.y = 41.45;
			BattlePage.addChild(bm);
			
			var btn:Button = new Button(BTool.GetImage("BattlePage_element", "restart_up"), "", BTool.GetImage("BattlePage_element", "restart"));
			btn.scaleX = 3 / 4; btn.scaleY = 3 / 4;
			btn.x = 445.5; btn.y = 62.2;
			btn.name = "btn_reset";
			BattlePage.addChild(btn);
			
			btn = new Button(BTool.GetImage("BattlePage_element", "exit_up"), "", BTool.GetImage("BattlePage_element", "exit"));
			btn.scaleX = 3 / 4; btn.scaleY = 3 / 4;
			btn.x = 506.25; btn.y = 62.2;
			btn.name = "btn_back";
			BattlePage.addChild(btn);
			
			bm = new Image(BTool.GetImage("BattlePage_element", "statsback"));
			bm.scaleX = 3 / 4; bm.scaleY = 3 / 4;
			bm.x = 27.9; bm.y = 62.45;
			BattlePage.addChild(bm);
			
			var text:TextField = TextTool.DefaultTextfield(167, 80, 25, 0xFFFFFF);
			//text.width = 167; text.height = 41.15;
			text.x = 50; text.y = 95;
			text.name = "score";
			BattlePage.addChild(text);
			
			text = TextTool.DefaultTextfield(99.05, 80, 25, 0xFFFFFF);
			//text.width = 99.05; text.height = 41.15;
			text.x = 70; text.y = 145;
			text.name = "score2";
			BattlePage.addChild(text);
			
			var sh:Shape = new Shape();
			sh.graphics.beginFill(0);
			sh.graphics.drawRect(0,0,30,1000);
			sh.graphics.drawRect(570,0,30,1000);
			sh.graphics.drawRect(0,0,600,30);
			sh.graphics.endFill();
			BattlePage.addChild(sh);
		}
	}
}