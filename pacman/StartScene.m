//
//  StartScene.m
//  pacman
//
//  Created by towry on 15/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import "StartScene.h"

@interface StartScene()

@property BOOL contentCreated;

@end

@implementation StartScene

#pragma mark - override

- (void)didMoveToView:(SKView *)view {
    if (!self.contentCreated) {
        [self createContents];
        self.contentCreated = YES;
    }
}

#pragma mark - method

- (void)createContents {
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    [self addChild:[self getLogoNode]];
}

- (SKSpriteNode *)getLogoNode {
    // logo.
    SKTexture *logo = [SKTexture textureWithImageNamed:@"logo.png"];
    SKSpriteNode *logoNode = [SKSpriteNode spriteNodeWithTexture:logo];
    
    
    CGFloat scaleFactor = 2;
    CGFloat logoWidth = 187 * scaleFactor;
    CGFloat logoHeight = 48 * scaleFactor;
    
    [logoNode scaleToSize:CGSizeMake(logoWidth, logoHeight)];
    
    // position the logo.
    CGFloat logoTop = 80 + logoNode.size.height;
    CGFloat logoLeft = self.size.width / 2;
    logoNode.position = CGPointMake(logoLeft, self.size.height - logoTop);
    
    return logoNode;
}

- (void)keyUp:(NSEvent *)event {
    NSString *keyPressed = [event characters];
    if ([keyPressed isEqualToString:@" "]) {
        // start
        if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(startGame)]) {
            [self.viewDelegate startGame];
        }
    }
}

@end
