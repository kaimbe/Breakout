//
//  ImageTextures.h
//  Modeling
//
//  Created by Minglun Gong on 20/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageTextures : NSObject

- (ImageTextures*) initNumTexture: (int) num;
- (void)dealloc;
- (void)loadTextureAt: (int)at from: (NSString *)file;
- (void)bindTextureAt: (int)at;

@end
