//
//  PhysicsController.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-06.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import <Box2D/Box2D.h>
#import "KMContactListener.h"

@class KMMediator;

@interface KMPhysicsController : NSObject {
    b2World *_world;
    b2Body *_groundBody;
    b2Fixture *_bottomFixture;
    
    std::vector<b2Body*> ballBodies;
    std::vector<b2Body*> paddleBodies;
    std::vector<b2Body*> blockBodies;

    b2MouseJoint *_mouseJoint;
    
    KMContactListener *_contactListener;
    
    NSTimer *_theTimer;
    
    KMMediator *_theMediator;
}

@property (nonatomic) CGSize screenSize;
@property (nonatomic) CGFloat headerHeight;

- (void)setUpPhysicsController;
- (void)createBallAtPosition:(CGPoint)position radius:(CGFloat)radius;
- (void)createPaddleAtPosition:(CGPoint)position width:(CGFloat)width height:(CGFloat)height;
- (void)createBlockAtPosition:(CGPoint)position width:(CGFloat)width height:(CGFloat)height;
- (void)touchesBeganPhysics:(CGPoint) touchPoint;
- (void)touchesMovedPhysics:(CGPoint) touchPoint;
- (void)touchesEndedPhysics:(CGPoint)touchPoint;
- (void)toggleTimer;
-(void)resetBallPosition;

@end