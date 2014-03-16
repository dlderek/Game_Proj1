package Utils 
{
	import Box2D.Collision.b2Manifold;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Contacts.b2Contact;
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	import Component.Block.BaseBlock;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.setTimeout;
	import Manager.GameLoopManager;
	/**
	 * ...
	 * @author hello
	 */
	public class B2ContactListener extends b2ContactListener
	{
		public function B2ContactListener() 
		{
		}
		
		override public function BeginContact(contact:b2Contact):void
        {
			var A:b2Body = contact.GetFixtureA().GetBody();
			var B:b2Body = contact.GetFixtureB().GetBody();
			if (A == null || B == null)
				return;
			if (Contain("block", A, B) != null)
			{
				var target:b2Body = Contain("block", A, B);
				if(Contain("ceiling", A, B) !=null || Contain("left", A, B) != null || Contain("right", A, B) != null)
					GameLoopManager.Core.stage.dispatchEvent(new B2DestroyEvent(target));
			}
			if (Contain("player", A, B) != null)
			{
				var player:b2Body = Contain("player", A, B);
				var contact_point:b2Vec2 = contact.GetManifold().m_points[0].m_localPoint;
				var player_point:b2Vec2 = new b2Vec2(player.GetWorldPoint(contact_point).x * 30, player.GetWorldPoint(contact_point).y * 30);
				GameLoopManager.Core.stage.dispatchEvent(new PlayerCollideEvent(player.GetLinearVelocity().Length(), player_point));
				
				target = Contain("block", A, B);
				if (target != null && target.GetUserData().active)
				{
					target.GetUserData().active = false;
					trace((target.GetUserData().mc as BaseBlock).playerAction);
					switch((target.GetUserData().mc as BaseBlock).playerAction)
					{
						case BaseBlock.ACTION_STACK:
							
							var target_point:b2Vec2 = new b2Vec2(target.GetWorldPoint(contact_point).x * 30, target.GetWorldPoint(contact_point).y * 30);
							//if (player.GetPosition().y - target.GetPosition().y < -1)
							//{
								GameLoopManager.Core.stage.dispatchEvent(new B2PlayerStackEvent(target, target_point, player_point, target.GetUserData().mc.stackLevel ));
							//}
							
						break;
					case BaseBlock.ACTION_PAUSE:
							
							GameLoopManager.Core.stage.dispatchEvent(new B2PlayerPauseEvent(target));
							
						break;
					case BaseBlock.ACTION_NONE:
						
						break;
					case BaseBlock.ACTION_JUMP:
						
							GameLoopManager.Core.stage.dispatchEvent(new B2PlayerPlatformEvent());
						
						break;
					}
				}
			}
        }
		
		private function Contain(target:String, A:b2Body, B:b2Body):b2Body
		{
			if ((A.GetUserData().name as String).indexOf(target)!= -1)
				return A;
			else if ((B.GetUserData().name as String).indexOf(target)!= -1)
				return B;
			else
				return null;
		}
		
	}
}