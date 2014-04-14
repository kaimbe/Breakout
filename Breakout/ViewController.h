//
//  ViewController.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-01.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import <GLKit/GLKit.h>

@class Mediator;

@interface ViewController : GLKViewController {
    GLKTextureInfo *textureInfo;
    
    NSMutableArray *balls;
    NSMutableArray *paddles;
    NSMutableArray *blocks;
    
    CGSize screen_size;
}

@property Mediator *theMediator;

@property (strong, nonatomic) EAGLContext *context;

- (void)setupGL;
- (void)tearDownGL;
- (void)setupOrthographicView;

@end
