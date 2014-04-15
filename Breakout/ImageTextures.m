//
//  ImageTextures.m
//  Modeling
//
//  Created by Minglun Gong on 20/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageTextures.h"
//#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/gl.h>

@interface ImageTextures () {
	int _numTexture;
	GLuint *_textureIDs;
}

- (ImageTextures*) initNumTexture: (int) num;
- (void)dealloc;
- (void)loadTextureAt: (int)at from: (NSString *)file;
- (void)bindTextureAt: (int)at;

@end

@implementation ImageTextures

-(ImageTextures*) initNumTexture: (int) num {
	self = [super init];
	
	if ( self ) {
		_numTexture = num;
		_textureIDs = (GLuint *)malloc(num*sizeof(GLuint));
		glGenTextures(num, _textureIDs);
	}
	
	return self;
}

- (void)dealloc {
	
	glDeleteTextures(_numTexture, _textureIDs);
	free(_textureIDs);
}

- (void)loadTextureAt : (int) at from:(NSString *)file {
	CGImageRef texImage = [UIImage imageNamed:file].CGImage;
	if ( ! texImage ) {
		NSLog(@"Texture file not found!");
		return;
	}

	int texWidth = (int)CGImageGetWidth(texImage);
	int texHeight = (int)CGImageGetHeight(texImage);
	
	GLubyte *texData = (GLubyte*)malloc(texWidth * texHeight * 4);
	
	CGContextRef texContext = CGBitmapContextCreate(texData, texWidth, texHeight, 8, texWidth*4,
        CGImageGetColorSpace(texImage), kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
	CGContextDrawImage(texContext, CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight), texImage);
	CGContextRelease(texContext);
	
	glBindTexture(GL_TEXTURE_2D, _textureIDs[at]);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, texData);
	
	free(texData);
}

- (void)bindTextureAt : (int) at {
	glEnable(GL_TEXTURE_2D);

	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	
	glBindTexture(GL_TEXTURE_2D, _textureIDs[at]);
};

@end
