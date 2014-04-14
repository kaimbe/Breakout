//
//  PhysicsController.mm
//  Breakout
//
//  Created by Matthew Newell on 2014-04-06.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "PhysicsController.h"
#import "Mediator.h"
#import "MotionController.h"
#import "Ball.h"
#import "Paddle.h"

#import "Constants.h"

@implementation PhysicsController

- (id)init
{
    // timer
    [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(physicsTick:) userInfo:nil repeats:YES];
    
    // Create a world
    b2Vec2 gravity = b2Vec2(0.0f, 0.0f);
    _world = new b2World(gravity);
    
    return self;
}

- (void)setUpPhysicsController
{
    _theMediator = [Mediator sharedInstance];
    
    //NSLog(@"%f", _currentBall.position.x);
    // Create edges around the entire screen
    b2BodyDef groundBodyDef;
    groundBodyDef.position.Set(0,0);
    _groundBody = _world->CreateBody(&groundBodyDef);
    
    b2EdgeShape groundBox;
    b2FixtureDef groundBoxDef;
    groundBoxDef.shape = &groundBox;
    
    // bottom
    groundBox.Set(b2Vec2(0,0), b2Vec2(_screenSize.width/PTM_RATIO, 0));
    _bottomFixture = _groundBody->CreateFixture(&groundBoxDef);
    
    // left
    groundBox.Set(b2Vec2(0,0), b2Vec2(0, (_screenSize.height - _headerHeight)/PTM_RATIO));
    _groundBody->CreateFixture(&groundBoxDef);
    
    // top
    groundBox.Set(b2Vec2(0, (_screenSize.height - _headerHeight)/PTM_RATIO), b2Vec2(_screenSize.width/PTM_RATIO, (_screenSize.height - _headerHeight)/PTM_RATIO));
    _groundBody->CreateFixture(&groundBoxDef);
    
    // right
    groundBox.Set(b2Vec2(_screenSize.width/PTM_RATIO, (_screenSize.height - _headerHeight)/PTM_RATIO), b2Vec2(_screenSize.width/PTM_RATIO, 0));
    _groundBody->CreateFixture(&groundBoxDef);
    
    // Create contact listener
    _contactListener = new ContactListener();
    _world->SetContactListener(_contactListener);
    
    NSLog(@"Physics Controller Loaded");
}

- (void)createBallAtPosition:(CGPoint)position radius:(CGFloat)radius
{
    // Create ball body
    b2BodyDef ballBodyDef;
    ballBodyDef.type = b2_dynamicBody;
    ballBodyDef.position.Set(position.x/PTM_RATIO, position.y/PTM_RATIO);
    b2Body *_ballBody = _world->CreateBody(&ballBodyDef);
    
    ballBodies.push_back(_ballBody);
    
    // Create circle shape
    b2CircleShape circle;
    circle.m_radius = radius/PTM_RATIO;
    
    // Create shape definition and add to body
    b2FixtureDef ballShapeDef;
    ballShapeDef.shape = &circle;
    ballShapeDef.density = 1.0f;
    ballShapeDef.friction = 1.0f;
    ballShapeDef.restitution = 1.0f;
    _ballBody->CreateFixture(&ballShapeDef);
    
    b2Vec2 force = b2Vec2(0.0, -15);
    _ballBody->ApplyForce(force, ballBodyDef.position, true);
}

- (void)createPaddleAtPosition:(CGPoint)position width:(CGFloat)width height:(CGFloat)height
{
    // Create paddle body
    b2BodyDef paddleBodyDef;
    paddleBodyDef.type = b2_dynamicBody;
    paddleBodyDef.position.Set(position.x/PTM_RATIO, position.y/PTM_RATIO);
    b2Body *_paddleBody = _world->CreateBody(&paddleBodyDef);
    
    paddleBodies.push_back(_paddleBody);
    
    // Create paddle shape
    b2PolygonShape paddleShape;
    paddleShape.SetAsBox(width/PTM_RATIO/2, height/PTM_RATIO/2);
    
    // Create shape definition and add to body
    b2FixtureDef paddleShapeDef;
    paddleShapeDef.shape = &paddleShape;
    paddleShapeDef.density = 10.0f;
    paddleShapeDef.friction = 1.0f;
    paddleShapeDef.restitution = 0.1f;
    _paddleBody->CreateFixture(&paddleShapeDef);
    
    
    // Restrict paddle along the x axis
    b2PrismaticJointDef jointDef;
    b2Vec2 worldAxis(1.0f, 0.0f);
    jointDef.collideConnected = true;
    jointDef.Initialize(_paddleBody, _groundBody, _paddleBody->GetWorldCenter(), worldAxis);
    _world->CreateJoint(&jointDef);
     
}

- (void)createBlockAtPosition:(CGPoint)position width:(CGFloat)width height:(CGFloat)height
{
    // Create block body
    b2BodyDef blockBodyDef;
    blockBodyDef.type = b2_staticBody;
    blockBodyDef.position.Set(position.x/PTM_RATIO, position.y/PTM_RATIO);
    b2Body *_blockBody = _world->CreateBody(&blockBodyDef);
    
    blockBodies.push_back(_blockBody);
    
    // Create block shape
    b2PolygonShape blockShape;
    blockShape.SetAsBox(width/PTM_RATIO/2, height/PTM_RATIO/2);
    
    
    // Create shape definition and add to body
    b2FixtureDef blockShapeDef;
    blockShapeDef.shape = &blockShape;
    blockShapeDef.density = 10.0;
    blockShapeDef.friction = 0.0;
    blockShapeDef.restitution = 0.1f;
    _blockBody->CreateFixture(&blockShapeDef);
}

