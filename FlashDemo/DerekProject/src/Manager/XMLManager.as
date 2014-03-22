package Manager 
{
	/**
	 * ...
	 * @author JL
	 */
	public class XMLManager 
	{
		public static var config:XML;
		public static var files:XML;
		private static var obstacleGroup:XML;
		
		public static function set ObstacleGroup(OG:XML):void
		{
			obstacleGroup = OG;
			ObstacleGroupManager.init(obstacleGroup);
		}
	}

}