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
#import "GameBlock.h"
#import "GLDraw.h"
#import "RGBColor.h"
#import "Constants.h"

@implementation ViewController

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
    
    screenSize = self.view.bounds.size;
    
    _headerHeight = screenSize.height*0.05f;
    
    // life label
    _lifeLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(0.0f, 0.0f, screenSize.width/2, _headerHeight)];
    _lifeLabel.textAlignment = ALIGN_CENTER;
    _lifeLabel.textColor = [UIColor whiteColor];
    _lifeLabel.backgroundColor = [UIColor grayColor];
    _lifeLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(_headerHeight)];
    [self.view addSubview:_lifeLabel];
    
    // score label
    _scoreLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(screenSize.width/2, 0.0f, screenSize.width/2, _headerHeight)];
    _scoreLabel.textAlignment = ALIGN_CENTER;
    _scoreLabel.textColor = [UIColor whiteColor];
    _scoreLabel.backgroundColor = [UIColor grayColor];
    _scoreLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(_headerHeight)];
    [self.view addSubview:_scoreLabel];
    
    _theMediator = [Mediator sharedInstance];
    [_theMediator setView:self];
    [_theMediator setScreenSize:screenSize];
    [_theMediator setUpPhysicsController];
    [_theMediator setUpGameController];
    [_theMediator setUpMotionController];
    
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
	glViewport(0, 0, screenSize.width, screenSize.height);
    
	// set up orthographic projection
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
    glOrthof(0, screenSize.width, 0, screenSize.height, -1.0f, 1.0f);
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // get the touch point and fix coordinates
    CGPoint touch_point = [[touches anyObject] locationInView:self.view];
    touch_point.y = screenSize.height - touch_point.y;
    touch_point = CGPointMake(touch_point.x, touch_point.y);
    
    [_theMediator touchesBeganPhysics:touch_point];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // get the touch point and fix coordinates
    CGPoint touch_point = [[touches anyObject] locationInView:self.view];
    touch_point.y = screenSize.height - touch_point.y;
    touch_point = CGPointMake(touch_point.x, touch_point.y);
    
    [_theMediator touchesMovedPhysics:touch_point];
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
	// clear the rendering buffer
	glClear(GL_COLOR_BUFFER_BIT);
	// enable the vertex array rendering
	glEnableClientState(GL_VERTEX_ARRAY);
   // NSLog(@"%hhd", [_theMediator getTimerState]);
    //if ([_theMediator getTimerState]) {
        // draw and dispaly the balls
    
        for(int i = 0; i < [_theMediator.balls count]; i++) {
            //NSLog(@"%lu", (unsigned long)[balls count]);
            Ball *currentBall = (Ball *) [_theMediator.balls objectAtIndex: i];
            glColor4f([currentBall color].red, [currentBall color].green, [currentBall color].blue, [currentBall color].alpha);
            [GLDraw GLDrawCircleAtCenter:[currentBall position] segments:30 circleSize:[currentBall radius] filled:YES];
        }
    
        // bricks
        for(int i = 0; i < [_theMediator.blocks count]; i++) {
            GameBlock *currentBlock = (GameBlock *) [_theMediator.blocks objectAtIndex: i];
            glColor4f([currentBlock color].red, [currentBlock color].green, [currentBlock color].blue, [currentBlock color].alpha);
            [GLDraw GLDrawRectangleAtCenter:[currentBlock position] width:[currentBlock size].width height:[currentBlock size].height filled:YES];
        }
    
        // paddles
        for(int i = 0; i < [_theMediator.paddles count]; i++) {
            Paddle *currentPaddle = (Paddle *) [_theMediator.paddles objectAtIndex: i];
            glColor4f([currentPaddle color].red, [currentPaddle color].green, [currentPaddle color].blue, [currentPaddle color].alpha);
            [GLDraw GLDrawRectangleAtCenter:[currentPaddle position] width:[currentPaddle size].width height:[currentPaddle size].height filled:YES];
        }
    //}
    
}

@end
