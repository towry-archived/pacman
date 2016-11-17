//
//  PacmanNode.m
//  pacman
//
//  Created by towry on 17/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import "PacmanNode.h"

@interface PacmanNode()
@property NSInteger index;
@property NSTimeInterval timeCount;
@property enum PacmanNodeDirection direction;
@end

@implementation PacmanNode

#pragma mark - override
- (id)init {
    if (self = [super init]) {
        SKTexture *beanTexture = [SKTexture textureWithImageNamed:@"pacman_left_open.png"];
        self = [PacmanNode spriteNodeWithTexture:beanTexture];
    }
    
    self.index = 0;
    self.timeCount = 0;
    self.direction = DirectionLeft;
    
    return self;
}

- (void)update:(NSTimeInterval)currentTime {
    // This control the pacman mouth speed.
    if (self.timeCount < 8) {
        self.timeCount += 1;
        return;
    } else if (self.timeCount >= 8) {
        self.timeCount = 0;
    }
    
    if (self.index >= 2) {
        self.index = 0;
    } else {
        self.index += 1;
    }
    
    NSString *textureName = [[self class] textureName:self.index direction:self.direction];
    SKTexture *nextTexture = [SKTexture textureWithImageNamed:textureName];
    [self setTexture:nextTexture];
}

#pragma mark - method

+ (NSString *)textureName:(NSInteger)index direction:(enum PacmanNodeDirection)direction {
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
        case DirectionTop:
            placeholder = @"up";
            break;
        case DirectionLeft:
            placeholder = @"left";
            break;
        case DirectionRight:
            placeholder = @"right";
            break;
        case DirectionBottom:
            placeholder = @"bottom";
            break;
        default:
            placeholder = @"top";
            break;
    }
    
    return [NSString stringWithFormat:_textureNames[index], placeholder];
}
@end
