package Handler 
{
	import com.greensock.TweenLite;
	import Component.Character;
	import Manager.XMLManager;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.events.TransformGestureEvent;
	import starling.display.Image;
	import Manager.GameLoopManager;
	import Enum.CmdList;
	import Enum.LayerList;
	import Manager.GameStateManager;
	import Manager.LoadingManager;
	import Manager.SoundManager;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	//import flash.events.MouseEvent;
	import Utils.BTool;
	import View.StageView;
	import flash.desktop.NativeApplication;
	
	/**
	 * ...
	 * @author JL
	 */
	public class StageHandler extends BaseHandler
	{
		private var view:StageView;
		private var StagePage:Sprite; 
		private var CurrentSelectedStage:int = 1;
		private var character:Character;
		private var background:Sprite;
		private var bgList:Vector.<Image> = new Vector.<Image>();
		
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
			background = StagePage.getChildByName("background") as Sprite;
			for (var i:int = 1; i < 4; i ++)
				bgList.push(new Image(BTool.GetImage("stage_bg", "stage".concat(i))));
			for (i = 0; i < 3; i++)
				background.addChild(bgList[2 - i]);
				
			character = new Character();
			character.y = 400;
			character.x = 100;
			character.scaleX = 1.5;
			character.scaleY = 1.5;
			(StagePage.getChildByName("characterPoint") as Sprite).addChild(character);
			
		}
		
		private function ShowUp():void
		{
			GameStateManager.CurrentPage = "Stage";
			addChildAt(StagePage, LayerList.UI);
			addEvent(true);
			SoundManager.PlayBGM("bg0");
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
				StagePage.addEventListener(TouchEvent.TOUCH, onTouch);
				StagePage.addEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwpie);
				character.addEventListener(Event.ENTER_FRAME, CharacterMotion);
			}
			else
			{
				StagePage.removeEventListener(TouchEvent.TOUCH, onTouch);
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
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(StagePage); 
			if (!touch)
			{
				return;
			}
			if (touch.phase != TouchPhase.ENDED)
				return;
			try{
				if (!((e.target as DisplayObject).parent.parent is Button))
				{
					return;
				}
			}catch (e:Error) {
				trace(e.message);
				return
				}
			var Target:String = ((e.target as DisplayObject).parent.parent as Button).name;
			trace(Target);
			switch(Target)
			{
				case "btn_stage1":
					SwitchStage(1);
					SoundManager.PlaySound("ok2");
					break;
				case "btn_stage2":
					SwitchStage(2);
					SoundManager.PlaySound("ok2");
					break;
				case "btn_stage3":
					SwitchStage(3);
					SoundManager.PlaySound("ok2");
					break;
				case "btn_exit":
					Exit();
					SoundManager.PlaySound("back");
					break;
				case "btn_play":
					Play(CurrentSelectedStage);
					SoundManager.PlaySound("collect");
					break;
				case "btn_config":
					Config();
					SoundManager.PlaySound("ok");
					break;
				case "btn_record":
					Record();
					SoundManager.PlaySound("ok");
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
				var obj:DisplayObject = StagePage.getChildByName("btn_stage" + i);
				var bg:Image = bgList[i - 1];
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
			XMLManager.SaveConfig();
			NativeApplication.nativeApplication.exit();
		}
		
		private function CharacterMotion(e:Event):void
		{
			var dx:Number = character.x -( 100 + (CurrentSelectedStage -1) * 200);
			character.x -= dx / 20;
			character.rotation -= 0.1 * Math.abs(dx) / 30;
			if (character.rotation < -360)
				character.rotation = 0;
		}
		
		private function Config():void
		{
			GameMain.addTask({cmd:CmdList.CMD_SWICH_PAGE, page:"Setting"});
		}
		
		private function Record():void
		{
			addTask( { cmd:CmdList.CMD_SWICH_PAGE, page:"Record"} );
		}
	}
}