package Component.Block 
{
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.display.DisplayObject;
	import Manager.LoadingManager;
	import Utils.BTool;
	/**
	 * ...
	 * @author hello
	 */
	public class Block7 extends BaseBlock
	{
		private static var bmd:Texture;
		public function Block7() 
		{
			if (!bmd)
				bmd = BTool.GetImage("BattlePage_element", "block7");
			var img:DisplayObject = new Image(bmd);
			img.x = -img.width;
			super(img);
			stackLevel = 0;
			playerAction = BaseBlock.ACTION_PAUSE;
			PhysicsKey = "block7";
			flip = true;
		}
	}

}