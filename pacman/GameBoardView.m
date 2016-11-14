//
//  GameBoardView.m
//  pacman
//
//  Created by towry on 14/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import "GameBoardView.h"
#import "GameScene.h"

@implementation GameBoardView

//- (void)drawRect:(NSRect)dirtyRect {
//    [super drawRect:dirtyRect];
//    
//    [[NSColor blackColor] setFill];
//    NSRectFill(dirtyRect);
//    [self drawBackgroundImage];
//}

//- (void)drawBackgroundImage {
//    NSImage *image = [NSImage imageNamed:@"pacman.png"];
//    NSRect theBounds = self.bounds;
//    NSSize imageSize = image.size;
//    
//    CGFloat bgWidth = 100;
//    CGFloat bgHeight = 47;
//    CGFloat offsetTop = 0;
//}

//- (void)viewWillAppear:(BOOL)animated {
//    GameBoardView *view = [[GameBoardView alloc] initWithSize:CGSizeMake(768, 1024)];
//    SKView *spriteView = (SKView *)self.view;
//    [spriteView presentScene:view];
//}

- (void)viewWillMoveToWindow:(NSWindow *)newWindow {
    if (newWindow != nil) {
        [self presentScene];
    }
}

- (void)presentScene {
    GameScene *scene = [[GameScene alloc] initWithSize:CGSizeMake(768, 1024)];
    SKView *spriteView = (SKView *) self;
    [spriteView presentScene:scene];
}

@end
