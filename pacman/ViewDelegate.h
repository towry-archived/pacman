//
//  ViewDelegate.h
//  pacman
//
//  Created by towry on 8/15/16.
//  Copyright © 2016 towry. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#ifndef ViewDelegate_h
#define ViewDelegate_h

@protocol ViewDelegate <NSObject>
- (void)startGame;
@end

@protocol Character <NSObject>
- (void)update:(NSTimeInterval)currentTime;
@end

#endif /* ViewDelegate_h */
