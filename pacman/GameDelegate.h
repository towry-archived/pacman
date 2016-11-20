//
//  GameDelegate.h
//  pacman
//
//  Created by towry on 20/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import "ViewDelegate.h"
#import "EntityNode.h"

@class EntityNode;

#ifndef GameDelegate_h
#define GameDelegate_h

@protocol GameDelegate <NSObject>
- (void)moveToNextPoint:(EntityNode *)node;
@end

#endif /* GameDelegate_h */
