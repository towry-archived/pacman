//
//  StartScene.m
//  pacman
//
//  Created by towry on 15/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import "StartScene.h"

@interface StartScene()

@property BOOL contentCreated;

@end

@implementation StartScene

- (void)didMoveToView:(SKView *)view {
    if (!self.contentCreated) {
        [self createContents];
        self.contentCreated = YES;
    }
}

- (void)createContents {
    
}

@end
