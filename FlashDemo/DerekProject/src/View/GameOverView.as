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
			
			btn = new Button(BTool.GetImage("GameOverPage_element", "btnretry"));
			btn.x = 51.85; btn.y = 850.25;
			btn.name = "btn_retry";
			GameOverPage.addChild(btn);
			
			btn = new Button(BTool.GetImage("GameOverPage_element", "btnquit"));
			btn.x = 341.25; btn.y = 849.25;
			btn.name = "btn_quit";
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
			
			var btn:Button = new Button(BTool.GetImage("GameOverPage_element", "btnok"));
			btn.x = 374.95; btn.y = 693.95;
			btn.name = "btn_ok";
			FeedDialog.addChild(btn);
			
			btn = new Button(BTool.GetImage("GameOverPage_element", "btnback"));
			btn.x = 35.95; btn.y = 693.95;
			btn.name = "btn_back";
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