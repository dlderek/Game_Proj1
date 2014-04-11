package Component.Block 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import starling.display.Image;
	import starling.textures.Texture;
	import Manager.LoadingManager;
	import Box2D.Dynamics.b2Body;
	import Utils.BTool;
	/**
	 * ...
	 * @author hello
	 */
	public class Block1 extends BaseBlock
	{
		private static var bmd:Texture;
		public function Block1() 
		{
			if (!bmd)
				bmd = BTool.GetImage("BattlePage_element", "block1");
			super(new Image(bmd));
			stackLevel = 0;
			playerAction = BaseBlock.ACTION_JUMP;
			PhysicsKey = "block1";
		}
	}
}