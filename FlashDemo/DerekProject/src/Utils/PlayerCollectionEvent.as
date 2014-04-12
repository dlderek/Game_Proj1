package Utils 
{
	import Box2D.Common.Math.b2Vec2;
	import starling.events.Event;
	/**
	 * ...
	 * @author hello
	 */
	public class PlayerCollectionEvent extends Event
	{
		public var collectionPoint:b2Vec2;
		public function PlayerCollectionEvent(collectionPoint:b2Vec2) 
		{
			this.collectionPoint = collectionPoint;
			super("PlayerCollection");
		}
		
	}

}