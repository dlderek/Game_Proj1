package Handler 
{
	import Control.B2WorldControl;
	import Control.BackgroundControlHorizontal;
	import Control.BackgroundControlRotation;
	import Control.BackgroundControlStatic;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.extensions.pixelmask.PixelMaskDisplayObject;
	//import flash.events.MouseEvent;
	//import flash.events.TouchEvent;
	import flash.geom.Point;
	import starling.text.TextField;
	//import flash.text.TextField;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import Manager.GameLoopManager;
	import Enum.CmdList;
	import Manager.LoadingManager;
	import Manager.SoundManager;
	import Utils.ToolKit;
	import View.BattleView;
	import Enum.LayerList;
	import Manager.GameStateManager;
	/**
	 * ...
	 * @author JL
	 */
	public class BattleHandller extends BaseHandler
	{
		private var view:BattleView;
		private var BattlePage:Sprite;
		private var BattlePageMask:Sprite;
		private var B2World:B2WorldControl;
		
		//theme1
		private var BgControlH:BackgroundControlHorizontal;
		
		//theme2
		private var BGControlR:BackgroundControlRotation;
		private var BGControlS:BackgroundControlStatic;
		
		private var BGSoundEffectInterval:uint;
		private var ScoreUpdateInterval:uint;
		
		private var score1:TextField;
		private var score2:TextField;
		
		public function BattleHandller(GameMain:GameLoopManager) 
		{
			super(GameMain);
			TaskList[CmdList.CMD_INIT_HANDLER] = true;
			TaskList[CmdList.CMD_SHOW_BATTLE_PAGE] = true;
			TaskList[CmdList.CMD_HIDE_BATTLE_PAGE] = true;
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
				case CmdList.CMD_SHOW_BATTLE_PAGE:
					ShowUp();
					break;
				case CmdList.CMD_HIDE_BATTLE_PAGE:
					HideOut();
					break;
			}
		}
		
		private function Init():void
		{
			view = new BattleView();
			BattlePage = view.BattlePage;
			BattlePageMask = view.BattlePageMask;
			//var maskedDisplayObject:PixelMaskDisplayObject = new PixelMaskDisplayObject( -1, false);
			//maskedDisplayObject.addChild(BattlePage);
			//maskedDisplayObject.mask = BattlePageMask;
			
			//BattlePage.mask = BattlePageMask;
			score1 = BattlePage.getChildByName("score") as TextField;
			score2 = BattlePage.getChildByName("score2") as TextField;
			B2World = new B2WorldControl(BattlePage.getChildByName("origin"));
			BgControlH = new BackgroundControlHorizontal(BattlePage.getChildByName("backgroundPoint2") as Sprite, [ToolKit.getBgSprite(1), ToolKit.getBgSprite(1)], 600);
			BGControlR = new BackgroundControlRotation(BattlePage.getChildByName("backgroundPoint2") as Sprite, 0.001);
			BGControlS = new BackgroundControlStatic(BattlePage.getChildByName("backgroundPoint2") as Sprite, ToolKit.getBgSprite(3));
		}
		
		private function ShowUp():void
		{
			GameStateManager.CurrentPage = "Battle";
			addChildAt(BattlePage, LayerList.UI);
			B2World.Reset();
			BattlePage.addEventListener(TouchEvent.TOUCH, onTouch);
			GameLoopManager.Core.stage.addEventListener("PlayerDie", onPlayerDie);
			BGSoundEffectInterval = setInterval(PlayRandomBGSoundEffect, 10000);
			ScoreUpdateInterval = setInterval(ScoreUpdate, 100);
			
			if (GameStateManager.CurrentStage == 0)
			{
				BgControlH.start();
			}
			else if (GameStateManager.CurrentStage == 1)
			{
				BGControlR.start();
				BGControlS.start();
			}
		}
		
		private function HideOut():void
		{
			removeChild(BattlePage);
			BattlePage.removeEventListener(TouchEvent.TOUCH, onTouch);
			GameLoopManager.Core.stage.removeEventListener("PlayerDie", onPlayerDie);
			clearInterval(BGSoundEffectInterval);
			clearInterval(ScoreUpdateInterval);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(BattlePage); 
			if (!touch)
				return;
			if (touch.phase != TouchPhase.ENDED)
				return;
			try{
				if (!((e.target as DisplayObject).parent.parent is Button))
					return;
			}catch(e:Error){return}
			var Target:String = ((e.target as DisplayObject).parent.parent as Button).name;
			
			if (Target.indexOf("btn") == -1)
				return;
			switch(Target)
			{
				case "btn_reset":
					B2World.Reset();
					break;
				case "btn_back":
					GameMain.addTask( { cmd:CmdList.CMD_SWICH_PAGE, page:"Stage" } );
					break;
			}
		}
		
		private function PlayRandomBGSoundEffect():void
		{
			//if (Math.random()>0.5)
			//{
				//SoundManager.PlayBGEffect("brid_FINCH");
			//}
			//else
			//{
				//SoundManager.PlayBGEffect("wind04");
			//}
		}
		
		private function onPlayerDie(e:Event):void
		{
			GameStateManager.CurrentScore = B2World.CurrentScore;
			GameStateManager.CurrentCollection = B2World.CurrentCollection;
			GameMain.addTask({cmd:CmdList.CMD_SWICH_PAGE, page:"GameOver"});
		}
		
		private function ScoreUpdate():void
		{
			B2World.CurrentScore += 0.1;
			score1.text = Math.round(B2World.CurrentScore) + " M";
			score2.text = B2World.CurrentCollection.toString();
		}
	}
}