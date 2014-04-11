package Component.Block 
{
	import starling.display.Image;
	import starling.textures.Texture;
	import Manager.LoadingManager;
	import Utils.BTool;
	/**
	 * ...
	 * @author hello
	 */
	public class Block13 extends BaseBlock
	{
		private static var bmd:Texture;
		public function Block13() 
		{
			if (!bmd)
				bmd = BTool.GetImage("BattlePage_element", "block13");
			super(new Image(bmd));
			stackLevel = 3;
			playerAction = BaseBlock.ACTION_FALL_AND_STACK;
			PhysicsKey = "block13";
		}
	}

}