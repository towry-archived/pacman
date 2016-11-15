//
//  SpaceshipScene.m
//  pacman
//
//  Created by towry on 15/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import "SpaceshipScene.h"

@interface SpaceshipScene()

@property BOOL contentCreated;

@end

@implementation SpaceshipScene

- (void)didMoveToView:(SKView *)view {
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents {
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
}

@end
