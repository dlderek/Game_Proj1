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
	public class Block14 extends BaseBlock
	{
		private static var bmd:Texture;
		public function Block14() 
		{
			if (!bmd)
				bmd = BTool.GetImage("BattlePage_element", "block14");
			super(new Image(bmd));
			stackLevel = 4;
			playerAction = BaseBlock.ACTION_FALL_AND_STACK;
			PhysicsKey = "block14";
		}
	}

}