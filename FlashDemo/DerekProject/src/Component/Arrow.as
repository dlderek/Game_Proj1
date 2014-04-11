package Component 
{
	import Manager.LoadingManager;
	import starling.display.Image;
	import Utils.BTool;
	/**
	 * ...
	 * @author JL
	 */
	public class Arrow extends BaseComponent
	{
		
		public function Arrow() 
		{
			super(new Image(BTool.GetImage("BattlePage_element", "arrow")));
		}
		
	}

}