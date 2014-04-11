package Utils 
{
	import Box2D.Dynamics.b2Body;
	import starling.events.Event;
	/**
	 * ...
	 * @author hello
	 */
	public class B2DestroyEvent extends Event
	{
		public var DestroyBody:b2Body;
		public function B2DestroyEvent(_DestroyBody:b2Body) 
		{
			super("B2Destroy");
			DestroyBody = _DestroyBody;
		}
	}
}