- (void)touchesBeganPhysics:(CGPoint)touchPoint
{
    if (_mouseJoint != NULL) return;
    
    b2Vec2 locationWorld = b2Vec2(touchPoint.x/PTM_RATIO, touchPoint.y/PTM_RATIO);
    
    for (std::vector<int>::size_type i = 0; i != paddleBodies.size(); i++) {
        b2Body *body = paddleBodies.at(i);
        b2Fixture *fixture = body->GetFixtureList();
        
        if (fixture->TestPoint(locationWorld)) {
            b2MouseJointDef md;
            md.bodyA = _groundBody;
            md.bodyB = body;
            md.target = locationWorld;
            md.collideConnected = true;
            md.maxForce = 1000.0f * body->GetMass();
            
            _mouseJoint = (b2MouseJoint *)_world->CreateJoint(&md);
            body->SetAwake(true);
        }
    }
}

- (void)touchesMovedPhysics:(CGPoint)touchPoint
{
    if (_mouseJoint == NULL) return;
    
    b2Vec2 locationWorld = b2Vec2(touchPoint.x/PTM_RATIO, touchPoint.y/PTM_RATIO);
    _mouseJoint->SetTarget(locationWorld);
}

- (void) physicsTick:(NSTimer *)timer {
    float32 timeStep = 1.0f / 60.0f;
    int32 velocityIterations = 1;
    int32 positionIterations = 1;
    _world->Step(timeStep, velocityIterations, positionIterations);
    
    // balls
    static int maxSpeed = 10;
    
    for (std::vector<int>::size_type i = 0; i != ballBodies.size(); i++)
    {
        b2Body* body = ballBodies.at(i);
        b2Vec2 velocity = body->GetLinearVelocity();
        float speed = velocity.Length();
        
        if (speed > maxSpeed) {
            body->SetLinearDamping(0.5);
        } else if (speed < maxSpeed) {
            body->SetLinearDamping(0.0);
        }
        b2Vec2 ballPosition = body->GetPosition();
        Ball *temp = [[_theMediator balls] objectAtIndex:i];
        [temp setPosition:CGPointMake(ballPosition.x*PTM_RATIO, ballPosition.y*PTM_RATIO)];
    }
    
    const float accMultiplier = 30.0f;
    b2Vec2 force = b2Vec2(accMultiplier * [_theMediator accX], 0.0f);
    
    for (std::vector<int>::size_type i = 0; i != paddleBodies.size(); i++)
    {
        b2Body *body = paddleBodies.at(i);
        b2Vec2 paddlePosition = body->GetPosition();
        body->ApplyForce(force, paddlePosition, true);
        Paddle *temp = [[_theMediator paddles] objectAtIndex:i];
        [temp setPosition:CGPointMake(paddlePosition.x*PTM_RATIO, paddlePosition.y*PTM_RATIO)];
    }
    
    //check contacts
    std::vector<b2Body *>toDestroy;
    std::vector<Contact>::iterator pos;
    for(pos = _contactListener->_contacts.begin(); pos != _contactListener->_contacts.end(); ++pos) {
        Contact contact = *pos;
        
        for (std::vector<int>::size_type i = 0; i != ballBodies.size(); i++)
        {
            b2Body* ballBody = ballBodies.at(i);
            b2Fixture* ballFixture = ballBody->GetFixtureList();
            
            b2Body *bodyA = contact.fixtureA->GetBody();
            b2Body *bodyB = contact.fixtureB->GetBody();
            
            // detect ball hitting floor
            if ((contact.fixtureA == _bottomFixture && contact.fixtureB == ballFixture) ||
                (contact.fixtureA == ballFixture && contact.fixtureB == _bottomFixture)) {
                //NSLog(@"Ball hit bottom!");
                
                // loose a life
                [_theMediator looseLife];
            }
            
            // detect block collisions
            std::vector<b2Body *>::iterator block;
            for (block = blockBodies.begin(); block != blockBodies.end(); ++block) {
                b2Body *body = *block;
                
                //Sprite A = ball, Sprite B = Block
                if (contact.fixtureA == ballFixture && bodyB == body) {
                    //NSLog(@"Ball hit brick!");
                    if (std::find(toDestroy.begin(), toDestroy.end(), bodyB) == toDestroy.end()) {
                        toDestroy.push_back(bodyB);
                    }
                }
                
                
                //Sprite A = block, Sprite B = ball
                else if (contact.fixtureB == ballFixture && bodyA == body) {
                    //NSLog(@"Ball hit brick!");
                    if (std::find(toDestroy.begin(), toDestroy.end(), bodyA) == toDestroy.end()) {
                        toDestroy.push_back(bodyA);
                    }
                }
                
            }
        }
    }
    
    // destroy the blocks that have been hit
    std::vector<b2Body *>::iterator pos2;
    for (pos2 = toDestroy.begin(); pos2 != toDestroy.end(); ++pos2) {
        b2Body *body = *pos2;
        
        b2Vec2 position = body->GetPosition();
        
        [_theMediator removeBlockAtPosition:CGPointMake(position.x*PTM_RATIO, position.y*PTM_RATIO)];
        
        _world->DestroyBody(body);
    }
    
}

@end
