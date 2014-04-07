package Handler 
{
	import flash.display.DisplayObject;
	import flash.external.ExternalInterface;
	import Manager.GameLoopManager;
	import Enum.CmdList;
	import Enum.LayerList;
	import Manager.GameStateManager;
	import Manager.SoundManager;
	import View.GameOverView;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author JL
	 */
	public class GameOverHandler extends BaseHandler
	{
		private var view:GameOverView;
		private var GameOverPage:Object;
		
		public function GameOverHandler(GameMain:GameLoopManager) 
		{
			super(GameMain);
			TaskList[CmdList.CMD_INIT_HANDLER] = true;
			TaskList[CmdList.CMD_HIDE_GAMEOVER_PAGE] = true;
			TaskList[CmdList.CMD_SHOW_GAMEOVER_PAGE] = true;
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
			}
		}
		
		private function Init():void
		{
			view = new GameOverView();
			GameOverPage = view.GameOverPage;
		}
		
		private function ShowUp():void
		{
			GameStateManager.CurrentPage = "GameOver";
			addChildAt(GameOverPage, LayerList.UI);
			addEvent(true);
			
			GameOverPage.result1.text = GameStateManager.CurrentScore.toString().concat("M");
			GameOverPage.result2.text = GameStateManager.CurrentCollection.toString();
		}
		
		private function HideOut():void
		{
			removeChild(GameOverPage);
			addEvent(false);
		}
		
		private function addEvent(value:Boolean):void
		{
			if (value)
			{
				GameOverPage.addEventListener(MouseEvent.CLICK, onMouseCLick);
			}
			else
			{
				GameOverPage.removeEventListener(MouseEvent.CLICK, onMouseCLick);
			}
		}
		
		private function onMouseCLick(e:MouseEvent):void
		{
			var Target:String = e.target.name;
			switch(Target)
			{
				case "btn_retry":
					Retry();
					break;
				case "btn_quit":
					Quit();
					break;
				case "btn_facebook":
					Facebook();
					break;
			}
		}
		
		private function Facebook():void
		{
			trace("onFacebook");
		}
		
		private function Retry():void
		{
			addTask( { cmd:CmdList.CMD_SWICH_PAGE, page:"Battle" } );
		}
		
		private function Quit():void
		{
			addTask( { cmd:CmdList.CMD_SWICH_PAGE, page:"Stage" } );
		}
	}
}