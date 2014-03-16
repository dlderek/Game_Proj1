package Component.Block 
{
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
    import flash.utils.Dictionary;

    public class PhysicsData extends Object
	{
		// ptm ratio
        public var ptm_ratio:Number = 30;
		
		// the physcis data 
		private var dict:Dictionary;
		
        //
        // bodytype:
        //  b2_staticBody
        //  b2_kinematicBody
        //  b2_dynamicBody

        public function createBody(name:String, world:b2World, bodyType:uint, userData:*):b2Body
        {
            var fixtures:Array = dict[name];

            var body:b2Body;
            var f:Number;

            // prepare body def
            var bodyDef:b2BodyDef = new b2BodyDef();
            bodyDef.type = bodyType;
            bodyDef.userData = userData;

            // create the body
            body = world.CreateBody(bodyDef);

            // prepare fixtures
            for(f=0; f<fixtures.length; f++)
            {
                var fixture:Array = fixtures[f];

                var fixtureDef:b2FixtureDef = new b2FixtureDef();

                fixtureDef.density=fixture[0];
                fixtureDef.friction=fixture[1];
                fixtureDef.restitution=fixture[2];

                fixtureDef.filter.categoryBits = fixture[3];
                fixtureDef.filter.maskBits = fixture[4];
                fixtureDef.filter.groupIndex = fixture[5];
                fixtureDef.isSensor = fixture[6];

                if(fixture[7] == "POLYGON")
                {                    
                    var p:Number;
                    var polygons:Array = fixture[8];
                    for(p=0; p<polygons.length; p++)
                    {
                        var polygonShape:b2PolygonShape = new b2PolygonShape();
                        polygonShape.SetAsArray(polygons[p], polygons[p].length);
                        fixtureDef.shape=polygonShape;

                        body.CreateFixture(fixtureDef);
                    }
                }
                else if(fixture[7] == "CIRCLE")
                {
                    var circleShape:b2CircleShape = new b2CircleShape(fixture[9]);                    
                    circleShape.SetLocalPosition(fixture[8]);
                    fixtureDef.shape=circleShape;
                    body.CreateFixture(fixtureDef);                    
                }                
            }

            return body;
        }

		
        public function PhysicsData(): void
		{
			dict = new Dictionary();
			

			dict["block1"] = [

										[
											// density, friction, restitution
                                            1, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(45/ptm_ratio, 96/ptm_ratio)  ,  new b2Vec2(36/ptm_ratio, 48/ptm_ratio)  ,  new b2Vec2(156/ptm_ratio, 46/ptm_ratio)  ]
											]

										]
 ,
										[
											// density, friction, restitution
                                            1, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(48/ptm_ratio, 96/ptm_ratio)  ,  new b2Vec2(156/ptm_ratio, 44/ptm_ratio)  ,  new b2Vec2(143/ptm_ratio, 98/ptm_ratio)  ]
											]

										]

									];

			dict["block2"] = [

										[
											// density, friction, restitution
                                            1, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(45/ptm_ratio, 96/ptm_ratio)  ,  new b2Vec2(36/ptm_ratio, 48/ptm_ratio)  ,  new b2Vec2(156/ptm_ratio, 46/ptm_ratio)  ]
											]

										]
 ,
										[
											// density, friction, restitution
                                            1, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(48/ptm_ratio, 96/ptm_ratio)  ,  new b2Vec2(156/ptm_ratio, 44/ptm_ratio)  ,  new b2Vec2(143/ptm_ratio, 98/ptm_ratio)  ]
											]

										]
									];

			dict["block3"] = [

										[
											// density, friction, restitution
                                            1, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(45/ptm_ratio, 96/ptm_ratio)  ,  new b2Vec2(36/ptm_ratio, 48/ptm_ratio)  ,  new b2Vec2(156/ptm_ratio, 46/ptm_ratio)  ]
											]

										]
 ,
										[
											// density, friction, restitution
                                            1, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(48/ptm_ratio, 96/ptm_ratio)  ,  new b2Vec2(156/ptm_ratio, 44/ptm_ratio)  ,  new b2Vec2(143/ptm_ratio, 98/ptm_ratio)  ]
											]

										]

									];
			dict["block7"] = [

										[
											// density, friction, restitution
                                            100, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(103/ptm_ratio, 312/ptm_ratio)  ,  new b2Vec2(111/ptm_ratio, 296/ptm_ratio)  ,  new b2Vec2(334/ptm_ratio, 369/ptm_ratio)  ]
											]

										]
 ,
										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(338/ptm_ratio, 389/ptm_ratio)  ,  new b2Vec2(106/ptm_ratio, 312/ptm_ratio)  ,  new b2Vec2(335/ptm_ratio, 369/ptm_ratio)  ]
											]

										]

									];

			dict["block6"] = [

										[
											// density, friction, restitution
                                            100, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(88/ptm_ratio, 27.5/ptm_ratio)  ,  new b2Vec2(145/ptm_ratio, 39/ptm_ratio)  ,  new b2Vec2(298/ptm_ratio, 145/ptm_ratio)  ,  new b2Vec2(243/ptm_ratio, 139.5/ptm_ratio)  ,  new b2Vec2(132.5/ptm_ratio, 105/ptm_ratio)  ,  new b2Vec2(92.5/ptm_ratio, 75/ptm_ratio)  ,  new b2Vec2(75.5/ptm_ratio, 57/ptm_ratio)  ,  new b2Vec2(70.5/ptm_ratio, 45/ptm_ratio)  ] ,
                                                [   new b2Vec2(324/ptm_ratio, 2/ptm_ratio)  ,  new b2Vec2(324/ptm_ratio, 154/ptm_ratio)  ,  new b2Vec2(281/ptm_ratio, 32/ptm_ratio)  ,  new b2Vec2(303/ptm_ratio, 6/ptm_ratio)  ] ,
                                                [   new b2Vec2(324/ptm_ratio, 154/ptm_ratio)  ,  new b2Vec2(231/ptm_ratio, 60/ptm_ratio)  ,  new b2Vec2(281/ptm_ratio, 32/ptm_ratio)  ] ,
                                                [   new b2Vec2(132.5/ptm_ratio, 105/ptm_ratio)  ,  new b2Vec2(243/ptm_ratio, 139.5/ptm_ratio)  ,  new b2Vec2(154/ptm_ratio, 146.5/ptm_ratio)  ,  new b2Vec2(128.5/ptm_ratio, 129/ptm_ratio)  ,  new b2Vec2(126.5/ptm_ratio, 120/ptm_ratio)  ] ,
                                                [   new b2Vec2(145/ptm_ratio, 39/ptm_ratio)  ,  new b2Vec2(88/ptm_ratio, 27.5/ptm_ratio)  ,  new b2Vec2(107/ptm_ratio, 25/ptm_ratio)  ,  new b2Vec2(124/ptm_ratio, 27/ptm_ratio)  ] ,
                                                [   new b2Vec2(324/ptm_ratio, 154/ptm_ratio)  ,  new b2Vec2(206/ptm_ratio, 62/ptm_ratio)  ,  new b2Vec2(231/ptm_ratio, 60/ptm_ratio)  ] ,
                                                [   new b2Vec2(324/ptm_ratio, 154/ptm_ratio)  ,  new b2Vec2(298/ptm_ratio, 145/ptm_ratio)  ,  new b2Vec2(181/ptm_ratio, 61/ptm_ratio)  ,  new b2Vec2(206/ptm_ratio, 62/ptm_ratio)  ] ,
                                                [   new b2Vec2(181/ptm_ratio, 61/ptm_ratio)  ,  new b2Vec2(298/ptm_ratio, 145/ptm_ratio)  ,  new b2Vec2(145/ptm_ratio, 39/ptm_ratio)  ]
											]

										]

									];

			dict["block4"] = [

										[
											// density, friction, restitution
                                            100, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(9/ptm_ratio, 2/ptm_ratio)  ,  new b2Vec2(86/ptm_ratio, 139.5/ptm_ratio)  ,  new b2Vec2(8/ptm_ratio, 154/ptm_ratio)  ] ,
                                                [   new b2Vec2(9/ptm_ratio, 2/ptm_ratio)  ,  new b2Vec2(28/ptm_ratio, 7/ptm_ratio)  ,  new b2Vec2(73/ptm_ratio, 46/ptm_ratio)  ,  new b2Vec2(175/ptm_ratio, 144/ptm_ratio)  ,  new b2Vec2(86/ptm_ratio, 139.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(241/ptm_ratio, 27.5/ptm_ratio)  ,  new b2Vec2(254.5/ptm_ratio, 38/ptm_ratio)  ,  new b2Vec2(235/ptm_ratio, 76.5/ptm_ratio)  ,  new b2Vec2(195.5/ptm_ratio, 107/ptm_ratio)  ,  new b2Vec2(148/ptm_ratio, 61/ptm_ratio)  ,  new b2Vec2(174/ptm_ratio, 45/ptm_ratio)  ,  new b2Vec2(211/ptm_ratio, 24.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(235/ptm_ratio, 76.5/ptm_ratio)  ,  new b2Vec2(254.5/ptm_ratio, 38/ptm_ratio)  ,  new b2Vec2(258.5/ptm_ratio, 47/ptm_ratio)  ] ,
                                                [   new b2Vec2(195.5/ptm_ratio, 107/ptm_ratio)  ,  new b2Vec2(200.5/ptm_ratio, 128/ptm_ratio)  ,  new b2Vec2(175/ptm_ratio, 144/ptm_ratio)  ,  new b2Vec2(105/ptm_ratio, 62/ptm_ratio)  ,  new b2Vec2(148/ptm_ratio, 61/ptm_ratio)  ] ,
                                                [   new b2Vec2(200.5/ptm_ratio, 128/ptm_ratio)  ,  new b2Vec2(195.5/ptm_ratio, 107/ptm_ratio)  ,  new b2Vec2(202.5/ptm_ratio, 122/ptm_ratio)  ] ,
                                                [   new b2Vec2(175/ptm_ratio, 144/ptm_ratio)  ,  new b2Vec2(73/ptm_ratio, 46/ptm_ratio)  ,  new b2Vec2(105/ptm_ratio, 62/ptm_ratio)  ]
											]

										]

									];

			dict["block5"] = [

										[
											// density, friction, restitution
                                            100, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(16/ptm_ratio, 387/ptm_ratio)  ,  new b2Vec2(16/ptm_ratio, 370/ptm_ratio)  ,  new b2Vec2(238/ptm_ratio, 298/ptm_ratio)  ]
											]

										]
 ,
										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(245/ptm_ratio, 314/ptm_ratio)  ,  new b2Vec2(18/ptm_ratio, 384/ptm_ratio)  ,  new b2Vec2(240/ptm_ratio, 295/ptm_ratio)  ]
											]

										]

									];
			dict["block8"] = [

										[
											// density, friction, restitution
                                            100, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(157.5/ptm_ratio, 400/ptm_ratio)  ,  new b2Vec2(90.5/ptm_ratio, 396/ptm_ratio)  ,  new b2Vec2(45.5/ptm_ratio, 339/ptm_ratio)  ,  new b2Vec2(86/ptm_ratio, 221/ptm_ratio)  ,  new b2Vec2(187/ptm_ratio, 275/ptm_ratio)  ,  new b2Vec2(200/ptm_ratio, 350/ptm_ratio)  ] ,
                                                [   new b2Vec2(115/ptm_ratio, 450/ptm_ratio)  ,  new b2Vec2(90.5/ptm_ratio, 396/ptm_ratio)  ,  new b2Vec2(157.5/ptm_ratio, 400/ptm_ratio)  ,  new b2Vec2(138/ptm_ratio, 453/ptm_ratio)  ] ,
                                                [   new b2Vec2(86/ptm_ratio, 221/ptm_ratio)  ,  new b2Vec2(105.5/ptm_ratio, 173/ptm_ratio)  ,  new b2Vec2(165.5/ptm_ratio, 113/ptm_ratio)  ,  new b2Vec2(187/ptm_ratio, 275/ptm_ratio)  ] ,
                                                [   new b2Vec2(117.5/ptm_ratio, 77/ptm_ratio)  ,  new b2Vec2(134/ptm_ratio, 37.5/ptm_ratio)  ,  new b2Vec2(135/ptm_ratio, 37.5/ptm_ratio)  ,  new b2Vec2(165.5/ptm_ratio, 113/ptm_ratio)  ,  new b2Vec2(105.5/ptm_ratio, 173/ptm_ratio)  ]
											]

										]

									];

		}
	}
}
