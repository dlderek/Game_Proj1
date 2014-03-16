package Utils 
{
	import flash.events.Event;
	import Box2D.Common.Math.b2Vec2;
	/**
	 * ...
	 * @author hello
	 */
	public class B2PlayerUnStackEvent extends Event
	{
		public var escapV:b2Vec2;
		public function B2PlayerUnStackEvent(_escapV:b2Vec2 ) 
		{
			super("B2PlayerUnStack");
			escapV = _escapV;
		}
		
	}

}