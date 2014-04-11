package Component 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import Utils.TextTool;
	/**
	 * ...
	 * @author hello
	 */
	public class RecordElement extends Sprite
	{
		private var id:int;
		private var userName:String;
		private var score:Number;
		private var imgURL:String;
		
		private var textId:TextField;
		private var textName:TextField;
		private var textScore:TextField;
		private var img:Image;
		
		public function RecordElement(id:int, userName:String, score:Number, imgURL:String = "") 
		{
			this.id = id;
			this.userName = userName;
			this.score = score;
			this.imgURL = imgURL;
			
			textId = TextTool.DefaultTextfield(50, 50, 30);
			textName = TextTool.DefaultTextfield(200, 50, 30);
			textScore = TextTool.DefaultTextfield(200, 50, 30);
			
			textId.text = id.toString();
			textName.text = userName;
			textScore.text = score.toString();
			
			addChild(textId);
			
			textName.x = 150;
			addChild(textName);
			
			textScore.x = 350;
			addChild(textScore);
		}
		
		
		
	}

}