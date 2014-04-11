package Component.Block 
{
	import starling.display.Image;
	import starling.textures.Texture;
	import Manager.LoadingManager;
	import Utils.BTool;
	/**
	 * ...
	 * @author JL
	 */
	public class protect extends BaseBlock
	{
		private static var bmd:Texture;
		public function protect() 
		{
			if (!bmd)
				bmd = BTool.GetImage("BattlePage_element","protect");
			super(new Image(bmd));
			playerAction = BaseBlock.ACTION_PROTECT;
			PhysicsKey = "protect";
		}
		
	}

}