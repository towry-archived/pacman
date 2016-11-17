//
//  GameScene.m
//  pacman
//
//  Created by towry on 14/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import "GameScene.h"
#import "PacmanNode.h"
#import "ViewDelegate.h"

@interface GameScene()
@property BOOL contentCreated;
@property SKSpriteNode *pacman;
@end

@implementation GameScene

#pragma mark - Init

- (void)didMoveToView:(SKView *)view {
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

#pragma mark - Init:create

- (void)createSceneContents {
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    [self addChild:[self getMapNode]];
    [self addChild:[self getPacmanNode]];
}

- (SKSpriteNode *)getMapNode {
    SKTexture *bgtexture = [SKTexture textureWithImageNamed:@"blue_map.png"];
    SKSpriteNode *bg = [SKSpriteNode spriteNodeWithTexture:bgtexture];
    bg.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    return bg;
}

- (PacmanNode *)getPacmanNode {
    PacmanNode *pacman = [[PacmanNode alloc] init];
    pacman.name = @"pacman";
    
    pacman.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    return pacman;
}

#pragma mark - Update
- (void)update:(NSTimeInterval)currentTime {
    NSArray *nodes = @[ @"pacman" ];
    SKNode<Character> *node = nil;
    
    for (NSString *name in nodes) {
        node = (SKNode<Character> *)[self childNodeWithName:name];
        [node update:currentTime];
    }
}
@end
