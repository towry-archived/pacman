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
#import "MapData.h"

const int kSpace = 3;
typedef enum {
    EntityPean,      // o
    EntityBigPean,   // m
    EntityWall,      // w
    EntityBlock,     // x
    EntityCellBlock, // T
    EntityOther,     // other
} EntityEnum;

@interface GameScene() {
    CGFloat gridWidth;
    CGFloat gridHeight;
}

@property BOOL contentCreated;
@end

@implementation GameScene

#pragma mark - Init

- (void)didMoveToView:(SKView *)view {
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
    
    MapData *map = [[MapData alloc] init];
    [self drawMap:map];
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

- (void)drawMap:(MapData *)map {
    __block int x = 0;
    __block int y = self.frame.size.height;
    
    [map map:^(NSArray *data){
        NSUInteger count = [data count];
        NSUInteger i;
        for (i = 0; i < count; i++) {
            NSString *line = [data objectAtIndex:i];
            
            x = 0;
            y -= kSpace;
            
            for (NSInteger j = 0; j < line.length; j++) {
                EntityEnum entity = [self getEntity:[line characterAtIndex:j]];
                SKNode *node = [self getNodeByEntity:entity];
                if (node != nil) {
                    node.position = CGPointMake(x, y);
                    [self addChild:node];
                }
                
                x += kSpace;
            }
        }
    }];
}

- (EntityEnum)getEntity:(const char)s {
    switch (s) {
        case 'o':
            return EntityPean;
        case 'm':
            return EntityBigPean;
        case 'x':
            return EntityBlock;
        case 'T':
            return EntityCellBlock;
        case 'w':
            return EntityWall;
        default:
            return EntityOther;
    }
}

- (SKNode *)getNodeByEntity:(EntityEnum)entity {
    SKNode *node = nil;
    switch (entity) {
        case EntityPean:
            node = [self getPeanNode:NO];
            break;
        case EntityBigPean:
            node = [self getPeanNode:YES];
        default:
            break;
    }
    return node;
}

- (SKSpriteNode *)getPeanNode:(bool)big {
    NSString *name = big ? @"pean_big.png" : @"pean.png";
    SKTexture *texture = [SKTexture textureWithImageNamed:name];
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:texture];
    
    return node;
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

#pragma mark - Event
- (void)keyUp:(NSEvent *)event {
    NSArray *nodes = @[ @"pacman" ];
    SKNode *node = nil;

    for (NSString *name in nodes) {
        node = [self childNodeWithName:name];
        if ([node respondsToSelector:@selector(handleKeyEvent:)]) {
            [node performSelector:@selector(handleKeyEvent:) withObject:event];
        }
    }
}
@end
