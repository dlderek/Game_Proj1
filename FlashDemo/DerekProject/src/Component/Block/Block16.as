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
	public class Block16 extends BaseBlock
	{
		private static var bmd:Texture;
		public function Block16() 
		{
			if (!bmd)
				bmd = BTool.GetImage("BattlePage_element", "block16");
			super(new Image(bmd));
			stackLevel = 1;
			playerAction = BaseBlock.ACTION_JUMP;
			PhysicsKey = "block16";
		}
	}

}