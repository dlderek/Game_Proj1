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
	/**
	 * ...
	 * @author JL
	 */
	public class GameOverView extends BaseView
	{
		public var GameOverPage:Sprite;
		public var FeedDialog:Sprite;
		
		public function GameOverView() 
		{
			super();
			InitGameOverPage();
			InitFeedDialog();
			//GameOverPage = LoadingManager.getItem(AssetList.UI_GAMEOVERPAGE, AssetList.CLASS_GAMEOVERPAGE) as Object;
			//FeedDialog = LoadingManager.getItem(AssetList.UI_GAMEOVERPAGE, AssetList.CLASS_FEED_DIALOG) as Object;
		}
		
		private function InitGameOverPage():void
		{
			GameOverPage = new Sprite();
			var bm:Image = new Image( BTool.GetImage("GameOverPage_element", "bg"));
			GameOverPage.addChild(bm);
			
			var btn:Button = new Button(BTool.GetImage("GameOverPage_element", "btnfacebook"));
			btn.x = 59.35; btn.y = 582.4;
			btn.name = "btn_facebook";
			GameOverPage.addChild(btn);
			
			btn = ToolKit.getDefaultButton("Retry", "btn_retry", 0, 51.85, 850.25);
			GameOverPage.addChild(btn);
			
			btn = ToolKit.getDefaultButton("Quit", "btn_quit", 0, 341.25, 849.25);
			GameOverPage.addChild(btn);
			
			var text:TextField = TextTool.DefaultTextfield(310.3, 107.95,84);
			text.x = 251.5; text.y = 240.8;
			//text.width = 310.3; text.height = 107.95;
			text.name = "result1";
			GameOverPage.addChild(text);
			
			text = TextTool.DefaultTextfield(310.3, 107.95, 84);
			text.x = 251.5; text.y = 484.2;
			//text.width = 310.3; text.height = 107.95;
			text.name = "result2";
			GameOverPage.addChild(text);
		}
		
		private function InitFeedDialog():void
		{
			FeedDialog = new Sprite();
			
			var bm:Image = new Image( BTool.GetImage("GameOverPage_element", "dialogbg"));
			FeedDialog.addChild(bm);
			
			var btn:Button = ToolKit.getDefaultButton("OK", "btn_ok", 0, 374.95, 693.95);
			FeedDialog.addChild(btn);
			
			btn = ToolKit.getDefaultButton("Back", "btn_back", 0, 35.95, 693.95);
			FeedDialog.addChild(btn);
			
			var text:TextField = TextTool.DefaultTextfield(496.9, 566.05,50);
			text.x = 58.85; text.y = 58.5;
			text.autoSize = "none";
			//text.width = 496.9; text.height = 566.05;
			text.border = true;
			//text.wordWrap = true;
			text.name = "txt_input";
			FeedDialog.addChild(text);
		}
	}

}