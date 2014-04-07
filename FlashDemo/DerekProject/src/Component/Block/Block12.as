package Component.Block 
{
	import Control.AnimationPlayer;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	import Manager.LoadingManager;
	import Enum.AssetList;
	import Utils.ToolBitmapClipping;
	/**
	 * ...
	 * @author hello
	 */
	public class Block12 extends BaseBlock
	{
		private var waterfall:Sprite;
		private var AnimationPackage:Vector.<Bitmap>;
		private var AnimPlayer:AnimationPlayer;
		
		public function Block12() 
		{
			//if (!AnimationPackage)
				AnimationPackage = ToolBitmapClipping.GetImagePackage("waterfall", "waterfall");
				
			super(LoadingManager.getItem(AssetList.UI_BATTLEPAGE, AssetList.CLASS_BLOCK12));
				
			waterfall = new Sprite(); 
			waterfall.scaleX = 3;
			this.addChild(waterfall);
			AnimPlayer = new AnimationPlayer(waterfall, AnimationPackage, 10, true, false, new Point(-20,10));
			playerAction = BaseBlock.ACTION_WATERFALL;
			PhysicsKey = "block12";
			
			ui.cacheAsBitmap = false;
		}
	}

}