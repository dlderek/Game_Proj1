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
			
			dict["collection"] = [

										[
											// density, friction, restitution
                                            0.01, 0.2, 0.5,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(39/ptm_ratio, 58/ptm_ratio)  ,  new b2Vec2(47/ptm_ratio, 38/ptm_ratio)  ,  new b2Vec2(123/ptm_ratio, 82/ptm_ratio)  ,  new b2Vec2(114.967460632324/ptm_ratio, 102.991325378418/ptm_ratio)  ]
											]

										]

									];
			

			dict["block1"] = [

										[
											// density, friction, restitution
                                            0, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(10/ptm_ratio, 17/ptm_ratio)  ,  new b2Vec2(161/ptm_ratio, 19/ptm_ratio)  ,  new b2Vec2(165/ptm_ratio, 52/ptm_ratio)  ,  new b2Vec2(20/ptm_ratio, 45/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 35/ptm_ratio)  ] ,
                                                [   new b2Vec2(165/ptm_ratio, 52/ptm_ratio)  ,  new b2Vec2(161/ptm_ratio, 19/ptm_ratio)  ,  new b2Vec2(180/ptm_ratio, 30/ptm_ratio)  ]
											]

										]

									];

			dict["block2"] = [

										[
											// density, friction, restitution
                                            0, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(161/ptm_ratio, 54/ptm_ratio)  ,  new b2Vec2(86/ptm_ratio, 59/ptm_ratio)  ,  new b2Vec2(12/ptm_ratio, 52/ptm_ratio)  ,  new b2Vec2(-1/ptm_ratio, 40/ptm_ratio)  ,  new b2Vec2(6/ptm_ratio, 25/ptm_ratio)  ,  new b2Vec2(161/ptm_ratio, 24/ptm_ratio)  ,  new b2Vec2(175/ptm_ratio, 40/ptm_ratio)  ]
											]

										]

									];

			dict["block3"] = [

										[
											// density, friction, restitution
                                            99, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(23/ptm_ratio, 20/ptm_ratio)  ,  new b2Vec2(174/ptm_ratio, 20/ptm_ratio)  ,  new b2Vec2(181/ptm_ratio, 36/ptm_ratio)  ,  new b2Vec2(163/ptm_ratio, 47/ptm_ratio)  ,  new b2Vec2(19/ptm_ratio, 53/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 31/ptm_ratio)  ]
											]

										]

									];

			dict["block4"] = [

										[
											// density, friction, restitution
                                            99, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(237.5/ptm_ratio, 90/ptm_ratio)  ,  new b2Vec2(218/ptm_ratio, 112.5/ptm_ratio)  ,  new b2Vec2(177/ptm_ratio, 143.5/ptm_ratio)  ,  new b2Vec2(63/ptm_ratio, 179.5/ptm_ratio)  ,  new b2Vec2(12/ptm_ratio, 175.5/ptm_ratio)  ,  new b2Vec2(121/ptm_ratio, 79.5/ptm_ratio)  ,  new b2Vec2(225/ptm_ratio, 56.5/ptm_ratio)  ,  new b2Vec2(237.5/ptm_ratio, 72/ptm_ratio)  ] ,
                                                [   new b2Vec2(153/ptm_ratio, 195.5/ptm_ratio)  ,  new b2Vec2(63/ptm_ratio, 179.5/ptm_ratio)  ,  new b2Vec2(177/ptm_ratio, 143.5/ptm_ratio)  ,  new b2Vec2(185/ptm_ratio, 163.5/ptm_ratio)  ,  new b2Vec2(183.5/ptm_ratio, 179/ptm_ratio)  ] ,
                                                [   new b2Vec2(225/ptm_ratio, 56.5/ptm_ratio)  ,  new b2Vec2(121/ptm_ratio, 79.5/ptm_ratio)  ,  new b2Vec2(173/ptm_ratio, 53.5/ptm_ratio)  ,  new b2Vec2(203/ptm_ratio, 47.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(12/ptm_ratio, 175.5/ptm_ratio)  ,  new b2Vec2(97/ptm_ratio, 83.5/ptm_ratio)  ,  new b2Vec2(121/ptm_ratio, 79.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(12/ptm_ratio, 175.5/ptm_ratio)  ,  new b2Vec2(67/ptm_ratio, 77.5/ptm_ratio)  ,  new b2Vec2(97/ptm_ratio, 83.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(12/ptm_ratio, 175.5/ptm_ratio)  ,  new b2Vec2(37.5/ptm_ratio, 62/ptm_ratio)  ,  new b2Vec2(67/ptm_ratio, 77.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(12/ptm_ratio, 175.5/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 178.5/ptm_ratio)  ,  new b2Vec2(5/ptm_ratio, 15.5/ptm_ratio)  ,  new b2Vec2(37.5/ptm_ratio, 62/ptm_ratio)  ] ,
                                                [   new b2Vec2(0/ptm_ratio, 178.5/ptm_ratio)  ,  new b2Vec2(0.5/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(5/ptm_ratio, 15.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(0.5/ptm_ratio, 0/ptm_ratio)  ,  new b2Vec2(0.5/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 178.5/ptm_ratio)  ]
											]

										]

									];

			dict["block5"] = [

										[
											// density, friction, restitution
                                            99, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(176/ptm_ratio, 179.5/ptm_ratio)  ,  new b2Vec2(239.5/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(239.5/ptm_ratio, 178/ptm_ratio)  ] ,
                                                [   new b2Vec2(14/ptm_ratio, 56.5/ptm_ratio)  ,  new b2Vec2(51/ptm_ratio, 49.5/ptm_ratio)  ,  new b2Vec2(114/ptm_ratio, 78.5/ptm_ratio)  ,  new b2Vec2(176/ptm_ratio, 179.5/ptm_ratio)  ,  new b2Vec2(63/ptm_ratio, 145.5/ptm_ratio)  ,  new b2Vec2(21/ptm_ratio, 112.5/ptm_ratio)  ,  new b2Vec2(1.5/ptm_ratio, 90/ptm_ratio)  ,  new b2Vec2(1.5/ptm_ratio, 72/ptm_ratio)  ] ,
                                                [   new b2Vec2(53.5/ptm_ratio, 165/ptm_ratio)  ,  new b2Vec2(63/ptm_ratio, 145.5/ptm_ratio)  ,  new b2Vec2(176/ptm_ratio, 179.5/ptm_ratio)  ,  new b2Vec2(86/ptm_ratio, 195.5/ptm_ratio)  ,  new b2Vec2(56/ptm_ratio, 180.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(51/ptm_ratio, 49.5/ptm_ratio)  ,  new b2Vec2(14/ptm_ratio, 56.5/ptm_ratio)  ,  new b2Vec2(33/ptm_ratio, 47.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(141/ptm_ratio, 83.5/ptm_ratio)  ,  new b2Vec2(176/ptm_ratio, 179.5/ptm_ratio)  ,  new b2Vec2(114/ptm_ratio, 78.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(171/ptm_ratio, 77.5/ptm_ratio)  ,  new b2Vec2(176/ptm_ratio, 179.5/ptm_ratio)  ,  new b2Vec2(141/ptm_ratio, 83.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(203.5/ptm_ratio, 60/ptm_ratio)  ,  new b2Vec2(176/ptm_ratio, 179.5/ptm_ratio)  ,  new b2Vec2(171/ptm_ratio, 77.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(234.5/ptm_ratio, 15/ptm_ratio)  ,  new b2Vec2(176/ptm_ratio, 179.5/ptm_ratio)  ,  new b2Vec2(203.5/ptm_ratio, 60/ptm_ratio)  ] ,
                                                [   new b2Vec2(239.5/ptm_ratio, 1/ptm_ratio)  ,  new b2Vec2(234.5/ptm_ratio, 15/ptm_ratio)  ,  new b2Vec2(239.5/ptm_ratio, 0/ptm_ratio)  ]
											]

										]

									];

			dict["block6"] = [

										[
											// density, friction, restitution
                                            99, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(0/ptm_ratio, 276/ptm_ratio)  ,  new b2Vec2(339/ptm_ratio, 112/ptm_ratio)  ,  new b2Vec2(343/ptm_ratio, 128/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 296/ptm_ratio)  ]
											]

										]

									];

			dict["block7"] = [

										[
											// density, friction, restitution
                                            99, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(-337/ptm_ratio, 126/ptm_ratio)  ,  new b2Vec2(-338/ptm_ratio, 111/ptm_ratio)  ,  new b2Vec2(-2/ptm_ratio, 274/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 295/ptm_ratio)  ]
											]

										]

									];

			dict["block8"] = [

										[
											// density, friction, restitution
                                            99, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(298/ptm_ratio, 343/ptm_ratio)  ,  new b2Vec2(305/ptm_ratio, 281/ptm_ratio)  ,  new b2Vec2(324/ptm_ratio, 328/ptm_ratio)  ,  new b2Vec2(317/ptm_ratio, 350/ptm_ratio)  ,  new b2Vec2(305/ptm_ratio, 354/ptm_ratio)  ] ,
                                                [   new b2Vec2(0/ptm_ratio, 282/ptm_ratio)  ,  new b2Vec2(20/ptm_ratio, 254/ptm_ratio)  ,  new b2Vec2(40/ptm_ratio, 242/ptm_ratio)  ,  new b2Vec2(54/ptm_ratio, 303/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 316/ptm_ratio)  ] ,
                                                [   new b2Vec2(250/ptm_ratio, 338/ptm_ratio)  ,  new b2Vec2(196/ptm_ratio, 307/ptm_ratio)  ,  new b2Vec2(106/ptm_ratio, 173/ptm_ratio)  ,  new b2Vec2(240/ptm_ratio, 178/ptm_ratio)  ,  new b2Vec2(277/ptm_ratio, 216/ptm_ratio)  ,  new b2Vec2(300/ptm_ratio, 254/ptm_ratio)  ,  new b2Vec2(305/ptm_ratio, 281/ptm_ratio)  ,  new b2Vec2(298/ptm_ratio, 343/ptm_ratio)  ] ,
                                                [   new b2Vec2(192/ptm_ratio, 23/ptm_ratio)  ,  new b2Vec2(217/ptm_ratio, 138/ptm_ratio)  ,  new b2Vec2(141/ptm_ratio, 118/ptm_ratio)  ,  new b2Vec2(166/ptm_ratio, 14/ptm_ratio)  ,  new b2Vec2(170/ptm_ratio, 5/ptm_ratio)  ,  new b2Vec2(180/ptm_ratio, 0/ptm_ratio)  ] ,
                                                [   new b2Vec2(40/ptm_ratio, 242/ptm_ratio)  ,  new b2Vec2(61/ptm_ratio, 236/ptm_ratio)  ,  new b2Vec2(148/ptm_ratio, 310/ptm_ratio)  ,  new b2Vec2(54/ptm_ratio, 303/ptm_ratio)  ] ,
                                                [   new b2Vec2(240/ptm_ratio, 178/ptm_ratio)  ,  new b2Vec2(106/ptm_ratio, 173/ptm_ratio)  ,  new b2Vec2(106/ptm_ratio, 141/ptm_ratio)  ,  new b2Vec2(141/ptm_ratio, 118/ptm_ratio)  ,  new b2Vec2(217/ptm_ratio, 138/ptm_ratio)  ] ,
                                                [   new b2Vec2(141/ptm_ratio, 118/ptm_ratio)  ,  new b2Vec2(106/ptm_ratio, 141/ptm_ratio)  ,  new b2Vec2(109/ptm_ratio, 125/ptm_ratio)  ,  new b2Vec2(117/ptm_ratio, 117/ptm_ratio)  ,  new b2Vec2(131/ptm_ratio, 114/ptm_ratio)  ] ,
                                                [   new b2Vec2(148/ptm_ratio, 310/ptm_ratio)  ,  new b2Vec2(103/ptm_ratio, 194/ptm_ratio)  ,  new b2Vec2(106/ptm_ratio, 173/ptm_ratio)  ,  new b2Vec2(196/ptm_ratio, 307/ptm_ratio)  ] ,
                                                [   new b2Vec2(82/ptm_ratio, 222/ptm_ratio)  ,  new b2Vec2(148/ptm_ratio, 310/ptm_ratio)  ,  new b2Vec2(61/ptm_ratio, 236/ptm_ratio)  ] ,
                                                [   new b2Vec2(103/ptm_ratio, 194/ptm_ratio)  ,  new b2Vec2(148/ptm_ratio, 310/ptm_ratio)  ,  new b2Vec2(82/ptm_ratio, 222/ptm_ratio)  ]
											]

										]

									];

		}
	}
}
