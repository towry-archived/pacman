//
//  StartGameSegue.m
//  pacman
//
//  Created by towry on 8/16/16.
//  Copyright © 2016 towry. All rights reserved.
//

#import "StartGameSegue.h"
#import "StartGameAnimator.h"

@implementation StartGameSegue

- (void)perform {
    id animator = [[StartGameAnimator alloc] init];
    [self.sourceController presentViewController:self.destinationController
                                        animator:animator];
}

@end
