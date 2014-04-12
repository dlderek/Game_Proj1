package Utils 
{
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
		
	}

}