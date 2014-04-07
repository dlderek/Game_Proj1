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
		public static var obstacleGroup:XML;
		public static var obstacleGroup2:XML;
		
		public static function set ObstacleGroup(OG:XML):void
		{
			obstacleGroup = OG;
		}
		
		public static function set ObstacleGroup2(OG:XML):void
		{
			obstacleGroup2 = OG;
		}
	}

}