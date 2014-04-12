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
	import starling.events.Event;
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
			var player:b2Body = Contain("player", A, B);
			var target:b2Body = Contain("block", A, B);
			
			PlayerPack: if (player != null)
			{
				if (target != null && target.GetUserData().active)
				{
					var contact_point:b2Vec2 = contact.GetManifold().m_points[0].m_localPoint;
					var player_point:b2Vec2 = new b2Vec2(player.GetWorldPoint(contact_point).x * 30, player.GetWorldPoint(contact_point).y * 30);
					
					switch((target.GetUserData().mc as BaseBlock).playerAction)
					{
						case BaseBlock.ACTION_SLIDE_STACK:
						case BaseBlock.ACTION_STACK:
							var planeNormal:b2Vec2 = contact.GetManifold().m_localPlaneNormal;
							if (planeNormal.y < -0.8)
							{
								target.GetUserData().active = false;
								var target_point:b2Vec2 = new b2Vec2(target.GetWorldPoint(contact_point).x * 30, target.GetWorldPoint(contact_point).y * 30);
								//if (player.GetPosition().y - target.GetPosition().y < -1)
								//{
									GameLoopManager.Core.stage.dispatchEvent(new B2PlayerStackEvent(target, target_point, player_point, target.GetUserData().mc.stackLevel ));
								//}
							}
							
						return;
						
					case BaseBlock.ACTION_WATERFALL:
						GameLoopManager.Core.stage.dispatchEvent(new B2PlayerWaterFallEvent(target));
						break PlayerPack;
						
						case BaseBlock.ACTION_PAUSE:
								target.GetUserData().active = false;
								GameLoopManager.Core.stage.dispatchEvent(new B2PlayerPauseEvent(target));
								
							break;
						case BaseBlock.ACTION_NONE:
							
							break;
						case BaseBlock.ACTION_JUMP:
						case BaseBlock.ACTION_SLIDE:
								GameLoopManager.Core.stage.dispatchEvent(new B2PlayerPlatformEvent(contact.GetManifold().m_localPlaneNormal));
							break;
						case BaseBlock.ACTION_GET:
								GameLoopManager.Core.stage.dispatchEvent(new B2DestroyEvent(target));
								GameLoopManager.Core.stage.dispatchEvent(new PlayerCollectionEvent(player_point));
							return; // don't trigger the playerCollideEvent
						case BaseBlock.ACTION_PROTECT:
								GameLoopManager.Core.stage.dispatchEvent(new B2DestroyEvent(target));
								GameLoopManager.Core.stage.dispatchEvent(new B2PlayerProtectEvent());
							return; // don't trigger the playerCollideEvent
					}
					GameLoopManager.Core.stage.dispatchEvent(new PlayerCollideEvent(player.GetLinearVelocity().Length(), player_point, target ));
				}
				
				target = Contain("ceiling", A, B);
				if (target != null)
					GameLoopManager.Core.stage.dispatchEvent(new B2PlayerHitCeilEvent());
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