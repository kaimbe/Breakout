//
//  ViewController.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-01.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import <GLKit/GLKit.h>

@class KMMediator;

@interface BreakoutViewController : GLKViewController {
    GLKTextureInfo *_textureInfo;
    
    KMMediator *_theMediator;
}

@property CGSize screenSize;
@property CGFloat headerHeight;

@property (strong, nonatomic) EAGLContext *context;

@property (strong, nonatomic) UILabel *scoreLabel;
@property (strong, nonatomic) UILabel *lifeLabel;
@property (strong, nonatomic) UILabel *levelLabel;

- (void)setupGL;
- (void)tearDownGL;
- (void)setupOrthographicView;

@end