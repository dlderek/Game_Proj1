package View 
{
	import flash.display.DisplayObject;
	import Manager.LoadingManager;
	/**
	 * ...
	 * @author JL
	 */
	public class BaseView 
	{
		public static var ViewList:Vector.<BaseView> = new Vector.<BaseView>();
		
		public function BaseView() 
		{
			ViewList.push(this);
		}
		
	}

}