package Handler 
{
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import flash.geom.Rectangle;
	import Manager.GameLoopManager;
	import Enum.CmdList;
	import Enum.LayerList;
	import Manager.GameStateManager;
	import Manager.SoundManager;
	import starling.events.TouchPhase;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	//import flash.events.MouseEvent;
	import Utils.ToolKit;
	import View.RecordView;
	import com.facebook.graph.FacebookMobile;
	import com.facebook.graph.controls.Distractor;
	import flash.media.StageWebView;
	/**
	 * ...
	 * @author JL
	 */
	public class RecordHandler extends BaseHandler
	{
		private var view:RecordView;
		private var RecordPage:Sprite;
		
		public function RecordHandler(GameMain:GameLoopManager) 
		{
			super(GameMain);
			TaskList[CmdList.CMD_INIT_HANDLER] = true;
			TaskList[CmdList.CMD_SHOW_RECORD_PAGE] = true;
			TaskList[CmdList.CMD_HIDE_RECORD_PAGE] = true;
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
				case CmdList.CMD_SHOW_RECORD_PAGE:
					ShowUp();
					break;
				case CmdList.CMD_HIDE_RECORD_PAGE:
					HideOut();
					break;
			}
		}
		
		private function Init():void
		{
			view = new RecordView();
			RecordPage = view.RecordPage;
		}
		
		private function ShowUp():void
		{
			GameStateManager.CurrentPage = "Record";
			addChildAt(RecordPage, LayerList.UI);
			Event(true);
			//SoundManager.PlayBGM("bg");
			FacebookMobile.init(ToolKit.APP_ID, onFacebookInit, null );
		}
		
		private function HideOut():void
		{
			removeChild(RecordPage);
			Event(false);
		}
		
		private function Event(value:Boolean):void
		{
			if (value)
			{
				RecordPage.addEventListener(TouchEvent.TOUCH, onTouch);
			}
			else
			{
				RecordPage.removeEventListener(TouchEvent.TOUCH, onTouch);
			}
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(RecordPage); 
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
					break;
				case "btn_theme1":
					break;
				case "btn_theme2":
					break;
			}
		}
		
		private function Back():void
		{
			addTask( { cmd:CmdList.CMD_SWICH_PAGE, page:"Stage" } );
		}
		
		
		private function onFacebookInit(response:Object, fail:Object):void
		{
			trace("onFacebookInit", response, fail);
			if (response)
				getScoreList();
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
			getScoreList();
		  }else {
			trace("Login Fail");
		  }
		}
		
		private function getScoreList():void
		{
			FacebookMobile.api("/app/scores?limit=3", onGetScoreList);
			//FacebookMobile.fqlQuery("",onGetFriendList);
		}
		
		private function onGetScoreList(response:Object, fail:Object):void
		{
			if (response)
			{
				
			}
			else
			{
				
			}
		}
		
		private function DisplayScore(list:Array):void
		{
			for (var i:int = 0 ; i < list.length; i++)
			{
				var score:Number = list[i].score;
				var name:String = list[i].user.name;
			}
		}
	}
}