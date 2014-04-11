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
	public class Block2 extends BaseBlock
	{
		private static var bmd:Texture;
		public function Block2() 
		{
			if (!bmd)
				bmd = BTool.GetImage("BattlePage_element", "block2");
			super(new Image(bmd));
			stackLevel = 2;
			playerAction = BaseBlock.ACTION_STACK;
			PhysicsKey = "block2";
		}
		
	}

}