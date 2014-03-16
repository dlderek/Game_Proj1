package Component.Block 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Component.BaseComponent;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author hello
	 */
	public class BaseBlock extends BaseComponent
	{
		public static const TYPE_free:String = "free";
		public static const TYPE_wall_L:String = "wall_L";
		public static const TYPE_wall_R:String = "wall_R";
		
		public static const ACTION_STACK:String = "stack";
		public static const ACTION_PAUSE:String = "pause";
		public static const ACTION_NONE:String = "none";
		public static const ACTION_JUMP:String = "jump";
		
		public var stackLevel:int;
		public var type:String = "free";
		public var playerAction:String = "stack";
		public var PhysicsKey:String;
		
		public function BaseBlock(ui:Object) 
		{
			super(ui);
		}
	}
}