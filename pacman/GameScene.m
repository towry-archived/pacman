//
//  GameScene.m
//  pacman
//
//  Created by towry on 14/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import "GameScene.h"

@interface GameScene()

@property BOOL contentCreated;

@end

@implementation GameScene

#pragma mark - override

- (void)didMoveToView:(SKView *)view {
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

#pragma mark - method

- (void)createSceneContents {
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    [self addChild: [self getMapNode]];
    [self addChild: [self getBeanNode]];
}

- (SKSpriteNode *)getMapNode {
    SKTexture *bgtexture = [SKTexture textureWithImageNamed:@"pacman_blue_map.png"];
    SKSpriteNode *bg = [SKSpriteNode spriteNodeWithTexture:bgtexture];
    bg.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    return bg;
}

- (SKSpriteNode *)getBeanNode {
    SKTexture *beanTexture = [SKTexture textureWithImageNamed:@"bean_left_open.png"];
    SKSpriteNode *beanNode = [SKSpriteNode spriteNodeWithTexture:beanTexture];
    beanNode.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    return beanNode;
}

@end
