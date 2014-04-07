package Utils 
{
	import Box2D.Dynamics.b2Body;
	import flash.events.Event;
	/**
	 * ...
	 * @author JL
	 */
	public class B2PlayerWaterFallEvent extends Event
	{
		public var waterFall:b2Body;
		
		public function B2PlayerWaterFallEvent(_waterFall:b2Body) 
		{
			waterFall = _waterFall;
			super("B2PlayerWaterFall");
		}
		
	}

}