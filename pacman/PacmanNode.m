//
//  PacmanNode.m
//  pacman
//
//  Created by towry on 17/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import "PacmanNode.h"

const int kSpeed = 10;
const int kMoveSpeed = 18;

@interface PacmanNode()
@property NSTimeInterval timeCount;
@property NSTimeInterval moveTimeCount;
@property NSUInteger textureIndex;
@property BOOL bPause;
@property BOOL animating;
@end

@implementation PacmanNode
#pragma mark - Override
- (id)init {
    if (self = [super init]) {
        self.entityType = EntityPacman;
        SKTexture *beanTexture = [SKTexture textureWithImageNamed:@"pacman_left_open.png"];
        self = [PacmanNode spriteNodeWithTexture:beanTexture];
        [self scaleToSize:CGSizeMake(8, 8)];
    }
    
    self.textureIndex = 0;
    self.timeCount = 0;
    self.moveTimeCount = 0;
    self.animating = NO;
    
    return self;
}

- (void)update:(NSTimeInterval)currentTime {
    [self moveToNextPoint];
    if (self.bPause) {
        return;
    }
    
    // This control the pacman mouth speed.
    if (self.timeCount < kSpeed) {
        self.timeCount += 1;
        return;
    } else if (self.timeCount >= kSpeed) {
        self.timeCount = 0;
    }
    
    if (self.textureIndex >= 2) {
        self.textureIndex = 0;
    } else {
        self.textureIndex += 1;
    }
    
    NSString *textureName = [[self class] textureName:self.textureIndex direction:self.direction];
    SKTexture *nextTexture = [SKTexture textureWithImageNamed:textureName];
    [self setTexture:nextTexture];
    [self scaleToSize:CGSizeMake(8, 8)];
}

- (void)pause {
    self.bPause = YES;
}

- (void)resume {
    self.bPause = NO;
}

- (void)moveToNextPoint {
    if (self.animating) {
        self.moveTimeCount = 0;
        return;
    }
    
    if (self.moveTimeCount < kMoveSpeed) {
        self.moveTimeCount += 1;
        return;
    } else if (self.moveTimeCount >= kMoveSpeed) {
        self.moveTimeCount = 0;
    }
    
    EntityNode *next;
    if (self.gameDelegate && [self.gameDelegate respondsToSelector:@selector(getNextNode:)]) {
        next = [self.gameDelegate getNextNode:self];
    }
    
    if (next == nil) {
        [self pause];
        return;
    }
    
    if (next.entityType != EntityWall) {
        SKAction *moveToNext = [SKAction moveTo:next.position duration:0.3];
        self.animating = YES;
        [self runAction:moveToNext completion:^(void) {
            self.x = next.x;
            self.y = next.y;
            // Remove node.
            if (next.entityType == EntityPean ||
                next.entityType == EntityBigPean) {
                [next removeFromParent];
            }
            self.animating = NO;
        }];
        return;
    }
    [self pause];
}

#pragma mark - Event
- (void)handleKeyEvent:(NSEvent*)event {
    // Handle arrow key event.
    unichar character = [[event characters] characterAtIndex:0];
    switch (character) {
        case NSUpArrowFunctionKey:
            self.direction = DirectionUp;
            break;
        case NSDownArrowFunctionKey:
            self.direction = DirectionDown;
            break;
        case NSLeftArrowFunctionKey:
            self.direction = DirectionLeft;
            break;
        case NSRightArrowFunctionKey:
            self.direction = DirectionRight;
            break;
        default:
            return;
    }
    
    if (self.bPause) {
        [self resume];
    }
}

#pragma mark - Method

+ (NSString *)textureName:(NSInteger)index direction:(NodeDirection)direction {
    static NSArray *_textureNames;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       _textureNames = @[@"pacman_full.png",
                         @"pacman_%@_open.png",
                         @"pacman_%@_open_max.png",];
    });
    
    if (index == 0) {
        return _textureNames[index];
    }
    
    if (index < 0 || index >= _textureNames.count) {
        [NSException raise:@"Invalid index value" format:@"index of %ld is invalid", (long)index];
    }
    
    NSString *placeholder = nil;
    switch (direction) {
        case DirectionUp:
            placeholder = @"up";
            break;
        case DirectionLeft:
            placeholder = @"left";
            break;
        case DirectionRight:
            placeholder = @"right";
            break;
        case DirectionDown:
            placeholder = @"down";
            break;
        default:
            placeholder = @"top";
            break;
    }
    
    return [NSString stringWithFormat:_textureNames[index], placeholder];
}
@end
