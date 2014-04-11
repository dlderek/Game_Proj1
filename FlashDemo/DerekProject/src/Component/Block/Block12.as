package Component.Block 
{
	import Control.AnimationPlayer;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.display.Sprite;
	import flash.geom.Point;
	import Manager.LoadingManager;
	import Utils.BTool;
	/**
	 * ...
	 * @author hello
	 */
	public class Block12 extends BaseBlock
	{
		private static var bmd:Texture;
		private var waterfall:Sprite;
		private static var AnimationPackage:Vector.<Texture>;
		private var AnimPlayer:AnimationPlayer;
		
		public function Block12() 
		{
			if (!bmd)
				bmd = BTool.GetImage("BattlePage_element", "block12");
			if (!AnimationPackage)
				AnimationPackage = BTool.GetImagePackage("waterfall", "waterfall");
				
			super(new Image(bmd));
				
			waterfall = new Sprite(); 
			waterfall.scaleX = 3;
			this.addChild(waterfall);
			AnimPlayer = new AnimationPlayer(waterfall, BTool.CloneBitmaps(AnimationPackage), 10, true, false, new Point(-20,10));
			playerAction = BaseBlock.ACTION_WATERFALL;
			PhysicsKey = "block12";
		}
	}

}