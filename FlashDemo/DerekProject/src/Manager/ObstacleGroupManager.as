package Manager 
{
	import Component.Block.PhysicsData;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author hello
	 */
	public class ObstacleGroupManager 
	{
		public static var ObstacleGroup:Vector.<Array>;
		public static var PhyData:PhysicsData = new PhysicsData();
		
		public static function init(OG:XML):void
		{
			ObstacleGroup = new Vector.<Array>();
			for each(var group:XML in OG.*)
			{
				var newGroup:Array = [];
				for each(var block:XML in group.*)
				{
					var newBlock:Object = { };
					newBlock.name = (block.name().localName as String).replace("block", "Block").replace("coll", "Coll");
					newBlock.x = Number(block.x);
					newBlock.y = Number(block.y);
					newGroup.push(newBlock);
				}
				ObstacleGroup.push(newGroup);
			}
		}
		
	}

}