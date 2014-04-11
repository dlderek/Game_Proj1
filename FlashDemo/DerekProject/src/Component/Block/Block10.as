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
	public class Block10 extends BaseBlock
	{
		private static var bmd:Texture;
		public function Block10() 
		{
			if (!bmd)
				bmd = BTool.GetImage("BattlePage_element", "block10");
			super(new Image(bmd) );
			stackLevel = 2;
			playerAction = BaseBlock.ACTION_STACK;
			PhysicsKey = "block10";
		}
	}

}