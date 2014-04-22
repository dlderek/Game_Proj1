package Handler 
{
	import com.adobe.images.PNGEncoder;
	import feathers.controls.TextInput;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.utils.setTimeout;
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
		
		public static var screenShot:BitmapData;
		public static var FBView:StageWebView;
		
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
			GameOverPage.touchable = true;
			(GameOverPage.getChildByName("result1") as TextField).text = GameStateManager.CurrentScore.toString().concat("M");
			(GameOverPage.getChildByName("result2") as TextField).text = GameStateManager.CurrentCollection.toString();
			(GameOverPage.getChildByName("btn_facebook") as Button).touchable = true;
			SoundManager.PlayBGM("bgover");
		}
		
		private function HideOut():void
		{
			if(FeedDialog.parent)
				removeChild(FeedDialog);
			if (FBView)
			{
				FBView.dispose();
				FBView = null;
			}
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
					(GameOverPage.getChildByName("btn_facebook") as Button).touchable = false;
					setTimeout(function():void
					{
						(GameOverPage.getChildByName("btn_facebook") as Button).touchable = true;
					}, 2000);
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
			(GameOverPage.getChildByName("btn_facebook") as Button).touchable = false;
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
			//var FacebookView:StageWebView
			FBView = new StageWebView();
			FBView.stage = Main.fstage;
			FBView.viewPort = new Rectangle(0,0,Capabilities.screenResolutionX, Capabilities.screenResolutionY);
            FacebookMobile.login(loginHandler, Main.fstage, ["publish_actions"], FBView);
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
			
			setTimeout(function():void
			{
				var bmd:BitmapData = GameLoopManager.Core.stage.stage.drawToBitmapData();
				var encoder:JPEGEncoder = new JPEGEncoder(75);
				
				
				var combineBmd:BitmapData = new BitmapData(600, 500);
				combineBmd.draw(bmd, new Matrix(.5,0,0,.5));
				combineBmd.draw(screenShot, new Matrix(.5,0,0,.5, 300));
				var bytes:ByteArray = encoder.encode(combineBmd);
				
				
				var params:Object = {
					image:bytes,
					fileName: "MyResult.jpg",
					message: (FeedDialog.getChildByName("txt_input") as TextInput).text.concat(" https://play.google.com/store/apps/details?id=air.air.PandaRoll")
				};
				FacebookMobile.api("/me/photos", onFeedComplete, params);
			},1000);
		}
		
		private function onPostScore(response:Object, fail:Object):void
		{
			if (response)
			{
				var existScore:String = response[0].score.toString();
				if (existScore.length != 10)
					existScore = "1000000000";
				//var themeScore:Vector.<String> = new Vector.<String>();
				//
				//for (var i:int = 0 ; i < existScore.length / 5; i ++)
				//{
					//themeScore.push(existScore.slice(i * 5, i * 5 + 5));
				//}
					//14 47 710
				var temp:String = existScore.slice(1);
				var CurrentThemeScore:String = "";
				CurrentThemeScore = temp.slice(GameStateManager.CurrentStage * 3, GameStateManager.CurrentStage * 3 + 3)
				
				//for each(var sc:String in themeScore)
				//{
					//if (int(sc.substr(0, 1)) == GameStateManager.CurrentStage + 1)
					//{
						//CurrentThemeScore = sc;
						//themeScore.splice(themeScore.indexOf(sc),1);
					//}
				//}
				//if (CurrentThemeScore == "") //之前沒有這關的分數
					//CurrentThemeScore = (GameStateManager.CurrentStage + 1).toString().concat("0000");
				
				var score:int = GameStateManager.CurrentScore + GameStateManager.CurrentCollection * 5;
				if (score >= 1000)
					score = 999;
				if (int(CurrentThemeScore) > score)
					return;
				
				var newScore:String = existScore.slice(0,GameStateManager.CurrentStage*3 + 1).concat(addZeros(score)).concat(existScore.slice(GameStateManager.CurrentStage*3 + 4));
				//themeScore.push(newThemeScore);
				//var newScore:String = "";
				//for each(var ee:String in themeScore)
				//{
					//newScore += ee;
				//}
				trace(newScore);
				var params:Object = {   
					score:int(newScore)
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
			if (GameStateManager.CurrentPage != "GameOver")
				return;
			addChildAt(FeedDialog, LayerList.Popup);
			var txt_input:TextInput = (FeedDialog.getChildByName("txt_input") as TextInput);
			txt_input.text = 
			"I get " + (GameStateManager.CurrentScore + GameStateManager.CurrentCollection * 5).toString() + "score in panda roll. Play together and challenge my record!";
			//GameMain.stage.focus = FeedDialog.getChildByName("txt_input") as InteractiveObject;
			FacebookMobile.api("/me/scores", onPostScore);
			txt_input.setFocus();
		}
		
		private function HideFeedDialog():void
		{
			removeChild(FeedDialog);
			//GameOverPage.touchable = true;
		}
		
		private function addZeros(theNum:Number):String {
			var numString:String = String(theNum);
			if (numString.length < 3) {
				var numZeros:Number = 3 - numString.length;
				var finalResult:String = "";
				for (var i:int = 0; i < numZeros; i++) {
					finalResult += "0";
				}
				return finalResult + numString;
			} else {
				return numString;
			}
		}
		
		//}
	}
}