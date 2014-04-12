package Handler 
{
	import com.adobe.images.PNGEncoder;
	import flash.display.BitmapData;
	import starling.core.RenderSupport;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	//import flash.display.InteractiveObject;
	import starling.display.Button;
	//import flash.display.SimpleButton;
	import starling.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import starling.text.TextField;
	//import flash.text.TextField;
	import flash.utils.ByteArray;
	import Manager.GameLoopManager;
	import Enum.CmdList;
	import Enum.LayerList;
	import Manager.GameStateManager;
	import Manager.SoundManager;
	import Utils.JPEGEncoder;
	import Utils.JPEGEncoder;
	import Utils.BTool;
	import Utils.ToolKit;
	import View.GameOverView;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	//import flash.events.MouseEvent;
	import com.facebook.graph.FacebookMobile;
	import flash.media.StageWebView;
	/**
	 * ...
	 * @author JL
	 */
	public class GameOverHandler extends BaseHandler
	{
		private var view:GameOverView;
		private var GameOverPage:Sprite;
		private var FeedDialog:Sprite;
		
		
		//private static const APP_Secret:String = '5e294dbc4fc9568873046c4b9fb6621c';
		
		public function GameOverHandler(GameMain:GameLoopManager) 
		{
			super(GameMain);
			TaskList[CmdList.CMD_INIT_HANDLER] = true;
			TaskList[CmdList.CMD_HIDE_GAMEOVER_PAGE] = true;
			TaskList[CmdList.CMD_SHOW_GAMEOVER_PAGE] = true;
			TaskList[CmdList.CMD_SHOW_FEED_DIALOG] = true;
			TaskList[CmdList.CMD_HIDE_FEED_DIALOG] = true;
		}
		
		public override function process(task:Object):void
		{
			if (task.cmd == CmdList.CMD_INIT_HANDLER)
			{
				Init();
				return;
			}
			switch(task.cmd)
			{
				case CmdList.CMD_SHOW_GAMEOVER_PAGE:
					ShowUp();
					break;
				case CmdList.CMD_HIDE_GAMEOVER_PAGE:
					HideOut();
					break;
				case CmdList.CMD_SHOW_FEED_DIALOG:
					ShowFeedDialog();
					break;
				case CmdList.CMD_HIDE_FEED_DIALOG:
					HideFeedDialog();
					break;
			}
		}
		
		private function Init():void
		{
			view = new GameOverView();
			GameOverPage = view.GameOverPage;
			FeedDialog = view.FeedDialog;
		}
		
		private function ShowUp():void
		{
			GameStateManager.CurrentPage = "GameOver";
			addChildAt(GameOverPage, LayerList.UI);
			addEvent(true);
			
			(GameOverPage.getChildByName("result1") as TextField).text = GameStateManager.CurrentScore.toString().concat("M");
			(GameOverPage.getChildByName("result2") as TextField).text = GameStateManager.CurrentCollection.toString();
			(GameOverPage.getChildByName("btn_facebook") as Button).touchable = true;
			
			SoundManager.PlayBGM("bgover");
		}
		
		private function HideOut():void
		{
			removeChild(GameOverPage);
			addEvent(false);
		}
		
		private function addEvent(value:Boolean):void
		{
			if (value)
			{
				GameMain.stage.addEventListener(TouchEvent.TOUCH, onTouch);
			}
			else
			{
				GameMain.stage.removeEventListener(TouchEvent.TOUCH, onTouch);
			}
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(GameMain.stage); 
			if (!touch)
				return;
			if (touch.phase != TouchPhase.ENDED)
				return;
			try{
				if (!((e.target as DisplayObject).parent.parent is Button))
					return;
			}catch(e:Error){return}
			var Target:String = ((e.target as DisplayObject).parent.parent as Button).name;
			switch(Target)
			{
				case "btn_retry":
					Retry();
					SoundManager.PlaySound("ok");
					break;
				case "btn_quit":
					Quit();
					SoundManager.PlaySound("back");
					break;
				case "btn_facebook":
					FacebookAction();
					SoundManager.PlaySound("ok");
					break;
				case "btn_ok":
					AddFeed();
					SoundManager.PlaySound("ok");
					break;
				case "btn_back":
					addTask( { cmd:CmdList.CMD_HIDE_FEED_DIALOG } );
					SoundManager.PlaySound("back");
					break;
			}
		}
		
		private function Retry():void
		{
			addTask( { cmd:CmdList.CMD_SWICH_PAGE, page:"Battle" } );
		}
		
		private function Quit():void
		{
			addTask( { cmd:CmdList.CMD_HIDE_FEED_DIALOG } );
			addTask( { cmd:CmdList.CMD_SWICH_PAGE, page:"Stage" } );
		}
		
		
		//{ Facebook
		
		private function FacebookAction():void
		{
			trace("Facebook");
			FacebookMobile.init(ToolKit.APP_ID, onFacebookInit, null );
		}
		
		private function onFacebookInit(response:Object, fail:Object):void
		{
			trace("onFacebookInit", response, fail);
			if (response)
				addTask({cmd:CmdList.CMD_SHOW_FEED_DIALOG});
            else
                loginUser();
		}
		
		private function loginUser():void 
		{
			var FacebookView:StageWebView
			FacebookView = new StageWebView();
			FacebookView.stage = Main.fstage;
			FacebookView.viewPort = new Rectangle(0,0,600, 1000);
            FacebookMobile.login(loginHandler, Main.fstage, ["publish_actions"], FacebookView);
        }
		
		private function loginHandler(result:Object, fail:Object):void
		{
		  if (result)
		  {
			addTask({cmd:CmdList.CMD_SHOW_FEED_DIALOG});
		  }else {
			trace("Login Fail");
		  }
		}
		
		private function AddFeed():void
		{
			addTask( { cmd:CmdList.CMD_HIDE_FEED_DIALOG } );
			
			var bmd:BitmapData = GameLoopManager.Core.stage.stage.drawToBitmapData();
			var encoder:JPEGEncoder = new JPEGEncoder(75);
			var bytes:ByteArray = encoder.encode(bmd);
			
			
			FacebookMobile.api("/me/scores", onPostScore);
			
			
			var params:Object = {
				image:bytes,
				fileName: "MyResult.jpg",
				message: (FeedDialog.getChildByName("txt_input") as TextField).text
			};
			FacebookMobile.api("/me/photos", onFeedComplete, params);
			(GameOverPage.getChildByName("btn_facebook") as Button).touchable = false;
		}
		
		private function onPostScore(response:Object, fail:Object):void
		{
			if (response)
			{
				var highestScore:Number = response[0].score;
				var score:int = GameStateManager.CurrentScore + GameStateManager.CurrentCollection * 5;
				if (highestScore >= score)
					return;
					
				var params:Object = {   
					score:score
				};
				FacebookMobile.postData("/me/scores", onFeedComplete, params);
			}
			else
			{
				
			}
		}
		
		private function onFeedComplete( response:Object, fail:Object ):void 
		{
			trace("onFeedComplete");
			if (response)
			{
				trace("onFeedComplete Success");
			}
			else
			{
				trace("onFeedComplete Fail");
			}
		}
		
		
		private function ShowFeedDialog():void
		{
			addChildAt(FeedDialog, LayerList.Popup);
			(FeedDialog.getChildByName("txt_input") as TextField).text = 
			"I get " + GameStateManager.CurrentScore + "M in panda roll. Play together and challenge my record!";
			//GameMain.stage.focus = FeedDialog.getChildByName("txt_input") as InteractiveObject;
		}
		
		private function HideFeedDialog():void
		{
			removeChild(FeedDialog);
		}
		
		//}
	}
}