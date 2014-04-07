package Handler 
{
	import Control.B2WorldControl;
	import Control.BackgroundControl;
	import Control.BackgroundControlHorizontal;
	import Control.BackgroundControlRotation;
	import Control.BackgroundControlStatic;
	import Enum.AssetList;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
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
		private var BattlePage:Object;
		private var B2World:B2WorldControl;
		
		//theme1
		private var BgControlH:BackgroundControlHorizontal;
		
		//theme2
		private var BGControlR:BackgroundControlRotation;
		private var BGControlS:BackgroundControlStatic;
		
		private var BGSoundEffectInterval:uint;
		private var ScoreUpdateInterval:uint;
		
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
			BattlePage = view.BattlePage as Object;
			B2World = new B2WorldControl(BattlePage.origin);
			BgControlH = new BackgroundControlHorizontal(BattlePage.backgroundPoint2, [ToolKit.getBgSprite(1), ToolKit.getBgSprite(1)], 600);
			BGControlR = new BackgroundControlRotation(BattlePage.backgroundPoint2, ToolKit.getBgSprite(2), 0.05);
			BGControlS = new BackgroundControlStatic(BattlePage.backgroundPoint2, ToolKit.getBgSprite(3));
		}
		
		private function ShowUp():void
		{
			GameStateManager.CurrentPage = "Battle";
			addChildAt(BattlePage, LayerList.UI);
			B2World.Reset();
			(BattlePage as MovieClip).addEventListener(MouseEvent.CLICK, onTouch);
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
			(BattlePage as MovieClip).removeEventListener(MouseEvent.CLICK, onTouch);
			GameLoopManager.Core.stage.removeEventListener("PlayerDie", onPlayerDie);
			clearInterval(BGSoundEffectInterval);
			clearInterval(ScoreUpdateInterval);
		}
		
		private function onTouch(e:MouseEvent):void
		{
			switch(e.target.name)
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
			BattlePage.score.text = Math.round(B2World.CurrentScore) + " M";
			BattlePage.score2.text = B2World.CurrentCollection;
		}
	}
}