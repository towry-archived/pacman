//
//  EntityNode.m
//  pacman
//
//  Created by towry on 20/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import "EntityNode.h"

@implementation EntityNode
- (instancetype)init {
    if (self = [super init]) {
        self.entityType = EntityWall;
        self.direction = DirectionLeft;
        self.index = 0;
    }
    
    return self;
}
@end
