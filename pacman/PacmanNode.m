//
//  PacmanNode.m
//  pacman
//
//  Created by towry on 17/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import "PacmanNode.h"

@implementation PacmanNode
#pragma mark - override
- (id)init {
    if (self = [super init]) {
        SKTexture *beanTexture = [SKTexture textureWithImageNamed:@"pacman_left_open.png"];
        self = [PacmanNode spriteNodeWithTexture:beanTexture];
    }
    
    return self;
}

- (void)update:(NSTimeInterval)currentTime {
    
}

#pragma mark - method
- (void)start {
    NSLog(@"start in pacman ...");
}
@end
