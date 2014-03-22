package Utils 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.events.Event;
	/**
	 * ...
	 * @author hello
	 */
	public class B2PlayerStackEvent extends Event 
	{
		public var stackObject:b2Body;
		public var stackPoint:b2Vec2;
		public var playerPoint:b2Vec2;
		public var stackLevel:int;
		public function B2PlayerStackEvent( _stackObject:b2Body, _stackPoint:b2Vec2, _playerPoint:b2Vec2, _stackLevel:int) 
		{			
			super("B2PlayerStack");
			stackObject = _stackObject;
			stackPoint = _stackPoint;
			playerPoint = _playerPoint;
			stackLevel = _stackLevel;
		}
		
	}

}