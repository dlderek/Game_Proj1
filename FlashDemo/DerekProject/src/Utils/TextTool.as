package Utils 
{
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.TextInput;
	import feathers.core.ITextEditor;
	import starling.text.TextField;
	import Manager.LoadingManager;
	import flash.text.Font;
	/**
	 * ...
	 * @author JL
	 */
	public class TextTool 
	{
		private static var SHOWG:Class;
		public static function DefaultTextfield(width:Number, height:Number, size:int = 30, color:uint = 0x000000):TextField
		{
			if (!SHOWG)
			{
				SHOWG = LoadingManager.getClass("Font", "SHOWG");
				Font.registerFont(SHOWG);
			}
			//var tf:TextFormat = new TextFormat();
			//tf.font = "Showcard Gothic";
			//tf.size = size;
				
			var text:TextField = new TextField(width, height, "", "Showcard Gothic");
			text.color = color;
			text.fontSize = size;
			text.autoSize = "left";
			//text.autoSize = TextFieldAutoSize.LEFT;
			//text.defaultTextFormat = tf;
			return text;
		}
		
		public static function DefaultTextInput(width:Number, height:Number, size:int = 30, color:uint = 0x000000):TextInput
		{
			if (!SHOWG)
			{
				SHOWG = LoadingManager.getClass("Font", "SHOWG");
				Font.registerFont(SHOWG);
			}
			
			var text:TextInput = new TextInput();
			text.width = width;
			text.height = height;
			
			 var editor:StageTextTextEditor = new StageTextTextEditor;
			editor.fontSize = size;
			editor.color = color;
			editor.fontFamily = "SHOWG";
			editor.multiline = true;
			text.textEditorFactory = function f():ITextEditor { return editor };
			
			return text;
		}
		
	}

}