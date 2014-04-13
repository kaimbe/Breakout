//
//  ViewController.m
//  Breakout
//
//  Created by Matthew Newell on 2014-04-01.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "ViewController.h"
#import "Mediator.h"
#import "GameController.h"
#import "PhysicsController.h"

#import "Ball.h"
#import "Paddle.h"
#import "MyBlock.h"
#import "GLDraw.h"
#import "RGBColor.h"

@implementation ViewController
{
    Mediator *theMediator;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
    	
	self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    
	if (!self.context) {
		NSLog(@"Failed to create ES context");
	}
	
	GLKView *view = (GLKView *)self.view;
	view.context = self.context;
	view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupGL];
    
    screen_size = self.view.bounds.size;
    
    GameController *game = [[GameController alloc] init];
    PhysicsController *physics = [[PhysicsController alloc] init];
    theMediator = [[Mediator alloc]initWithViewController:self gameController:game physicsController:physics];
    
    [game setTheMediator:theMediator];
    [physics setTheMediator:theMediator];
    
    [theMediator setScreenSize:screen_size];
    [theMediator setUpPhysicsController];
    [theMediator setUpGameController];

    balls = [theMediator balls];
    paddles = [theMediator paddles];
    blocks = [theMediator blocks];
    
    NSLog(@"View Controller Loaded");
    
}

- (void)dealloc
{
	[self tearDownGL];
	
	if ([EAGLContext currentContext] == self.context) {
		[EAGLContext setCurrentContext:nil];
	}
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
    
	if ([self isViewLoaded] && ([[self view] window] == nil)) {
		self.view = nil;
		
		[self tearDownGL];
		
		if ([EAGLContext currentContext] == self.context) {
			[EAGLContext setCurrentContext:nil];
		}
		self.context = nil;
	}
    
	// Dispose of any resources that can be recreated.
}

- (void)update
{
	[self setupOrthographicView];
}

- (void)setupGL
{
	[EAGLContext setCurrentContext:self.context];
}

- (void)tearDownGL
{
	[EAGLContext setCurrentContext:self.context];
}

- (void)setupOrthographicView
{
    // set viewport based on display size
	glViewport(0, 0, screen_size.width, screen_size.height);
    
	// set up orthographic projection
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
    glOrthof(0, screen_size.width, 0, screen_size.height, -1.0f, 1.0f);
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // get the touch point and fix coordinates
    CGPoint touch_point = [[touches anyObject] locationInView:self.view];
    touch_point.y = screen_size.height - touch_point.y;
    touch_point = CGPointMake(touch_point.x, touch_point.y);
    
    [theMediator touchesBeganPhysics:touch_point];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // get the touch point and fix coordinates
    CGPoint touch_point = [[touches anyObject] locationInView:self.view];
    touch_point.y = screen_size.height - touch_point.y;
    touch_point = CGPointMake(touch_point.x, touch_point.y);
    
    [theMediator touchesMovedPhysics:touch_point];
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
	// clear the rendering buffer
	glClear(GL_COLOR_BUFFER_BIT);
	// enable the vertex array rendering
	glEnableClientState(GL_VERTEX_ARRAY);
    
    // draw and dispaly the balls
    for(int i = 0; i < [balls count]; i++) {
        Ball *currentBall = (Ball *) [balls objectAtIndex: i];
        glColor4f([currentBall color].red, [currentBall color].green, [currentBall color].blue, [currentBall color].alpha);
        [GLDraw GLDrawCircleAtCenter:[currentBall position] segments:30 circleSize:[currentBall radius] filled:YES];
    }
    
    
    // bricks
    for(int i = 0; i < [blocks count]; i++) {
        MyBlock *currentBlock = (MyBlock *) [blocks objectAtIndex: i];
        glColor4f([currentBlock color].red, [currentBlock color].green, [currentBlock color].blue, [currentBlock color].alpha);
        [GLDraw GLDrawRectangleAtCenter:[currentBlock position] width:[currentBlock size].width height:[currentBlock size].height filled:YES];
    }
    
    glColor4f(5, 5, 5, 1);    // paddles
    for(int i = 0; i < [paddles count]; i++) {
        Paddle *currentPaddle = (Paddle *) [paddles objectAtIndex: i];
        glColor4f([currentPaddle color].red, [currentPaddle color].green, [currentPaddle color].blue, [currentPaddle color].alpha);
        [GLDraw GLDrawRectangleAtCenter:[currentPaddle position] width:[currentPaddle size].width height:[currentPaddle size].height filled:YES];
    }
}

@end
