//
//  ViewController.m
//  pacman
//
//  Created by towry on 8/15/16.
//  Copyright © 2016 towry. All rights reserved.
//

#import "ViewController.h"
#import "StartScene.h"

@interface ViewController()

@property (assign) IBOutlet SKView *skView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    StartScene *scene = [[StartScene alloc] initWithSize:CGSizeMake(768, 1024)];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [self.skView presentScene:scene];
    
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
}

// Why use this?
//- (void)setRepresentedObject:(id)representedObject {
//    [super setRepresentedObject:representedObject];
//}

@end
