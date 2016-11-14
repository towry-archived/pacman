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
    
    GameScene *scene = [[GameScene alloc] initWithSize:CGSizeMake(768, 1024)];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [self.skView presentScene:scene];
    
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
}

@end
