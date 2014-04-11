package View 
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.DisplayObject;
	import starling.display.Shape;
	import starling.display.Sprite;
	import Manager.LoadingManager;
	import Utils.BTool;
	/**
	 * ...
	 * @author JL
	 */
	public class StageView extends BaseView
	{
		public var StagePage:Sprite;
		
		public function StageView() 
		{
			super();
			InitStagePage();
			//StagePage = LoadingManager.getItem(AssetList.UI_STAGEPAGE, AssetList.CLASS_STAGEPAGE) as Sprite;
		}
		
		private function InitStagePage():void
		{
			StagePage = new Sprite();
			
			var sp:Sprite = new Sprite();
			sp.name = "background";
			StagePage.addChild(sp);
			
			var bm:Image 
			//bm = BTool.GetImage("StagePage_element", "logo");
			//bm.x = 33;
			//bm.y = 348.6;
			//StagePage.addChild(bm);
			
			var sh:Shape = new Shape();
			sh.graphics.beginFill(0, 0.5);
			sh.graphics.drawRect(0, 701.8, 600, 298.2);
			sh.graphics.endFill();
			StagePage.addChild(sh);
			
			var btn:Button;
			btn = new Button(BTool.GetImage("StagePage_element", "btnstage1"));
			btn.x = 30.5; btn.y = -251.15;
			btn.name = "btn_stage1"
			StagePage.addChild(btn);
			
			btn = new Button(BTool.GetImage("StagePage_element", "btnstage2"));
			btn.x = 231.4; btn.y = -506.1;
			btn.name = "btn_stage2";
			StagePage.addChild(btn);
			
			btn = new Button(BTool.GetImage("StagePage_element", "btnstage3"));
			btn.x = 445.35; btn.y = -506.1;
			btn.name = "btn_stage3";
			StagePage.addChild(btn);
			
			sp = new Sprite();
			sp.name = "characterPoint";
			StagePage.addChild(sp);
			
			btn = new Button(BTool.GetImage("StagePage_element", "btncontrolsetting"));
			btn.x = 30.5; btn.y = 718;
			btn.name = "btn_config";
			StagePage.addChild(btn);
			
			btn = new Button(BTool.GetImage("StagePage_element", "btnrecord"));
			btn.x = 284.35; btn.y = 679.1;
			btn.name = "btn_record";
			StagePage.addChild(btn);
			
			btn = new Button(BTool.GetImage("StagePage_element", "btnexit"));
			btn.x = 33.5; btn.y = 862.05;
			btn.name = "btn_exit";
			StagePage.addChild(btn);
			
			btn = new Button(BTool.GetImage("StagePage_element", "btnstart"));
			btn.x = 331.35; btn.y = 843.3;
			btn.name = "btn_play";
			StagePage.addChild(btn);
		}
	}
}