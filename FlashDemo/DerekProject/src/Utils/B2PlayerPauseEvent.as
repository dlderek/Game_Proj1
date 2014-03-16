package Utils 
{
	import Box2D.Dynamics.b2Body;
	import flash.events.Event;
	/**
	 * ...
	 * @author JL
	 */
	public class B2PlayerPauseEvent extends Event
	{
		public var body:b2Body;
		public function B2PlayerPauseEvent(_body:b2Body) 
		{
			body = _body;
			super("B2PlayerPause");
		}
		
	}

}