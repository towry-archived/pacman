//
//  GameController.m
//  pacman
//
//  Created by towry on 14/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import "GameController.h"
#import "GameScene.h"

@implementation GameController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.skView.alphaValue = 0.0;
    // NSLog(@"%f - %f", self.view.frame.size.width, self.view.frame.size.height);
    GameScene *scene = [[GameScene alloc] initWithSize:CGSizeMake(self.view.frame.size.width
, self.view.frame.size.height)];
    scene.scaleMode = SKSceneScaleModeAspectFit;
    
    [self.skView presentScene:scene];
    
#if DEBUG
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
#endif
}

@end
