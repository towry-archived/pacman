//
//  ViewController.h
//  pacman
//
//  Created by towry on 8/15/16.
//  Copyright © 2016 towry. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ViewDelegate.h"
#import <SpriteKit/SpriteKit.h>

@interface ViewController : NSViewController <ViewDelegate>

@property(weak) IBOutlet NSWindow *window;
@property BOOL bGameStarted;
@end


// Custom segue
@interface StartGameSegue : NSStoryboardSegue
@end

// segue animator
@interface StartGameAnimator : NSObject<NSViewControllerPresentationAnimator>
@end
