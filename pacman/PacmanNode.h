//
//  PacmanNode.h
//  pacman
//
//  Created by towry on 17/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ViewDelegate.h"
#import "Node.h"
#import "EntityNode.h"

@interface PacmanNode : EntityNode <Character>
- (void)update:(NSTimeInterval)currentTime;
- (void)handleKeyEvent:(NSEvent *)event;
@end
