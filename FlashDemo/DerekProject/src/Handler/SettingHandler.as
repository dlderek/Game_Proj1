package Handler 
{
	import starling.display.Button;
	import starling.display.DisplayObject;
	//import flash.display.SimpleButton;
	import starling.display.Sprite;
	import Manager.GameLoopManager;
	import Enum.CmdList;
	import Enum.LayerList;
	import Manager.GameStateManager;
	import Manager.SoundManager;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	//import flash.events.MouseEvent;
	import Manager.XMLManager;
	import View.SettingView;
	/**
	 * ...
	 * @author JL
	 */
	public class SettingHandler extends BaseHandler
	{
		private var view:SettingView;
		private var SettingPage:Sprite;
		
		public function SettingHandler(GameMain:GameLoopManager) 
		{
			super(GameMain);
			TaskList[CmdList.CMD_INIT_HANDLER] = true;
			TaskList[CmdList.CMD_SHOW_SETTING_PAGE] = true;
			TaskList[CmdList.CMD_HIDE_SETTING_PAGE] = true;
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
				case CmdList.CMD_SHOW_SETTING_PAGE:
					ShowUp();
					break;
				case CmdList.CMD_HIDE_SETTING_PAGE:
					HideOut();
					break;
			}
		}
		
		private function Init():void
		{
			view = new SettingView();
			SettingPage = view.SettingPage;
		}
		
		private function ShowUp():void
		{
			GameStateManager.CurrentPage = "Setting";
			addChildAt(SettingPage, LayerList.UI);
			Event(true);
			SetControlStyle(int(XMLManager.config["ControlStyle"]));
		}
		
		private function HideOut():void
		{
			removeChild(SettingPage);
			Event(false);
		}
		
		private function Event(value:Boolean):void
		{
			if (value)
			{
				SettingPage.addEventListener(TouchEvent.TOUCH, onTouch);
			}
			else
			{
				SettingPage.removeEventListener(TouchEvent.TOUCH, onTouch);
			}
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(SettingPage); 
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
					break;
				case "btn_set1":
					SetControlStyle(0);
					break;
				case "btn_set2":
					SetControlStyle(1);
					break;
			}
		}
		
		private function Back():void
		{
			addTask( { cmd:CmdList.CMD_SWICH_PAGE, page:"Stage" } );
		}
		
		private function SetControlStyle(styleId:int):void
		{
			if (styleId <0 || styleId > 1)
				return;
			
			var deactiveBtn:Button = SettingPage.getChildByName("btn_set1") as Button;
			deactiveBtn.alpha = .2;
			deactiveBtn = SettingPage.getChildByName("btn_set2") as Button;
			deactiveBtn.alpha = .2;
			
			var activeBtn:Button = SettingPage.getChildByName("btn_set".concat(styleId + 1)) as Button;
			activeBtn.alpha = 1;
			
			XMLManager.config["ControlStyle"] = styleId;
		}
	}
}