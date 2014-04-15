//
//  Sprite.h
//  Breakout
//
//  Created by Matthew Newell on 2014-04-13.
//  Copyright (c) 2014 mjn874@mun.ca. All rights reserved.
//

#import "KMRGBColor.h"

@interface KMSprite : NSObject

@property (nonatomic) CGPoint position;
@property (strong, nonatomic) KMRGBColor* color;

@end
