package Handler 
{
	import com.greensock.TweenLite;
	import flash.geom.Point;
	import Component.RateElement;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.filters.BlurFilter;
	import Utils.BTool;
	import Utils.ToolKit;
	import View.RateView;
	//import flash.display.SimpleButton;
	import starling.display.Sprite;
	import Manager.GameLoopManager;
	import Enum.CmdList;
	import Enum.LayerList;
	import Manager.GameStateManager;
	import Manager.SoundManager;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	//import flash.events.MouseEvent;
	import Manager.XMLManager;
	import View.SettingView;
	import com.facebook.graph.FacebookMobile;
	/**
	 * ...
	 * @author JL
	 */
	public class RateHandler extends BaseHandler
	{
		private var view:RateView;
		private var RatePage:Sprite;
		private var RatePoint:Sprite;
		private var BgPoint:Sprite;
		private var CurrentTheme:int = 1;
		private var ScoreList:Vector.<Array>;
		private var Name1:TextField;
		private var touchPoint:Point = new Point();
		private var bgList:Vector.<Image> = new Vector.<Image>();
		
		public function RateHandler(GameMain:GameLoopManager) 
		{
			super(GameMain);
			TaskList[CmdList.CMD_INIT_HANDLER] = true;
			TaskList[CmdList.CMD_SHOW_RATE_PAGE] = true;
			TaskList[CmdList.CMD_HIDE_RATE_PAGE] = true;
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
				case CmdList.CMD_SHOW_RATE_PAGE:
					ShowUp();
					break;
				case CmdList.CMD_HIDE_RATE_PAGE:
					HideOut();
					break;
			}
		}
		
		private function Init():void
		{
			view = new RateView();
			RatePage = view.RatePage;
			RatePoint = RatePage.getChildByName("ratePoint") as Sprite;
			BgPoint = RatePage.getChildByName("backgroundPoint") as Sprite;
				
			for (var i:int = 1; i < 4; i ++)
				bgList.push(new Image(BTool.GetImage("stage_bg", "stage".concat(i))));
			
			for each(var im:Image in bgList)
				BgPoint.addChild(im);
		}
		
		private function ShowUp():void
		{
			GameStateManager.CurrentPage = "Rate";
			addChildAt(RatePage, LayerList.UI);
			Event(true);
			SetCurrentTheme(CurrentTheme);
			FacebookAction();
			ScoreList = new Vector.<Array>();
			for (var i:int = 1; i < 4; i++)
				ScoreList.push([]);
		}
		
		private function HideOut():void
		{
			removeChild(RatePage);
			Event(false);
		}
		
		private function Event(value:Boolean):void
		{
			if (value)
			{
				RatePage.addEventListener(TouchEvent.TOUCH, onTouch);
				RatePage.addEventListener(TouchEvent.TOUCH, onDrag);
			}
			else
			{
				RatePage.removeEventListener(TouchEvent.TOUCH, onTouch);
				RatePage.removeEventListener(TouchEvent.TOUCH, onDrag);
			}
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(RatePage); 
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
				case "btn_back":
					Back();
					SoundManager.PlaySound("back");
					break;
				case "btn_theme1":
					SetCurrentTheme(1);
					SoundManager.PlaySound("ok2");
					break;
				case "btn_theme2":
					SetCurrentTheme(2);
					SoundManager.PlaySound("ok2");
					break;
			}
		}
		
		private function onDrag(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(RatePage);
			if (!touch)
				return;
			switch(touch.phase)
			{
				case TouchPhase.BEGAN:
					touchPoint = new Point(touch.globalX, touch.globalY);
					break;
				case TouchPhase.MOVED:
					if (RatePoint.numChildren <= 3)
						return;
					var newTouchPoint:Point = new Point(touch.globalX, touch.globalY);
					var dY:Number = (newTouchPoint.y - touchPoint.y)*2;
					var newY:Number = RatePoint.y + dY;
					if (newY > 170)
						newY = 170;
					else if (newY < 765 - RatePoint.height)
						newY = 765 - RatePoint.height;
					TweenLite.killTweensOf(RatePoint);
					TweenLite.to(RatePoint,0.1, {y:newY});
					touchPoint = newTouchPoint.clone();
					break;
			}
		}
		
		private function Back():void
		{
			addTask( { cmd:CmdList.CMD_SWICH_PAGE, page:"Stage" } );
		}
		
		
		private function SetCurrentTheme(id:int):void
		{
			for (var i:int = 1 ; true; i ++)
			{
				var btn:DisplayObject = RatePage.getChildByName("btn_theme".concat(i));
				if (btn == null)
					break;
				btn.alpha = 0.3;
			}
			btn = RatePage.getChildByName("btn_theme".concat(id));
			btn.alpha = 1;
			
			CurrentTheme = id;
			try{
			SortRecord(CurrentTheme);
			DisplayScoreList(CurrentTheme);
			}catch (e:Error)
			{
				
			}
			
			
			for (i = 1; i < 4; i ++)
			{
				var targetY:Number;
				var bgAlpha:Number;
				if (i == id)
				{
					bgAlpha = 1;
				}
				else
				{
					bgAlpha = 0;
				}
				
				var bg:Image = bgList[i - 1];
				TweenLite.killTweensOf(bg);
				TweenLite.to(bg, 1, { alpha: bgAlpha } );
			}
		}
		
		
		// FaceBook action
		
		private function FacebookAction():void
		{
			trace("Facebook");
			FacebookMobile.init(ToolKit.APP_ID, onFacebookInit, null );
		}
		
		private function onFacebookInit(response:Object, fail:Object):void
		{
			trace("onFacebookInit", response, fail);
			if (response)
				getRateList();
            else
                loginUser();
		}
		
		private function loginUser():void 
		{
			//var FacebookView:StageWebView
			GameOverHandler.FBView = new StageWebView();
			GameOverHandler.FBView.stage = Main.fstage;
			GameOverHandler.FBView.viewPort = new Rectangle(0,0,600, 1000);
            FacebookMobile.login(loginHandler, Main.fstage, ["publish_actions"], GameOverHandler.FBView);
        }
		
		private function loginHandler(result:Object, fail:Object):void
		{
		  if (result)
		  {
			  getRateList();
		  }else {
			trace("Login Fail");
		  }
		}
		
		private function getRateList():void
		{
			FacebookMobile.api("app/scores", onGetRateList);
		}
		
		
		private function onGetRateList(response:Object, fail:Object):void
		{
			trace("onGetRateList");
			if (response)
			{
				for each(var user:Object in response)
				{
					var name:String = user.user.name as String;
					var id:String = user.user.id as String;
					var score:String = user.score.toString();
					
					var themeScore:Vector.<String> = new Vector.<String>();
					if (score.length % 5 == 0) //岩格式
					{
						for (var i:int = 1 ; i <= score.length/5; i++)
						{
							ScoreList[i - 1].push({name:name, id:id, score:int(score.substr((i - 1) * 5, (i - 1) * 5 + 5).substr(1))});
						}
					}
				}
				SortRecord(CurrentTheme);
				DisplayScoreList(CurrentTheme);
			}
			else
			{
				
			}
		}
		
		private function SortRecord(id:int):void
		{
			var themeScoreList:Array = ScoreList[id - 1];
			themeScoreList.sortOn("score", Array.NUMERIC|Array.DESCENDING);
		}
		
		private function DisplayScoreList(id:int):void
		{
			while (RatePoint.numChildren > 0)
				RatePoint.removeChildAt(0);
			
			var themeScoreList:Array = ScoreList[id - 1];
			for (var i:int = 0 ; i < themeScoreList.length; i ++)
			{
				var item:Object = themeScoreList[i];
				var displayElement:RateElement = new RateElement(item.id, item.name, item.score);
				displayElement.y = i * 140;
				RatePoint.addChild(displayElement);
			}
		}
	}
}