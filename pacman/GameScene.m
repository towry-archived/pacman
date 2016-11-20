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
#import "Node.h"
#import "EntityNode.h"

const int kSpace = 8;
const int kGridH = 19;

@interface GameScene() {
    NSMutableArray *nodeMap;
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
}

- (SKSpriteNode *)getMapNode {
    SKTexture *bgtexture = [SKTexture textureWithImageNamed:@"blue_map.png"];
    SKSpriteNode *bg = [SKSpriteNode spriteNodeWithTexture:bgtexture];
    bg.name = @"blue_map";
    bg.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    return bg;
}

- (PacmanNode *)getPacmanNode {
    PacmanNode *pacman = [[PacmanNode alloc] init];
    pacman.name = @"pacman";

    return pacman;
}

- (void)drawMap:(MapData *)map {
    SKNode *blueMap = [self childNodeWithName:@"blue_map"];
    
    // Without offset, the pean map will not in good position.
    int leftOffset = 11;
    int topOffset = 2;
    __block int x = 0;
    __block int y = blueMap.position.y + (blueMap.frame.size.height * 0.5) - topOffset;
    
    nodeMap = [NSMutableArray arrayWithCapacity:20];
    [map map:^(NSArray *data){
        NSUInteger count = [data count];
        NSUInteger i;
        for (i = 0; i < count; i++) {
            NSString *line = [data objectAtIndex:i];
            
            x = blueMap.position.x - (blueMap.frame.size.width * 0.5) + leftOffset;
            y -= kSpace;
            
            NSUInteger lineLength = line.length;
            for (NSInteger j = 0; j < kGridH; j++) {
                EntityEnum entity;
                EntityNode *node;
                if (j < lineLength) {
                    entity = [self getEntity:[line characterAtIndex:j]];
                    node = [self getNodeByEntity:entity];
                } else {
                    entity = EntityWall;
                    node = nil;
                }
                
                if (node != nil) {
                    node.position = CGPointMake(x, y);
                    node.index = i + j;
                    [node setGameDelegate:self];
                    [self addChild:node];
                    [nodeMap addObject:node];
                } else {
                    [nodeMap addObject:@""];
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
        case 'P':
            return EntityPacman;
        default:
            return EntityWall;
    }
}

- (EntityNode *)getNodeByEntity:(EntityEnum)entity {
    EntityNode *node = nil;
    switch (entity) {
        case EntityPean:
            node = [self getPeanNode:NO];
            break;
        case EntityBigPean:
            node = [self getPeanNode:YES];
            break;
        case EntityPacman:
            node = [self getPacmanNode];
            break;
        default:
            break;
    }
    return node;
}

- (EntityNode *)getPeanNode:(bool)big {
    NSString *name = big ? @"pean_big.png" : @"pean.png";
    SKTexture *texture = [SKTexture textureWithImageNamed:name];
    EntityNode *node = [EntityNode spriteNodeWithTexture:texture];
    node.entityType = big ? EntityBigPean : EntityPean;
    
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

- (void)moveToNextPoint:(EntityNode *)node {
    NSUInteger nodeIndex = node.index;
    NodeDirection dir = node.direction;
    EntityNode *next = [self getNextNode:nodeIndex direction:dir];
    if (next == nil || [next isEqual: @""]) {
        return;
    } else {
        node.position = next.position;
        [next removeFromParent];
    }
}

- (nullable EntityNode *)getNextNode:(NSUInteger)nodeIndex direction:(NodeDirection)dir {
    NSUInteger indexAtRow = nodeIndex % kGridH;
    NSUInteger nextIndex;
    
    switch (dir) {
        case DirectionUp:
            nextIndex = nodeIndex - kGridH;
            break;
        case DirectionDown:
            nextIndex = nodeIndex + kGridH;
            break;
        case DirectionLeft:
            if (indexAtRow == 1) {
                nextIndex = -1;
            } else {
                nextIndex = nodeIndex - 1;
            }
            break;
        case DirectionRight:
            if (indexAtRow == 0) {
                nodeIndex = -1;
            } else {
                nextIndex = nodeIndex + 1;
            }
            break;
        default:
            nodeIndex = -1;
            break;
    }
    
    NSLog(@"%lu - %lu", (unsigned long)nodeIndex, (unsigned long)nextIndex);
    
    if (nextIndex == -1) {
        return nil;
    }
    
    return [nodeMap objectAtIndex:nextIndex];
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
