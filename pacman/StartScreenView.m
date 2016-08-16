//
//  StartScreenView.m
//  pacman
//
//  Created by towry on 8/15/16.
//  Copyright © 2016 towry. All rights reserved.
//

#import <math.h>
#import "StartScreenView.h"


@implementation StartScreenView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
	
	// background
	[[NSColor blackColor] setFill];
	NSRectFill(dirtyRect);
	[self oatDrawStartScreen];
}

- (BOOL)acceptsFirstResponder {
	return YES;
}

- (void)oatDrawStartScreen {
	
	NSImage *image = [NSImage imageNamed:@"pacman.png"];
	NSRect theBounds = self.bounds;
	NSSize imageSize = image.size;
	
	/*** start draw the logo */
	CGFloat logoWidth = 182;
	CGFloat logoHeight = 47;
	CGFloat logoOffsetTop = 100;
	
	CGFloat left = fabs(theBounds.size.width / 2.0 - logoWidth / 2.0);
	
	NSPoint origin = NSMakePoint(left, theBounds.size.height - logoHeight - logoOffsetTop);
	NSRect fromRect = NSMakeRect(2, imageSize.height - 50, 182, 47);
	CGFloat delta = 1.0;
	
	[image drawAtPoint:origin fromRect:fromRect operation:NSCompositeSourceOver fraction:delta];
	/**< end draw the logo */
}

- (void)keyDown:(NSEvent *)theEvent {
	if (_delegate && [_delegate respondsToSelector:@selector(startGame:)]) {
		[_delegate startGame:theEvent];
	}
}

@end
