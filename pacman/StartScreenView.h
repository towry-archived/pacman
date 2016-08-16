//
//  MainView.h
//  pacman
//
//  Created by towry on 8/15/16.
//  Copyright © 2016 towry. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ViewDelegate.h"

@interface StartScreenView : NSView

@property(nonatomic, readwrite, weak) id<ViewDelegate> delegate;

@end
