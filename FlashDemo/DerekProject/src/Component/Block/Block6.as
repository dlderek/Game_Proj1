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
	public class Block6 extends BaseBlock
	{
		private static var bmd:Texture;
		public function Block6() 
		{
			if (!bmd)
				bmd = BTool.GetImage("BattlePage_element", "block6");
			super(new Image(bmd));
			stackLevel = 0;
			playerAction = BaseBlock.ACTION_PAUSE;
			PhysicsKey = "block6";
		}
		
	}

}