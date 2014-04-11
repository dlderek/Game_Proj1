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
	public class Block15 extends BaseBlock
	{
		private static var bmd:Texture;
		public function Block15() 
		{
			if (!bmd)
				bmd = BTool.GetImage("BattlePage_element", "block15");
			super(new Image(bmd));
			stackLevel = 5;
			playerAction = BaseBlock.ACTION_FALL_AND_STACK;
			PhysicsKey = "block15";
		}
	}

}