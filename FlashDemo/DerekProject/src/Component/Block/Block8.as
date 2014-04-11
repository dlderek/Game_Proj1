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
	public class Block8 extends BaseBlock
	{
		private static var bmd:Texture;
		public function Block8() 
		{
			if (!bmd)
				bmd = BTool.GetImage("BattlePage_element", "block8");
			super(new Image(bmd));
			stackLevel = 0;
			playerAction = BaseBlock.ACTION_NONE;
			PhysicsKey = "block8";
		}
	}

}