//
//  ViewController.m
//  pacman
//
//  Created by towry on 8/15/16.
//  Copyright © 2016 towry. All rights reserved.
//

#import "ViewController.h"
#import "StartScreenView.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setup start screen delegate
    StartScreenView *view = (StartScreenView *)[self startScreen];
    [view setDelegate:self];
    // draw the view background
    [self.view setWantsLayer:YES];
    self.view.layer.backgroundColor = [NSColor blackColor].CGColor;
    
//    SKView *spriteView = (SKView *) self.view;
//    spriteView.showsDrawCount = YES;
//    spriteView.showsNodeCount = YES;
//    spriteView.showsFPS = YES;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

// start the game
- (void)startGame:(NSEvent *)event {
    [self performSegueWithIdentifier:@"pacmanId" sender:self];
}

@end
