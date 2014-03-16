package Handler 
{
	import flash.display.DisplayObject;
	import Manager.GameLoopManager;
	import Enum.CmdList;
	import Enum.LayerList;
	import Manager.GameStateManager;
	import Manager.SoundManager;
	import View.HomeView;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author JL
	 */
	public class HomeHandler extends BaseHandler
	{
		private var view:HomeView;
		private var HomePage:Object;
		
		public function HomeHandler(GameMain:GameLoopManager) 
		{
			super(GameMain);
			TaskList[CmdList.CMD_INIT_HANDLER] = true;
			TaskList[CmdList.CMD_SHOW_HOME_PAGE] = true;
			TaskList[CmdList.CMD_HIDE_HOME_PAGE] = true;
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
				case CmdList.CMD_SHOW_HOME_PAGE:
					ShowUp();
					break;
				case CmdList.CMD_HIDE_HOME_PAGE:
					HideOut();
					break;
			}
		}
		
		private function Init():void
		{
			view = new HomeView();
			HomePage = view.HomePage;
		}
		
		private function ShowUp():void
		{
			GameStateManager.CurrentPage = "Home";
			addChildAt(HomePage, LayerList.UI);
			Event(true);
			//SoundManager.PlayBGM("bg");
		}
		
		private function HideOut():void
		{
			removeChild(HomePage);
			Event(false);
		}
		
		private function Event(value:Boolean):void
		{
			if (value)
			{
				HomePage.addEventListener(MouseEvent.CLICK, onMouseCLick);
			}
			else
			{
				HomePage.removeEventListener(MouseEvent.CLICK, onMouseCLick);
			}
		}
		
		private function onMouseCLick(e:MouseEvent):void
		{
			var Target:String = e.target.name;
			switch(Target)
			{
				case "btn_new":
					Btn_New();
					break;
				case "btn_continue":
					break;
				case "btn_exit":
					break;
			}
		}
		
		private function Btn_New():void
		{
			addTask( { cmd:CmdList.CMD_SWICH_PAGE, page:"Battle" } );
		}
	}
}