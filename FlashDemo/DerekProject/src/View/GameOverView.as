package View 
{
	import feathers.controls.TextInput;
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
			
			var btn:Button = new Button(BTool.GetImage("GameOverPage_element", "FB_up"), "", BTool.GetImage("GameOverPage_element", "FB"));
			btn.x = 78.1; btn.y = 692.15;
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
			
			var btn:Button = ToolKit.getDefaultButton("OK", "btn_ok", 0, 348.45, 878.45);
			FeedDialog.addChild(btn);
			
			btn = ToolKit.getDefaultButton("NO", "btn_back", 0, 82.85, 878.45);
			FeedDialog.addChild(btn);
			
			var text:TextInput = TextTool.DefaultTextInput(496.9, 531.8, 30);
			text.x = 72.05; text.y = 317.05;
			//text.autoSize = "none";
			//text.width = 496.9; text.height = 566.05;
			//text.border = true;
			//text.wordWrap = true;
			text.name = "txt_input";
			FeedDialog.addChild(text);
		}
		
	}

}