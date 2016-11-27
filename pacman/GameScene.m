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
const int kGridV = 25;

@interface GameScene() {
    EntityNode *nodeMap[kGridV][kGridH];
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
    
//    nodeMap = [NSMutableArray arrayWithCapacity:20];
    [map map:^(NSArray *data){
        NSUInteger count = [data count];
        NSLog(@"%ld", count);

        for (int i = 0; i < count; i++) {
            NSString *line = [data objectAtIndex:i];
            
            x = blueMap.position.x - (blueMap.frame.size.width * 0.5) + leftOffset;
            y -= kSpace;

            NSUInteger lineLength = line.length;
            if (lineLength < 2) {
                continue;
            }
            
            for (int j = 0; j < kGridH; j++) {
                EntityEnum entity;
                EntityNode *node;
                if (j < lineLength) {
                    entity = [self getEntity:[line characterAtIndex:j]];
                    node = [self getNodeByEntity:entity];
                } else {
                    node = [[EntityNode alloc] init];
                    node.entityType = EntityWall;
                }
                
                if (node != nil) {
                    node.x = j;
                    node.y = i;
                    if (node.entityType != EntityWall) {
                        node.position = CGPointMake(x, y);
                        [node setGameDelegate:self];
                        [self addChild:node];
                    }
                    nodeMap[i][j] = node;
                } else {
                    nodeMap[i][j] = nil;
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
            node = [[EntityNode alloc] init];
            node.entityType = EntityWall;
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

- (EntityNode *)getNextNode:(EntityNode *)node {
    NodeDirection dir = node.direction;
    EntityNode *next = [self _getNextNode:dir x:node.x y:node.y];
    return next;
}

- (EntityNode *)_getNextNode:(NodeDirection)dir x:(int)x y:(int)y {
    int _x, _y;
    
    switch (dir) {
        case DirectionUp:
            NSLog(@"dir: up");
            _x = x;
            _y = y - 1;
            if (_y < 0) {
                return nil;
            }
            break;
        case DirectionDown:
            NSLog(@"dir: down");
            _x = x;
            _y = y + 1;
            if (_y >= kGridV) {
                return nil;
            }
            break;
        case DirectionLeft:
            NSLog(@"dir: left");
            _x = x - 1;
            _y = y;
            if (_x < 0) {
                return nil;
            }
            break;
        case DirectionRight:
            NSLog(@"dir: right");
            _x = x + 1;
            _y = y;
            if (_x >= kGridH) {
                return nil;
            }
            break;
        default:
            return nil;
    }
    NSLog(@"previous: (%d, %d), next: (%d, %d)", y, x, _y, _x);
    return nodeMap[_y][_x];
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
