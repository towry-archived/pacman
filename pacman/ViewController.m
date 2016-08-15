//
//  ViewController.m
//  pacman
//
//  Created by towry on 8/15/16.
//  Copyright © 2016 towry. All rights reserved.
//

#import "ViewController.h"
#import "MainView.h"

@implementation ViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	
	MainView *view = (MainView *)[self view];
	[view setDelegate:self];
	[self setUpConstraints];
}

- (void)setRepresentedObject:(id)representedObject {
	[super setRepresentedObject:representedObject];
}

- (void)startGame:(NSEvent *)event {
	NSLog(@"Game started");
}

- (void)setUpConstraints {
	NSLayoutGuide *margins = self.view.layoutGuides;
}

@end
