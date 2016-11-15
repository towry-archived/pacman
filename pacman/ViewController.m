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
    scene.scaleMode = SKSceneScaleModeAspectFit;
    [scene setViewDelegate:self];
    
    [self.skView presentScene:scene];
    
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
    self.skView.showsPhysics = YES;
}

- (void)startGame {
    if (self.bGameStarted) {
        return;
    }
    self.bGameStarted = YES;
    [self performSegueWithIdentifier:@"startGameSegue" sender:self];
    
    NSLog(@"start game.");
}

@end

// start game segue.
@implementation StartGameSegue

- (void)perform {
    id animator = [[StartGameAnimator alloc] init];
    [self.sourceController presentViewController:self.destinationController animator:animator];
}

@end

// start game animator.
@implementation StartGameAnimator

// show.
- (void)animatePresentationOfViewController:(NSViewController *)viewController fromViewController:(nonnull NSViewController *)fromViewController {
    viewController.view.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
    
    viewController.view.wantsLayer = YES;
    // Do not know why this not working,
    // probably because SKView can not have alphaVlue work.
    // invisible
//    viewController.view.alphaValue = 0.0;
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
//        context.duration = 2.f;
        [fromViewController.view.window setContentViewController:viewController];
//        viewController.view.animator.alphaValue = 1.0;
    } completionHandler:nil];
}

// dismiss.
- (void)animateDismissalOfViewController:(NSViewController *)viewController fromViewController:(NSViewController *)fromViewController {
}

@end

