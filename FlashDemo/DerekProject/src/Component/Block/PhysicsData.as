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

                                                [   new b2Vec2(136/ptm_ratio, 20/ptm_ratio)  ,  new b2Vec2(128/ptm_ratio, 30/ptm_ratio)  ,  new b2Vec2(7/ptm_ratio, 26/ptm_ratio)  ,  new b2Vec2(3/ptm_ratio, 4/ptm_ratio)  ,  new b2Vec2(126/ptm_ratio, 5/ptm_ratio)  ,  new b2Vec2(136/ptm_ratio, 11/ptm_ratio)  ]
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

                                                [   new b2Vec2(133/ptm_ratio, 48/ptm_ratio)  ,  new b2Vec2(13/ptm_ratio, 47/ptm_ratio)  ,  new b2Vec2(4/ptm_ratio, 36/ptm_ratio)  ,  new b2Vec2(8/ptm_ratio, 22/ptm_ratio)  ,  new b2Vec2(132/ptm_ratio, 21/ptm_ratio)  ,  new b2Vec2(145/ptm_ratio, 35/ptm_ratio)  ]
											]

										]

									];

			dict["block3"] = [

										[
											// density, friction, restitution
                                            0, 0.8, 0.5,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(21/ptm_ratio, 5/ptm_ratio)  ,  new b2Vec2(140/ptm_ratio, 5/ptm_ratio)  ,  new b2Vec2(145.409423828125/ptm_ratio, 18.3746910095215/ptm_ratio)  ,  new b2Vec2(130.769226074219/ptm_ratio, 27.5558314323425/ptm_ratio)  ,  new b2Vec2(16.8734474182129/ptm_ratio, 31.5260548591614/ptm_ratio)  ,  new b2Vec2(3/ptm_ratio, 14/ptm_ratio)  ]
											]

										]

									];

			dict["block4"] = [

										[
											// density, friction, restitution
                                            0, 0.8, 0.5,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(127/ptm_ratio, 156/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 144/ptm_ratio)  ,  new b2Vec2(51/ptm_ratio, 63/ptm_ratio)  ,  new b2Vec2(84/ptm_ratio, 70/ptm_ratio)  ,  new b2Vec2(148/ptm_ratio, 113/ptm_ratio)  ,  new b2Vec2(149/ptm_ratio, 142/ptm_ratio)  ] ,
                                                [   new b2Vec2(186/ptm_ratio, 52/ptm_ratio)  ,  new b2Vec2(191/ptm_ratio, 68/ptm_ratio)  ,  new b2Vec2(175/ptm_ratio, 90/ptm_ratio)  ,  new b2Vec2(148/ptm_ratio, 113/ptm_ratio)  ,  new b2Vec2(84/ptm_ratio, 70/ptm_ratio)  ,  new b2Vec2(144/ptm_ratio, 43/ptm_ratio)  ,  new b2Vec2(166/ptm_ratio, 38/ptm_ratio)  ] ,
                                                [   new b2Vec2(0/ptm_ratio, 144/ptm_ratio)  ,  new b2Vec2(24/ptm_ratio, 43/ptm_ratio)  ,  new b2Vec2(51/ptm_ratio, 63/ptm_ratio)  ] ,
                                                [   new b2Vec2(0/ptm_ratio, 144/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 0/ptm_ratio)  ,  new b2Vec2(24/ptm_ratio, 43/ptm_ratio)  ]
											]

										]

									];

			dict["block5"] = [

										[
											// density, friction, restitution
                                            0, 0.8, 0.5,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(27/ptm_ratio, 41/ptm_ratio)  ,  new b2Vec2(50/ptm_ratio, 42/ptm_ratio)  ,  new b2Vec2(97/ptm_ratio, 67/ptm_ratio)  ,  new b2Vec2(49/ptm_ratio, 118/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 69/ptm_ratio)  ,  new b2Vec2(6/ptm_ratio, 51/ptm_ratio)  ] ,
                                                [   new b2Vec2(97/ptm_ratio, 67/ptm_ratio)  ,  new b2Vec2(139/ptm_ratio, 65/ptm_ratio)  ,  new b2Vec2(193/ptm_ratio, 144/ptm_ratio)  ,  new b2Vec2(55/ptm_ratio, 153/ptm_ratio)  ,  new b2Vec2(49/ptm_ratio, 118/ptm_ratio)  ] ,
                                                [   new b2Vec2(166.997512817383/ptm_ratio, 45.0893325805664/ptm_ratio)  ,  new b2Vec2(193/ptm_ratio, 144/ptm_ratio)  ,  new b2Vec2(139/ptm_ratio, 65/ptm_ratio)  ] ,
                                                [   new b2Vec2(193/ptm_ratio, 0/ptm_ratio)  ,  new b2Vec2(193/ptm_ratio, 144/ptm_ratio)  ,  new b2Vec2(166.997512817383/ptm_ratio, 45.0893325805664/ptm_ratio)  ]
											]

										]

									];

			dict["block6"] = [

										[
											// density, friction, restitution
                                            0, 0.8, 0.5,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(1/ptm_ratio, 231/ptm_ratio)  ,  new b2Vec2(242/ptm_ratio, 137/ptm_ratio)  ,  new b2Vec2(243/ptm_ratio, 149/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 259/ptm_ratio)  ]
											]

										]

									];

			dict["block7"] = [

										[
											// density, friction, restitution
                                            0, 0.8, 0.5,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(-242/ptm_ratio, 155/ptm_ratio)  ,  new b2Vec2(-240/ptm_ratio, 141/ptm_ratio)  ,  new b2Vec2(-1/ptm_ratio, 225/ptm_ratio)  ,  new b2Vec2(-1/ptm_ratio, 263/ptm_ratio)  ]
											]

										]

									];

			dict["block8"] = [

										[
											// density, friction, restitution
                                            0, 0.8, 0.5,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(145/ptm_ratio, 0/ptm_ratio)  ,  new b2Vec2(174/ptm_ratio, 112/ptm_ratio)  ,  new b2Vec2(115/ptm_ratio, 92/ptm_ratio)  ,  new b2Vec2(133/ptm_ratio, 10/ptm_ratio)  ,  new b2Vec2(137/ptm_ratio, 0/ptm_ratio)  ] ,
                                                [   new b2Vec2(19/ptm_ratio, 200/ptm_ratio)  ,  new b2Vec2(48/ptm_ratio, 189/ptm_ratio)  ,  new b2Vec2(111/ptm_ratio, 244/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 253/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 226/ptm_ratio)  ] ,
                                                [   new b2Vec2(115/ptm_ratio, 92/ptm_ratio)  ,  new b2Vec2(169/ptm_ratio, 255/ptm_ratio)  ,  new b2Vec2(111/ptm_ratio, 244/ptm_ratio)  ,  new b2Vec2(76/ptm_ratio, 166/ptm_ratio)  ,  new b2Vec2(89/ptm_ratio, 98/ptm_ratio)  ] ,
                                                [   new b2Vec2(76/ptm_ratio, 166/ptm_ratio)  ,  new b2Vec2(111/ptm_ratio, 244/ptm_ratio)  ,  new b2Vec2(48/ptm_ratio, 189/ptm_ratio)  ] ,
                                                [   new b2Vec2(115/ptm_ratio, 92/ptm_ratio)  ,  new b2Vec2(174/ptm_ratio, 112/ptm_ratio)  ,  new b2Vec2(241/ptm_ratio, 206/ptm_ratio)  ,  new b2Vec2(257/ptm_ratio, 276/ptm_ratio)  ,  new b2Vec2(247/ptm_ratio, 283/ptm_ratio)  ,  new b2Vec2(169/ptm_ratio, 255/ptm_ratio)  ]
											]

										]

									];
			dict["block15"] = [

										[
											// density, friction, restitution
                                            0, 0.8, 0.5,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'CIRCLE',

                                            // center, radius
                                            new b2Vec2(44.595/ptm_ratio,66.027/ptm_ratio),
                                            25.020/ptm_ratio

										]

									];

			dict["block9"] = [

										[
											// density, friction, restitution
                                            0, 0.8, 0.5,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(4/ptm_ratio, 60/ptm_ratio)  ,  new b2Vec2(4/ptm_ratio, 38/ptm_ratio)  ,  new b2Vec2(112/ptm_ratio, 36/ptm_ratio)  ,  new b2Vec2(119/ptm_ratio, 63/ptm_ratio)  ,  new b2Vec2(112/ptm_ratio, 89/ptm_ratio)  ,  new b2Vec2(58/ptm_ratio, 100/ptm_ratio)  ,  new b2Vec2(11/ptm_ratio, 88/ptm_ratio)  ]
											]

										]

									];

			dict["block10"] = [

										[
											// density, friction, restitution
                                            0, 0.8, 0.5,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(16/ptm_ratio, 18/ptm_ratio)  ,  new b2Vec2(103/ptm_ratio, 16/ptm_ratio)  ,  new b2Vec2(125/ptm_ratio, 45/ptm_ratio)  ,  new b2Vec2(116.483512878418/ptm_ratio, 70.7912101745605/ptm_ratio)  ,  new b2Vec2(62.6373596191406/ptm_ratio, 83.7032968997955/ptm_ratio)  ,  new b2Vec2(13.4615383148193/ptm_ratio, 70.7912101745605/ptm_ratio)  ,  new b2Vec2(3/ptm_ratio, 43/ptm_ratio)  ,  new b2Vec2(4/ptm_ratio, 23/ptm_ratio)  ] ,
                                                [   new b2Vec2(125/ptm_ratio, 45/ptm_ratio)  ,  new b2Vec2(103/ptm_ratio, 16/ptm_ratio)  ,  new b2Vec2(116/ptm_ratio, 18/ptm_ratio)  ]
											]

										]

									];

			dict["block11"] = [

										[
											// density, friction, restitution
                                            0, 0.8, 0.5,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(79/ptm_ratio, 105/ptm_ratio)  ,  new b2Vec2(33/ptm_ratio, 90/ptm_ratio)  ,  new b2Vec2(26/ptm_ratio, 63/ptm_ratio)  ,  new b2Vec2(31/ptm_ratio, 38/ptm_ratio)  ,  new b2Vec2(124/ptm_ratio, 35/ptm_ratio)  ,  new b2Vec2(132/ptm_ratio, 64/ptm_ratio)  ,  new b2Vec2(126/ptm_ratio, 91/ptm_ratio)  ]
											]

										]

									];

			dict["block12"] = [

										[
											// density, friction, restitution
                                            0, 0.8, 0.5,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(144/ptm_ratio, 83/ptm_ratio)  ,  new b2Vec2(54/ptm_ratio, 106/ptm_ratio)  ,  new b2Vec2(17/ptm_ratio, 92/ptm_ratio)  ,  new b2Vec2(9.72972965240479/ptm_ratio, 64.6216125488281/ptm_ratio)  ,  new b2Vec2(12/ptm_ratio, 45/ptm_ratio)  ,  new b2Vec2(79/ptm_ratio, 25/ptm_ratio)  ,  new b2Vec2(150/ptm_ratio, 36/ptm_ratio)  ]
											]

										]

									];

			dict["block13"] = [

										[
											// density, friction, restitution
                                            0, 0.8, 0.5,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'CIRCLE',

                                            // center, radius
                                            new b2Vec2(50.000/ptm_ratio,88.622/ptm_ratio),
                                            27.731/ptm_ratio

										]

									];

			dict["block14"] = [

										[
											// density, friction, restitution
                                            0, 0.8, 0.5,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'CIRCLE',

                                            // center, radius
                                            new b2Vec2(52.162/ptm_ratio,52.270/ptm_ratio),
                                            29.967/ptm_ratio

										]

									];
			dict["block15"] = [

										[
											// density, friction, restitution
                                            0, 0.8, 0.5,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'CIRCLE',

                                            // center, radius
                                            new b2Vec2(52.162/ptm_ratio,52.270/ptm_ratio),
                                            29.967/ptm_ratio

										]

									];
									
			dict["block16"] = [

										[
											// density, friction, restitution
                                            0, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(4/ptm_ratio, 18/ptm_ratio)  ,  new b2Vec2(170/ptm_ratio, 18/ptm_ratio)  ,  new b2Vec2(178/ptm_ratio, 59/ptm_ratio)  ,  new b2Vec2(169/ptm_ratio, 89/ptm_ratio)  ,  new b2Vec2(108/ptm_ratio, 103/ptm_ratio)  ,  new b2Vec2(14/ptm_ratio, 72/ptm_ratio)  ]
											]

										]

									];
			dict["protect"] = [

										[
											// density, friction, restitution
                                            0, 0.8, 0.5,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'CIRCLE',

                                            // center, radius
                                            new b2Vec2(47.838/ptm_ratio,47.703/ptm_ratio),
                                            43.829/ptm_ratio

										]

									];

		}
	}
}
