package Handler 
{
	import Control.AnimationPlayer;
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
	import Utils.BTool;
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
		private var ImagePoint:Sprite;
		private var TutorAnimator:AnimationPlayer;
		
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
			ImagePoint = RecordPage.getChildByName("ImagePoint") as Sprite;
			TutorAnimator = new AnimationPlayer(ImagePoint, BTool.GetImagePackage("RecordPage_element", "tutor"), 1, true, false);
			TutorAnimator.gotoAndStop(0);
		}
		
		private function ShowUp():void
		{
			GameStateManager.CurrentPage = "Record";
			addChildAt(RecordPage, LayerList.UI);
			Event(true);
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
					SoundManager.PlaySound("back");
					break;
				case "btn_next":
					SoundManager.PlaySound("ok");
					TutorAnimator.nextFrame();
					break;
				case "btn_previous":
					SoundManager.PlaySound("ok");
					TutorAnimator.previousFrame();
					break;
			}
		}
		
		private function Back():void
		{
			addTask( { cmd:CmdList.CMD_SWICH_PAGE, page:"Stage" } );
		}
	}
}