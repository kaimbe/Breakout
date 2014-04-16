//
//  BreakoutViewController.mm
//  Breakout
//
//  Created by Matthew Newell on 2014-04-01.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "BreakoutViewController.h"
#import "KMMediator.h"
#import "KMGameController.h"
#import "KMPhysicsController.h"

#import "KMBall.h"
#import "KMPaddle.h"
#import "KMBlock.h"
#import "KMGLDraw.h"
#import "KMRGBColor.h"
#import "KMConstants.h"

#import "ImageTextures.h"

@implementation BreakoutViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
    
    // setup opengl
	self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    
	if (!self.context) {
		NSLog(@"Failed to create ES context");
	}
	
	GLKView *view = (GLKView *)self.view;
	view.context = self.context;
	view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupGL];
    
    _screenSize = self.view.bounds.size;
    
    _headerHeight = _screenSize.height*0.05f;
    
    float textPercent = 0.7;
    
    // level label
    _levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, (_screenSize.width/3)+2, _headerHeight)];
    _levelLabel.textAlignment = ALIGN_CENTER;
    _levelLabel.textColor = [UIColor whiteColor];
    _levelLabel.backgroundColor = [UIColor grayColor];
    _levelLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(_headerHeight*textPercent)];
    [self.view addSubview:_levelLabel];
    
    // life label
    _lifeLabel = [ [UILabel alloc ] initWithFrame:CGRectMake((_screenSize.width/3)-2, 0.0f, (_screenSize.width/3)+2, _headerHeight)];
    _lifeLabel.textAlignment = ALIGN_CENTER;
    _lifeLabel.textColor = [UIColor whiteColor];
    _lifeLabel.backgroundColor = [UIColor grayColor];
    _lifeLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(_headerHeight*textPercent)];
    [self.view addSubview:_lifeLabel];
    
    // score label
    _scoreLabel = [ [UILabel alloc ] initWithFrame:CGRectMake((2*(_screenSize.width/3))-2, 0.0f, (_screenSize.width/3)+2, _headerHeight)];
    _scoreLabel.textAlignment = ALIGN_CENTER;
    _scoreLabel.textColor = [UIColor whiteColor];
    _scoreLabel.backgroundColor = [UIColor grayColor];
    _scoreLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(_headerHeight*textPercent)];
    [self.view addSubview:_scoreLabel];
    
    // get the mediator and set some properties
    _theMediator = [KMMediator sharedInstance];
    [_theMediator setView:self];
    [_theMediator setScreenSize:_screenSize];
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
    
	// Dispose of any resources that can be recreated
}

- (void)update
{
	[self setupOrthographicView];
}

- (void)setupGL
{
	[EAGLContext setCurrentContext:self.context];
    
    // load the texture files
    _textures = [[ImageTextures alloc] initNumTexture:3];
    [_textures loadTextureAt:2 from:@"silver-diamond-plate_small.png"];
    [_textures loadTextureAt:1 from:@"block_small.png"];
	//[_textures loadTextureAt:0 from:@"ball.png"];
}

- (void)tearDownGL
{
	[EAGLContext setCurrentContext:self.context];
}

- (void)setupOrthographicView
{
    // set viewport based on display size
	glViewport(0, 0, _screenSize.width, _screenSize.height);
    
	// set up orthographic projection
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
    glOrthof(0, _screenSize.width, 0, _screenSize.height, -1.0f, 1.0f);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // get the touch point and fix coordinates
    CGPoint touch_point = [[touches anyObject] locationInView:self.view];
    touch_point.y = _screenSize.height - touch_point.y;
    touch_point = CGPointMake(touch_point.x, touch_point.y);
    
    [_theMediator touchesBeganPhysics:touch_point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // get the touch point and fix coordinates
    CGPoint touch_point = [[touches anyObject] locationInView:self.view];
    touch_point.y = _screenSize.height - touch_point.y;
    touch_point = CGPointMake(touch_point.x, touch_point.y);
    
    [_theMediator touchesMovedPhysics:touch_point];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // get the touch point and fix coordinates
    CGPoint touch_point = [[touches anyObject] locationInView:self.view];
    touch_point.y = _screenSize.height - touch_point.y;
    touch_point = CGPointMake(touch_point.x, touch_point.y);
    
    [_theMediator touchesEndedPhysics:touch_point];
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
	// clear the rendering buffer
	glClear(GL_COLOR_BUFFER_BIT);
	// enable the vertex array rendering and texture
	glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    
    // set up the transformation for models
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
    
    // bind ball texture
    //[_textures bindTextureAt: 0];
    // draw and dispaly the balls
    for(int i = 0; i < [_theMediator.balls count]; i++) {
        KMBall *currentBall = (KMBall *) [_theMediator.balls objectAtIndex: i];
        glColor4f([currentBall color].red, [currentBall color].green, [currentBall color].blue, [currentBall color].alpha);
        [KMGLDraw GLDrawCircleAtCenter:[currentBall position] segments:16.0f circleSize:[currentBall radius] filled:YES];
    }
    
    // bind block texure
    [_textures bindTextureAt: 1];
    // blocks
    for(int i = 0; i < [_theMediator.blocks count]; i++) {
        KMBlock *currentBlock = (KMBlock *) [_theMediator.blocks objectAtIndex: i];
        glColor4f([currentBlock color].red, [currentBlock color].green, [currentBlock color].blue, [currentBlock color].alpha);
        [KMGLDraw GLDrawRectangleAtCenter:[currentBlock position] width:[currentBlock size].width height:[currentBlock size].height filled:YES];
    }
    
    // bind paddle texture
    [_textures bindTextureAt: 2];
    // paddles
    for(int i = 0; i < [_theMediator.paddles count]; i++) {
        KMPaddle *currentPaddle = (KMPaddle *) [_theMediator.paddles objectAtIndex: i];
        glColor4f([currentPaddle color].red, [currentPaddle color].green, [currentPaddle color].blue, [currentPaddle color].alpha);
        [KMGLDraw GLDrawRectangleAtCenter:[currentPaddle position] width:[currentPaddle size].width height:[currentPaddle size].height filled:YES];
    }
    
    // disable
    glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisable(GL_TEXTURE_2D);
}

@end
