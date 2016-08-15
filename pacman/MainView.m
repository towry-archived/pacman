//
//  MainView.m
//  pacman
//
//  Created by towry on 8/15/16.
//  Copyright © 2016 towry. All rights reserved.
//

#import <math.h>
#import "MainView.h"


@implementation MainView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
	
	// background
	[[NSColor blackColor] setFill];
	NSRectFill(dirtyRect);
	[self oatDrawStartScreen];
}

- (void)oatDrawStartScreen {
	NSImage *image = [NSImage imageNamed:@"pacman.png"];
	
	NSRect theBounds = self.bounds;
	
	NSSize imageSize = image.size;
	CGFloat left = fabs(theBounds.size.width / 2.0 - imageSize.width / 2.0);
	NSPoint origin = NSMakePoint(left, theBounds.size.height - 48 - 20);
	NSRect fromRect = NSMakeRect(2, imageSize.height - 50, 182, 47);
	CGFloat delta = 1.0;
	
//	NSLog(@"%f:%f", theBounds.size.width / 2, imageSize.width / 2);
	
	[image drawAtPoint:origin fromRect:fromRect operation:NSCompositeSourceOver fraction:delta];
}

- (void)mouseDown:(NSEvent *)theEvent {
	if (_delegate && [_delegate respondsToSelector:@selector(startGame:)]) {
		[_delegate startGame:theEvent];
	}
}

@end
