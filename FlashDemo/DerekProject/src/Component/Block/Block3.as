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
	public class Block3 extends BaseBlock
	{
		private static var bmd:Texture;
		public function Block3() 
		{
			if (!bmd)
				bmd = BTool.GetImage("BattlePage_element", "block3");
			super(new Image(bmd));
			playerAction = BaseBlock.ACTION_SLIDE;
			PhysicsKey = "block3";
		}
		
	}

}