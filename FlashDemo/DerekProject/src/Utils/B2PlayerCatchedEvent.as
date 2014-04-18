package Utils 
{
	import Box2D.Dynamics.b2Body;
	import starling.events.Event;
	/**
	 * ...
	 * @author hello
	 */
	public class B2PlayerCatchedEvent extends Event
	{
		public var stackLevel:int;
		public var stackObject:b2Body;
		public function B2PlayerCatchedEvent(stackObject:b2Body, stackLevel:int) 
		{
			super("B2PlayerCatched");
			this.stackLevel = stackLevel;
			this.stackObject = stackObject;
		}
		
	}

}