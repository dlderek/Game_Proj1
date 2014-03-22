package
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
		var dict:Dictionary;
		
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
			

			dict["block4"] = [

										[
											// density, friction, restitution
                                            0, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [
												
                                                [   new b2Vec2(1/ptm_ratio, 179/ptm_ratio)  ,  new b2Vec2(112/ptm_ratio, 82/ptm_ratio)  ,  new b2Vec2(197/ptm_ratio, 48/ptm_ratio)  ,  new b2Vec2(243/ptm_ratio, 78/ptm_ratio)  ,  new b2Vec2(168/ptm_ratio, 191/ptm_ratio)  ] ,
                                                [   new b2Vec2(53/ptm_ratio, 71/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 179/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 0/ptm_ratio)  ] ,
                                                [   new b2Vec2(112/ptm_ratio, 82/ptm_ratio)  ,  new b2Vec2(1/ptm_ratio, 179/ptm_ratio)  ,  new b2Vec2(53/ptm_ratio, 71/ptm_ratio)  ]
											]

										]

									];

			dict["block5"] = [

										[
											// density, friction, restitution
                                            0, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(240/ptm_ratio, 179/ptm_ratio)  ,  new b2Vec2(178/ptm_ratio, 79/ptm_ratio)  ,  new b2Vec2(240/ptm_ratio, 0/ptm_ratio)  ] ,
                                                [   new b2Vec2(69/ptm_ratio, 195/ptm_ratio)  ,  new b2Vec2(122/ptm_ratio, 82/ptm_ratio)  ,  new b2Vec2(178/ptm_ratio, 79/ptm_ratio)  ,  new b2Vec2(240/ptm_ratio, 179/ptm_ratio)  ] ,
                                                [   new b2Vec2(122/ptm_ratio, 82/ptm_ratio)  ,  new b2Vec2(69/ptm_ratio, 195/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 77/ptm_ratio)  ,  new b2Vec2(38/ptm_ratio, 47/ptm_ratio)  ]
											]

										]

									];

			dict["block8"] = [

										[
											// density, friction, restitution
                                            0, 0.5, 0.8,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',

                                            // vertexes of decomposed polygons
                                            [

                                                [   new b2Vec2(184/ptm_ratio, 306/ptm_ratio)  ,  new b2Vec2(214/ptm_ratio, 140/ptm_ratio)  ,  new b2Vec2(293/ptm_ratio, 243/ptm_ratio)  ,  new b2Vec2(322/ptm_ratio, 342/ptm_ratio)  ] ,
                                                [   new b2Vec2(-2/ptm_ratio, 313/ptm_ratio)  ,  new b2Vec2(79/ptm_ratio, 229/ptm_ratio)  ,  new b2Vec2(214/ptm_ratio, 140/ptm_ratio)  ,  new b2Vec2(184/ptm_ratio, 306/ptm_ratio)  ] ,
                                                [   new b2Vec2(214/ptm_ratio, 140/ptm_ratio)  ,  new b2Vec2(148/ptm_ratio, 108/ptm_ratio)  ,  new b2Vec2(179/ptm_ratio, -3/ptm_ratio)  ] ,
                                                [   new b2Vec2(79/ptm_ratio, 229/ptm_ratio)  ,  new b2Vec2(-2/ptm_ratio, 313/ptm_ratio)  ,  new b2Vec2(21/ptm_ratio, 249/ptm_ratio)  ] ,
                                                [   new b2Vec2(148/ptm_ratio, 108/ptm_ratio)  ,  new b2Vec2(214/ptm_ratio, 140/ptm_ratio)  ,  new b2Vec2(106/ptm_ratio, 173/ptm_ratio)  ,  new b2Vec2(116/ptm_ratio, 119/ptm_ratio)  ] ,
                                                [   new b2Vec2(214/ptm_ratio, 140/ptm_ratio)  ,  new b2Vec2(79/ptm_ratio, 229/ptm_ratio)  ,  new b2Vec2(106/ptm_ratio, 173/ptm_ratio)  ]
											]

										]

									];

		}
	}
}
