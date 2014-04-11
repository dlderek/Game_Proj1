package Component.Block 
{
	import Component.BaseComponent;
	import starling.display.Image;
	import starling.textures.Texture;
	import Manager.LoadingManager;
	import Utils.BTool;
	/**
	 * ...
	 * @author JL
	 */
	public class Collection extends BaseBlock
	{
		private static var bmd:Texture;
		public function Collection() 
		{
			if (!bmd)
				bmd = BTool.GetImage("BattlePage_element", "collection");
			super(new Image(bmd));
			playerAction = BaseBlock.ACTION_GET;
			PhysicsKey = "collection";
		}
		
	}

}