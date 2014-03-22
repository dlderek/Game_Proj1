package Handler 
{
	import com.greensock.TweenLite;
	import Enum.AssetList;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TransformGestureEvent;
	import Manager.GameLoopManager;
	import Enum.CmdList;
	import Enum.LayerList;
	import Manager.GameStateManager;
	import Manager.LoadingManager;
	import Manager.SoundManager;
	import flash.events.MouseEvent;
	import View.StageView;
	/**
	 * ...
	 * @author JL
	 */
	public class StageHandler extends BaseHandler
	{
		private var view:StageView;
		private var StagePage:Object; 
		private var CurrentSelectedStage:int = 1;
		private var background:MovieClip;
		private var bgList:Vector.<Bitmap> = new Vector.<Bitmap>();
		
		public function StageHandler(GameMain:GameLoopManager) 
		{
			super(GameMain);
			TaskList[CmdList.CMD_INIT_HANDLER] = true;
			TaskList[CmdList.CMD_SHOW_STAGE_PAGE] = true;
			TaskList[CmdList.CMD_HIDE_STAGE_PAGE] = true;
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
				case CmdList.CMD_SHOW_STAGE_PAGE:
					ShowUp();
					break;
				case CmdList.CMD_HIDE_STAGE_PAGE:
					HideOut();
					break;
			}
		}
		
		private function Init():void
		{
			view = new StageView();
			StagePage = view.StagePage;
			background = StagePage.background;
			background.gotoAndStop(CurrentSelectedStage);
			for (var i:int = 1; i < 4; i ++)
				bgList.push(LoadingManager.getBitmapItem(AssetList.UI_STAGEPAGE, "jl.stagepage.bg".concat(i)));
			for (i = 0; i < 3; i++)
				background.addChild(bgList[2-i]);
		}
		
		private function ShowUp():void
		{
			GameStateManager.CurrentPage = "Stage";
			addChildAt(StagePage, LayerList.UI);
			Event(true);
			//SoundManager.PlayBGM("bg");
		}
		
		private function HideOut():void
		{
			removeChild(StagePage);
			Event(false);
		}
		
		private function Event(value:Boolean):void
		{
			if (value)
			{
				StagePage.addEventListener(MouseEvent.CLICK, onMouseCLick);
				StagePage.addEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwipe);
			}
			else
			{
				StagePage.removeEventListener(MouseEvent.CLICK, onMouseCLick);
				StagePage.removeEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwipe);
			}
		}
		
		private function onMouseCLick(e:MouseEvent):void
		{
			var Target:String = e.target.name;
			switch(Target)
			{
				case "btn_stage1":
					SwitchStage(1);
					break;
				case "btn_stage2":
					SwitchStage(2);
					break;
				case "btn_stage3":
					SwitchStage(3);
					break;
				case "btn_back":
					Back();
					break;
				case "btn_play":
					Play(CurrentSelectedStage);
					break;
			}
		}
		
		private function onSwipe(e:TransformGestureEvent):void
		{
			
		}
		
		private function SwitchStage(id:int):void
		{
			for (var i:int = 1; i < 4; i ++)
			{
				var targetY:Number;
				var bgAlpha:Number;
				if (i == id)
				{
					targetY = -251.15;
					bgAlpha = 1;
					CurrentSelectedStage = i;
				}
				else
				{
					targetY = -506.1;
					bgAlpha = 0;
				}
				var obj:DisplayObject = StagePage["btn_stage" + i];
				var bg:Bitmap = bgList[i - 1];
				TweenLite.killTweensOf(obj);
				TweenLite.killTweensOf(bg);
				TweenLite.to(obj, 0.5, { y: targetY } );
				TweenLite.to(bg, 1, { alpha: bgAlpha } );
			}
		}
		
		private function Play(id:int):void
		{
			GameMain.addTask({cmd:CmdList.CMD_SWICH_PAGE, page:"Battle"});
		}
		
		private function Back():void
		{
			GameMain.addTask({cmd:CmdList.CMD_SWICH_PAGE, page:"Home"});
		}
	}
}