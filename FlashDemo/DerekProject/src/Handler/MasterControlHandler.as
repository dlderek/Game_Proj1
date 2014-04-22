package Handler 
{
	import Enum.CmdList;
	import Enum.LayerList;
	import Manager.GameLoopManager;
	import Manager.GameStateManager;
	import Manager.SoundManager;
	import Manager.XMLManager;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import View.BaseView;
	import flash.ui.Keyboard; 
	import flash.events.KeyboardEvent;
	import starling.core.Starling;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import flash.desktop.NativeApplication;
	/**
	 * ...
	 * @author hello
	 */
	public class MasterControlHandler extends BaseHandler
	{
		private var QuitPrompt:Sprite;
		
		public function MasterControlHandler(GameMain:GameLoopManager) 
		{
			super(GameMain);
			TaskList[CmdList.CMD_INIT_HANDLER] = true;
		}
		
		public override function process(task:Object):void
		{
			if (task.cmd == CmdList.CMD_INIT_HANDLER)
			{
				Init();
				return;
			}
		}
		
		private function Init():void
		{
			QuitPrompt = BaseView.QuitPrompt;
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
		}
		
		private function keyPressed(e:KeyboardEvent):void
		{    
			 if(e.keyCode == Keyboard.BACK || e.keyCode == Keyboard.A)
			 {
				 e.preventDefault();
				e.stopImmediatePropagation();
				if (GameOverHandler.FBView)
				{
					GameOverHandler.FBView.dispose();
					GameOverHandler.FBView = null;
				}
				else
				{
					QuitPrompt.x = 50;
					QuitPrompt.y = 350;
					addChildAt(QuitPrompt, LayerList.Top);
					GameMain.layers[LayerList.UI].touchable = false;
					GameMain.layers[LayerList.Popup].touchable = false;
					if(!QuitPrompt.hasEventListener(TouchEvent.TOUCH))
						QuitPrompt.addEventListener(TouchEvent.TOUCH, onTouch);
				}
			 }       
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(QuitPrompt); 
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
				case "btn_yes":
					XMLManager.SaveConfig();
					NativeApplication.nativeApplication.exit();
					break;
				case "btn_no":
					removeChild(QuitPrompt);
					QuitPrompt.removeEventListener(TouchEvent.TOUCH, onTouch);
					SoundManager.PlaySound("back");
					GameMain.layers[LayerList.UI].touchable = true;
					GameMain.layers[LayerList.Popup].touchable = true;
					break;
			}
		}
	}
}