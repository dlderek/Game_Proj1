package Handler 
{
	import Control.B2WorldControl;
	import Control.BackgroundControl;
	import Control.BackgroundControlHorizontal;
	import Enum.AssetList;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
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
		private var BgControl:BackgroundControl;
		private var BgControl2:BackgroundControl;
		private var BgControlH:BackgroundControlHorizontal;
		//private var BgControlH2:BackgroundControlHorizontal;
		
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
			//BgControlH2 = new BackgroundControlHorizontal(BattlePage.backgroundPoint, [ToolKit.getBg4Sprite()], 60);
			BgControl = new BackgroundControl(BattlePage.backgroundPoint, ToolKit.getBgSprite(), 20, 0.15);
			BgControl2 = new BackgroundControl(BattlePage.backgroundPoint, ToolKit.getBg2Sprite(), 30, 0.15);
			BgControlH = new BackgroundControlHorizontal(BattlePage.backgroundPoint2, [ToolKit.getBg3Sprite(), ToolKit.getBg3Sprite()], 600);
			
		}
		
		private function ShowUp():void
		{
			GameStateManager.CurrentPage = "Battle";
			addChildAt(BattlePage, LayerList.UI);
			(BattlePage as MovieClip).addEventListener(MouseEvent.CLICK, onTouch);
			BGSoundEffectInterval = setInterval(PlayRandomBGSoundEffect, 10000);
			ScoreUpdateInterval = setInterval(ScoreUpdate, 500);
		}
		
		private function HideOut():void
		{
			removeChild(BattlePage);
			(BattlePage as MovieClip).removeEventListener(MouseEvent.CLICK, onTouch);
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
		
		private function ScoreUpdate():void
		{
			B2World.CurrentScore += 1;
			BattlePage.score.text = B2World.CurrentScore + "KM";
		}
	}
}