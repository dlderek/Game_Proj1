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
	public class Block5 extends BaseBlock
	{
		private static var bmd:Texture;
		public function Block5() 
		{
			if (!bmd)
				bmd = BTool.GetImage("BattlePage_element", "block5");
			super(new Image(bmd));
			stackLevel = 0;
			playerAction = BaseBlock.ACTION_JUMP;
			PhysicsKey = "block5";
		}
	}

}