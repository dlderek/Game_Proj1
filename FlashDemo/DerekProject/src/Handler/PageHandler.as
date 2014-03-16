package Handler 
{
	import Enum.CmdList;
	import Manager.GameLoopManager;
	import Manager.GameStateManager;
	/**
	 * ...
	 * @author JL
	 */
	public class PageHandler extends BaseHandler
	{
		
		public function PageHandler(GameMain:GameLoopManager) 
		{
			super(GameMain);
			TaskList[CmdList.CMD_SWICH_PAGE] = true;
		}
		
		public override function process(task:Object):void
		{
			switch(task.cmd)
			{
				case CmdList.CMD_SWICH_PAGE:
					if (GameStateManager.CurrentPage != task.page)
					{
						addTask( { cmd:"cmd.hide." + GameStateManager.CurrentPage.toLowerCase() + ".page" } );
						addTask( { cmd:"cmd.show." + task.page.toLowerCase() + ".page" } );
					}
					break;
			}
		}
		
	}

}