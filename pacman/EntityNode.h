//
//  EntityNode.h
//  pacman
//
//  Created by towry on 20/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ViewDelegate.h"
#import "GameDelegate.h"
#import "Node.h"

@protocol GameDelegate;

@interface EntityNode : SKSpriteNode
@property NodeDirection direction;
@property EntityEnum entityType;
@property NSUInteger index;
@property (nonatomic, nullable, readwrite) id<GameDelegate> gameDelegate;
@end
