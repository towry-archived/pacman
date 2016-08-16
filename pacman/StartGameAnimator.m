//
//  StartGameAnimator.m
//  pacman
//
//  Created by towry on 8/16/16.
//  Copyright © 2016 towry. All rights reserved.
//

#import "StartGameAnimator.h"

@implementation StartGameAnimator

// show
- (void)animatePresentationOfViewController:(NSViewController *)viewController fromViewController:(NSViewController *)fromViewController {
    // for smooth animation
    viewController.view.wantsLayer = YES;
    // redraw policy
    viewController.view.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
    // invisible
    viewController.view.alphaValue = 0.0;
    // add view of presented viewController
    [fromViewController.view addSubview:viewController.view];
    
    // ajust size
    [viewController.view setFrame:[fromViewController.view frame]];
    viewController.view.layer.backgroundColor = [NSColor blackColor].CGColor;
    
    // show it
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 0.6;
        viewController.view.animator.alphaValue = 1.0;
    } completionHandler:nil];
}

// hide
- (void)animateDismissalOfViewController:(NSViewController *)viewController fromViewController:(NSViewController *)fromViewController {
    // for smooth animation
    viewController.view.wantsLayer = YES;
    // redraw policy
    viewController.view.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
    // hide it
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 0.6;
        viewController.view.animator.alphaValue = 0.0;
    } completionHandler:^{
        [viewController.view removeFromSuperview];
    }];
}

@end
