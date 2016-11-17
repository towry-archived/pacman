//
//  PacmanNode.h
//  pacman
//
//  Created by towry on 17/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ViewDelegate.h"

enum PacmanNodeDirection {
    DirectionTop,
    DirectionLeft,
    DirectionRight,
    DirectionBottom,
};

@interface PacmanNode : SKSpriteNode <Character>
- (void)update:(NSTimeInterval)currentTime;
@end
