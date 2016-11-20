//
//  StartScene.h
//  pacman
//
//  Created by towry on 15/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ViewDelegate.h"

@interface StartScene : SKScene
@property(nonatomic, nullable, readwrite) id<ViewDelegate> viewDelegate;
@end
