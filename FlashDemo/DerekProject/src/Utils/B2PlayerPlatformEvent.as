package Utils 
{
	import Box2D.Common.Math.b2Vec2;
	import flash.events.Event;
	/**
	 * ...
	 * @author JL
	 */
	public class B2PlayerPlatformEvent extends Event
	{
		public var planeNormal:b2Vec2;
		public function B2PlayerPlatformEvent(planeNormal:b2Vec2) 
		{
			this.planeNormal = planeNormal;
			super("B2PlayerPlatform");
		}
		
	}

}