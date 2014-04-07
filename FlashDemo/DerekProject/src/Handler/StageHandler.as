package Handler 
{
	import com.greensock.TweenLite;
	import Component.Character;
	import Enum.AssetList;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TransformGestureEvent;
	import Manager.GameLoopManager;
	import Enum.CmdList;
	import Enum.LayerList;
	import Manager.GameStateManager;
	import Manager.LoadingManager;
	import Manager.SoundManager;
	import flash.events.MouseEvent;
	import View.StageView;
	import flash.desktop.NativeApplication;
	
	/**
	 * ...
	 * @author JL
	 */
	public class StageHandler extends BaseHandler
	{
		private var view:StageView;
		private var StagePage:Object; 
		private var CurrentSelectedStage:int = 1;
		private var character:Character;
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
				background.addChild(bgList[2 - i]);
				
			character = new Character();
			character.y = 537;
			character.x = 100;
			character.scaleX = 1.5;
			character.scaleY = 1.5;
			StagePage.characterPoint.addChild(character);
			
		}
		
		private function ShowUp():void
		{
			GameStateManager.CurrentPage = "Stage";
			addChildAt(StagePage, LayerList.UI);
			addEvent(true);
			//SoundManager.PlayBGM("bg");
		}
		
		private function HideOut():void
		{
			removeChild(StagePage);
			addEvent(false);
		}
		
		private function addEvent(value:Boolean):void
		{
			if (value)
			{
				StagePage.addEventListener(MouseEvent.CLICK, onMouseCLick);
				StagePage.addEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwpie);
				character.addEventListener(Event.ENTER_FRAME, CharacterMotion);
			}
			else
			{
				StagePage.removeEventListener(MouseEvent.CLICK, onMouseCLick);
				StagePage.removeEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwpie);
				character.removeEventListener(Event.ENTER_FRAME, CharacterMotion);
			}
		}
		
		private function onSwpie(e:TransformGestureEvent):void
		{
			if (e.offsetX > 0)
			{
				if (CurrentSelectedStage < 3)
					SwitchStage(CurrentSelectedStage + 1);
			}
			else
			{
				if (CurrentSelectedStage > 1)
					SwitchStage(CurrentSelectedStage - 1);
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
				case "btn_exit":
					Exit();
					break;
				case "btn_play":
					Play(CurrentSelectedStage);
					break;
			}
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
			if (CurrentSelectedStage == 3)
				return;
			GameStateManager.CurrentStage = CurrentSelectedStage - 1;
			GameMain.addTask({cmd:CmdList.CMD_SWICH_PAGE, page:"Battle"});
		}
		
		private function Exit():void
		{
			NativeApplication.nativeApplication.exit();
			//GameMain.addTask({cmd:CmdList.CMD_SWICH_PAGE, page:"Home"});
		}
		
		private function CharacterMotion(e:Event):void
		{
			var dx:Number = character.x -( 100 + (CurrentSelectedStage -1) * 200);
			character.x -= dx / 20;
			character.rotation -= 2 + 1 * dx/5;
			if (character.rotation < -360)
				character.rotation = 0;
		}
	}
}