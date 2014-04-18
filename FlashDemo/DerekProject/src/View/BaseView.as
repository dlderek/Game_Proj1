package View 
{
	import starling.display.Button;
	import starling.display.DisplayObject;
	import Manager.LoadingManager;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.text.TextField;
	import Utils.BTool;
	import Utils.TextTool;
	import Utils.ToolKit;
	/**
	 * ...
	 * @author JL
	 */
	public class BaseView 
	{
		public static var ViewList:Vector.<BaseView> = new Vector.<BaseView>();
		public static var QuitPrompt:Sprite;
		
		public function BaseView() 
		{
			ViewList.push(this);
			InitQuitPrompt();
		}
		
		private function InitQuitPrompt():void
		{
			QuitPrompt = new Sprite();
			var sh:Shape = new Shape();
			sh.graphics.beginFill(0xffffff, 0.8);
			sh.graphics.drawRoundRect(0, 0, 500, 300, 20);
			sh.graphics.endFill();
			QuitPrompt.addChild(sh);
			
			var text:TextField = TextTool.DefaultTextfield(500, 200, 30);
			text.text = "ARE U WANNA QUIT?"
			QuitPrompt.addChild(text);
			
			var btn:Button = ToolKit.getDefaultButton("Yes", "btn_yes", 0, 480 - 207, 200);
			QuitPrompt.addChild(btn);
			
			btn = ToolKit.getDefaultButton("No", "btn_no", 0, 10, 200);
			QuitPrompt.addChild(btn);
		}
	}
}