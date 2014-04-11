package Component 
{
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.display.DisplayObject;
	import Manager.LoadingManager;
	import Utils.BTool;
	/**
	 * ...
	 * @author JL
	 */
	public class Protect extends BaseComponent
	{
		private static var bmd:Texture;
		public function Protect() 
		{
			if (!bmd)
				bmd = BTool.GetImage("BattlePage_element", "protect");
			var item:Image = new Image(bmd);
			item.x -= item.width / 2;
			item.y -= item.height / 2;
			super(item);
		}
		
	}

}