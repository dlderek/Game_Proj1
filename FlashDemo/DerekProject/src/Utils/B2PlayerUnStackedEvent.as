package Utils 
{
	import Box2D.Common.Math.b2Vec2;
	import starling.events.Event;
	/**
	 * ...
	 * @author hello
	 */
	public class B2PlayerUnStackedEvent extends Event
	{
		public var escapV:b2Vec2;
		public function B2PlayerUnStackedEvent(_escapV:b2Vec2) 
		{
			super("B2PlayerUnStacked");
			escapV = _escapV;
		}
		
	}

}