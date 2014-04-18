package Component 
{
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2WeldJoint;
	import Box2D.Dynamics.Joints.b2WeldJointDef;
	import com.greensock.TweenLite;
	import com.greensock.TweenNano;
	import com.greensock.easing.Back;
	import Component.Block.*;
	import starling.display.Image;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
    import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchMarker;
	import starling.events.TouchPhase;
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;0
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
	//import flash.events.MouseEvent;
	//import flash.events.TouchEvent;
	//import flash.events.TransformGestureEvent;
	import flash.utils.*;
	import Manager.*;
	import Utils.*;
	import flash.sensors.Accelerometer;
	import flash.events.AccelerometerEvent;
	
    public class B2World extends Sprite {
		private var theAcc:Accelerometer = new Accelerometer();
		private var AccFactor:Number;
		private var lastShake:Number = 0;
		private var shakeWait:Number = 100;
		private var AccShakeEscapeSpeed:Number;
		
        public var world:b2World;
        public var world_scale:int=30;
        public var player:b2Body;
		public var blockUpSpeed:Number = -3;
		private var playerTouchForceLevel:Number;
		private var playerSwipeForceLevel:Number;
        public var force:b2Vec2;
		private var ContactListener:B2ContactListener;
		private var WorldCreateId:int = 0;
		public var BlockList:Vector.<b2Body> = new Vector.<b2Body>();
		public var DestroyList:Array = [];
		private var stackJoint:b2Joint;
		public var stackedLevel:int;
		public var proteted:Boolean;
		private var jam:Boolean;
		private var touchPoint:b2Vec2;
		private var getTouchTime:uint;
		private var fixTouchInterval:uint;
		private var unProtectTimeout:uint;
		
		private var waterFallPower:int;
		
		
		private const maxPlayHP:int = 10;
		private var playerHP:int = 10;
		
		private var pointerArrow:Arrow;
		
		//{ BasicSetup
        public function B2World():void {
			world=new b2World(new b2Vec2(0,XMLManager.config["WorldGravity"]), false);
			blockUpSpeed = XMLManager.config["blockUpSpeed"];
			playerTouchForceLevel = XMLManager.config["PlayerTouchForceLevel"];
			playerSwipeForceLevel = XMLManager.config["PlayerSwipeForceLevel"];
			waterFallPower = XMLManager.config["WaterFallPower"];
			AccFactor = XMLManager.config["AccFactor"];
			AccShakeEscapeSpeed = XMLManager.config["AccShakeEscapeSpeed"];
			pointerArrow = new Arrow();
			pointerArrow.alpha = 0.75;
			ContactListener = new B2ContactListener();
			world.SetContactListener(ContactListener);
			add_player(270, 150, new Character());
			this.addEventListener(Event.ADDED_TO_STAGE, onStage);
        }
		
		private function onStage(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			this.addEventListener(Event.REMOVED_FROM_STAGE, offStage);
		}
		
		private function offStage(e:Event):void
		{
			world.ClearForces();
			e.target.removeEventListener(e.type, arguments.callee);
			removeEventListener(Event.ENTER_FRAME, B2WorldUpdate);
			removeEventListener(Event.ENTER_FRAME, Update);
			GameLoopManager.Core.stage.removeEventListener("B2PlayerStack", PlayerStack);
			GameLoopManager.Core.stage.removeEventListener("B2PlayerUnStack", PlayerUnStack);
			removeEventListener(Event.ENTER_FRAME, DestroyBlockList);
			GameLoopManager.Core.stage.removeEventListener(TouchEvent.TOUCH, onSwipe);
			clearInterval(fixTouchInterval);
			GameLoopManager.Core.stage.removeEventListener(TouchEvent.TOUCH, onTouch);
			GameLoopManager.Core.stage.removeEventListener("B2PlayerUnStacked", PlyerUnStacked);
			GameLoopManager.Core.stage.removeEventListener("B2PlayerPause", onPlayerPause);
			GameLoopManager.Core.stage.removeEventListener("B2PlayerPlatform", onPlayerPlatform);
			GameLoopManager.Core.stage.removeEventListener("B2PlayerHitCeil", onPlayerHitCeil);
			GameLoopManager.Core.stage.removeEventListener("B2PlayerProtect", onPlayerProtect);
			GameLoopManager.Core.stage.removeEventListener("B2PlayerUnProtect", onPlayerUnProtect);
			clearTimeout(unProtectTimeout);
			GameLoopManager.Core.stage.removeEventListener("B2PlayerWaterFall", onPlayerWaterFall);
			GameLoopManager.Core.stage.removeEventListener("B2PlayerCatched", onPlayerCatched);
			theAcc.removeEventListener(AccelerometerEvent.UPDATE, onAccUpdate);
			theAcc.removeEventListener(AccelerometerEvent.UPDATE, onDeviceShake);
		}
		
		public function StartGame():void
		{
			addEventListener(Event.ENTER_FRAME, B2WorldUpdate);
			addEventListener(Event.ENTER_FRAME, Update);
			GameLoopManager.Core.stage.addEventListener("B2PlayerStack", PlayerStack);
			addEventListener(Event.ENTER_FRAME, DestroyBlockList);
			GameLoopManager.Core.stage.addEventListener("B2PlayerPause", onPlayerPause);
			GameLoopManager.Core.stage.addEventListener("B2PlayerPlatform", onPlayerPlatform);
			GameLoopManager.Core.stage.addEventListener("B2PlayerHitCeil", onPlayerHitCeil);
			GameLoopManager.Core.stage.addEventListener("B2PlayerProtect", onPlayerProtect);
			GameLoopManager.Core.stage.addEventListener("B2PlayerWaterFall", onPlayerWaterFall);
			GameLoopManager.Core.stage.addEventListener("B2PlayerCatched", onPlayerCatched);
			
			//PlayerControl
			if (int(XMLManager.config["ControlStyle"]) == 0)
			{
				theAcc.setRequestedUpdateInterval( 50 );
				if (Accelerometer.isSupported == true) 
				{
					theAcc.addEventListener(AccelerometerEvent.UPDATE, onAccUpdate);
					theAcc.addEventListener(AccelerometerEvent.UPDATE, onDeviceShake);
				}
				else
				{
					GameLoopManager.Core.stage.addEventListener(TouchEvent.TOUCH, onTouch);
					GameLoopManager.Core.stage.addEventListener(TouchEvent.TOUCH, onSwipe);
				}
			}
			else
			{
				GameLoopManager.Core.stage.addEventListener(TouchEvent.TOUCH, onTouch);
				GameLoopManager.Core.stage.addEventListener(TouchEvent.TOUCH, onSwipe);
			}
		}
		
		public function add_player(px:Number,py:Number, mc:DisplayObject):void {
            var my_body:b2BodyDef= new b2BodyDef();
            my_body.position.Set(px/world_scale, py/world_scale);
            my_body.type = b2Body.b2_dynamicBody;
			var my_circle:b2CircleShape = new b2CircleShape(30/ world_scale);
            var my_fixture:b2FixtureDef = new b2FixtureDef();
            my_fixture.shape = my_circle;
			my_fixture.restitution = XMLManager.config["PlayerRestitution"];
			my_fixture.density = XMLManager.config["PlayerDensity"];
            player=world.CreateBody(my_body);
            player.CreateFixture(my_fixture);
			player.SetLinearDamping(XMLManager.config["PlayerLinearDamping"]);
			player.SetAngularDamping(XMLManager.config["PlayerAngularDamping"]);
			player.SetUserData( { name:"player", mc:mc } );
			mc.x = px;
			mc.y = py;
			addChild(mc);
        }
		
		
		//{ UserControl
		
		private function onTouch(e:TouchEvent):void
		{
			if (stackedLevel > 0)
					return;
			var touch:Touch = e.getTouch(GameLoopManager.Core.stage);
			if (!touch)
				return;
			switch(touch.phase)
			{
				case TouchPhase.BEGAN:
					touchPoint = new b2Vec2(touch.globalX, touch.globalY);
					fixTouchInterval = setInterval(onArrowShow, 50);
					return;
					
				case TouchPhase.HOVER:
				case TouchPhase.ENDED:
					if (pointerArrow.parent)
						pointerArrow.parent.removeChild(pointerArrow);
					clearInterval(fixTouchInterval);
					return;
			}
			touchPoint = new b2Vec2(touch.globalX, touch.globalY);
		}
		
		private function onArrowShow():void
		{
			if (stackedLevel > 0)
				return;
			if (touchPoint.x > 300)
			{
				pointerArrow.x = 483.5;
				pointerArrow.y = 733.9;
				pointerArrow.scaleX = -1;
			}
			else
			{
				pointerArrow.x = 56.5;
				pointerArrow.y = 733.9;
				pointerArrow.scaleX = 1;
			}
			if (!pointerArrow.parent)
				this.addChild(pointerArrow);
			
			var side:int = touchPoint.x > 300?playerTouchForceLevel: -playerTouchForceLevel;
			player.ApplyImpulse(new b2Vec2(side, 0), player.GetPosition());
		}
		
		private function onSwipe(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(GameLoopManager.Core.stage);
			if (!touch)
				return;
			switch(touch.phase)
			{
				
			case TouchPhase.BEGAN:
				touchPoint = new b2Vec2(touch.globalX, touch.globalY);
				getTouchTime = getTimer();
				break;
				
			case TouchPhase.ENDED:
				if (getTimer() - getTouchTime > 1000)
					return;
				var endPoint:b2Vec2 = new b2Vec2(touch.globalX, touch.globalY);
				endPoint.Subtract(touchPoint);
				endPoint.Multiply(playerSwipeForceLevel);
				if (stackedLevel == 0)
					player.ApplyImpulse(new b2Vec2(endPoint.x / 10, -endPoint.y / 20), player.GetPosition());
				if (Math.abs(endPoint.x) > 10)
				{
					GameLoopManager.Core.stage.dispatchEvent(new B2PlayerUnStackEvent(endPoint));
				}
				break;
				
			}
		}
		
		private function onAccUpdate( e:AccelerometerEvent ):void 
		{
			player.ApplyImpulse(new b2Vec2(-AccFactor*e.accelerationX, 0), player.GetPosition());
		}
		
		private function onDeviceShake ( e:AccelerometerEvent ):void 
		{
			if(getTimer() - lastShake > shakeWait && (e.accelerationX >= 1.1 || e.accelerationY >= 1.1 || e.accelerationZ >= 1.1))
			{
				onShake(e.accelerationX);
				lastShake = getTimer();
			}
		}
		
		private function onShake(shakeLevel:Number):void
		{
			var speed:b2Vec2 = new b2Vec2((Math.random()>.5?-shakeLevel:shakeLevel) * AccShakeEscapeSpeed * 3, 0);
			if (stackedLevel == 0)
					player.ApplyImpulse(speed, player.GetPosition());
			else
				GameLoopManager.Core.stage.dispatchEvent(new B2PlayerUnStackEvent(speed));
		}
		
		//}
        
		
        //{ Update
        private function B2WorldUpdate(e:Event):void 
		{
			try
			{
				world.Step(1 / 30, 10, 10);
			}
			catch (e:Error)
			{trace("Error in B2WorldUpdate Catched : " + e.message)};
			
        }
		
		private function Update(e:Event):void
		{
			updatePlayerPosition();
			updateBlockList();
		}
		
		private function updatePlayerPosition():void
		{
			var playerPosition:b2Vec2 = player.GetPosition();
			if (playerPosition.y > 35 || playerPosition.y < 0)
				GameLoopManager.Core.stage.dispatchEvent(new Event("PlayerDie"));
			
			var mc:DisplayObject = player.GetUserData().mc;
			mc.x = player.GetPosition().x * world_scale;
			mc.y = player.GetPosition().y * world_scale;
			mc.rotation = player.GetAngle();
			if(playerHP < maxPlayHP)
				playerHP++;
		}
		
		private function updateBlockList():void
		{
			for each(var block:b2Body in BlockList)
			{
				var mc:BaseBlock = block.GetUserData().mc;
				mc.x = block.GetPosition().x * world_scale;
				mc.y = block.GetPosition().y * world_scale;
				
				if (mc.playerAction != BaseBlock.ACTION_FALL_AND_STACK)
				{
					block.SetLinearVelocity(new b2Vec2(0,blockUpSpeed));
					if (mc.playerAction == BaseBlock.ACTION_SLIDE || mc.playerAction == BaseBlock.ACTION_SLIDE_STACK)
					{
						var v:b2Vec2 = block.GetLinearVelocity();
						v.Add(new b2Vec2(mc.sided?3: -3, 0));
						if (mc.x < 0 )
							mc.sided = true;
						else if (mc.x > 600 - mc.width)
							mc.sided = false;
					}
					
					if (mc.y < -200)
					{
						if(stage)
							GameLoopManager.Core.stage.dispatchEvent(new B2DestroyEvent(block));
					}
				}
				else
				{
					block.SetLinearVelocity(new b2Vec2(0, 1));
					if (mc.y > 1050)
					{
						if(stage)
							GameLoopManager.Core.stage.dispatchEvent(new B2DestroyEvent(block));
					}
				}
			}
		}
		
		private function DestroyBlockList(e:Event):void
		{
			if (DestroyList.length > 0)
			{
				var body:* = DestroyList.shift();
				if (body is b2Body)
				{
					world.DestroyBody(body);
				}
				else if (body is b2Joint)
				{
					world.DestroyJoint(body);
				}
			}
		}
		//}
		
		
		//{ EventListenerTigger
		private function PlayerStack(e:B2PlayerStackEvent):void
		{
			if (proteted || stackedLevel > 0)
				return;
				
			SoundManager.PlaySound("mud");
			stackedLevel = e.stackLevel;
			var jointDef:b2WeldJointDef = new b2WeldJointDef();
			jointDef.Initialize(player, e.stackObject, e.stackPoint);
			jointDef.collideConnected = true;
			stackJoint = world.CreateJoint(jointDef) as b2WeldJoint;
			GameLoopManager.Core.stage.addEventListener("B2PlayerUnStack", PlayerUnStack);
			GameLoopManager.Core.stage.addEventListener("B2PlayerUnStacked", PlyerUnStacked);
		}
		
		private function PlayerUnStack(e:B2PlayerUnStackEvent):void
		{
			if (stackedLevel == 0)
				return;
				trace("hihi");
			stackedLevel--;
			if (stackedLevel <= 0)
			{
				GameLoopManager.Core.stage.dispatchEvent(new B2PlayerUnStackedEvent(e.escapV));
				GameLoopManager.Core.stage.removeEventListener("B2PlayerUnStack", PlayerUnStack);
			}
		}
		
		private function PlyerUnStacked(e:B2PlayerUnStackedEvent):void
		{
			stackedLevel = 0;
			SoundManager.PlaySound("escape");
			if(stackJoint)
				world.DestroyJoint(stackJoint);
			setTimeout(function():void
			{
				player.ApplyImpulse(new b2Vec2(e.escapV.x / 10, -e.escapV.y / 20), player.GetPosition());
			}, 50);
			GameLoopManager.Core.stage.removeEventListener("B2PlayerUnStacked", PlyerUnStacked);
		}
		
		private function onPlayerPause(e:B2PlayerPauseEvent):void
		{
			var mc:BaseBlock = e.body.GetUserData().mc;
			TweenLite.killTweensOf(mc);
			switch (mc.mode)
			{
				case 0:
					TweenNano.to(mc, 0.25, { rotation: mc.flip? -.1:.1, onComplete:function():void
					{
						TweenNano.killTweensOf(mc);
						TweenNano.to(mc, 0.25, { rotation:mc.flip? .1:-.1});
						BlockList.splice(BlockList.indexOf(e.body), 1);
						DestroyList.push(e.body);
						mc.addEventListener(Event.ENTER_FRAME, TweenMcAfterDestroyBody);
					}});
					break;
				case 1:
					BlockList.splice(BlockList.indexOf(e.body), 1);
					DestroyList.push(e.body);
					TweenNano.to(mc, 0.5, { y:mc.y + 100, alpha:0, ease:Back.easeIn, onComplete:function():void
					{
						if(mc.parent) 
							mc.parent.removeChild(mc);
					}});
					break;
			}
		}
		
		private function TweenMcAfterDestroyBody(e:Event):void
		{
			var target:DisplayObject = e.target as DisplayObject;
			target.y += blockUpSpeed;
			target.alpha -= 0.01;
			if (target.alpha <=0)
			{
				target.removeEventListener(e.type, arguments.callee);
				if(target.parent)
					target.parent.removeChild(target);
			}
		}
		
		private function onPlayerPlatform(e:B2PlayerPlatformEvent):void
		{
			//jump effect
			if (stackedLevel > 0)
				return;
			var normal:b2Vec2 = e.planeNormal.Copy();
			if (normal.y > -0.5)
				return;
			var v:b2Vec2 = player.GetLinearVelocity();
			v.MulM(new b2Mat22(1,0,0,-1));
			if (v.y > -12)
				v.y = -12;
			v.y *= -normal.y;
		}
		
		private function onPlayerHitCeil(e:B2PlayerHitCeilEvent):void
		{
			player.GetLinearVelocity().MulM(new b2Mat22(1,0,0,-0.5 ));
			playerHP -= 8;
			if (stackedLevel > 0)
				GameLoopManager.Core.stage.dispatchEvent(new Event("PlayerDie"));
			if (playerHP <= 0)
					GameLoopManager.Core.stage.dispatchEvent(new Event("PlayerDie"));
		}
		
		private function onPlayerProtect(e:B2PlayerProtectEvent):void
		{
			var mc:Character = player.GetUserData().mc as Character;
			var child:DisplayObject = mc.getChildByName("protect");
			if(child != null)
			{
				mc.removeChild(child);
			}
			
			proteted = true;
			var protect:Protect = new Protect();
			protect.name = "protect";
			mc.addChild(protect);
			GameLoopManager.Core.stage.addEventListener("B2PlayerUnProtect", onPlayerUnProtect);
			unProtectTimeout = setTimeout(unProtectDispatchEvent, 5000);
			GameLoopManager.Core.stage.dispatchEvent(new B2PlayerUnStackedEvent(new b2Vec2()));
			
			SoundManager.PlaySound("protect");
		}
		
		private function unProtectDispatchEvent():void
		{
			if(GameLoopManager.Core.stage)
				GameLoopManager.Core.stage.dispatchEvent(new B2PlayerUnProtectEvent());
		}
		
		private function onPlayerUnProtect(e:B2PlayerUnProtectEvent):void
		{
			var mc:Character = player.GetUserData().mc as Character;
			var child:DisplayObject = mc.getChildByName("protect");
			if(child != null)
			{
				mc.removeChild(child);
			}
			proteted = false;
		}
		
		private function onPlayerWaterFall(e:B2PlayerWaterFallEvent):void
		{
			SoundManager.PlaySound("waterfall");
			e.waterFall.SetActive(false);
			player.GetLinearVelocity().Add(new b2Vec2(0, waterFallPower));
			BlockList.splice(BlockList.indexOf(e.waterFall), 1);
			DestroyList.push(e.waterFall);
			e.waterFall.GetUserData().mc.addEventListener(Event.ENTER_FRAME, TweenMcAfterDestroyBody);
		}
		
		private function onPlayerCatched(e:B2PlayerCatchedEvent):void
		{
			if (proteted)
			{
				GameLoopManager.Core.stage.dispatchEvent(new B2DestroyEvent(e.stackObject));
				return;
			}
			GameLoopManager.Core.stage.dispatchEvent(new B2DestroyEvent(e.stackObject));
			stackedLevel = e.stackLevel;
			GameLoopManager.Core.stage.addEventListener("B2PlayerUnStack", PlayerUnStack);
			GameLoopManager.Core.stage.addEventListener("B2PlayerUnStacked", PlyerUnStacked);
		}
		
		//}
    }
}