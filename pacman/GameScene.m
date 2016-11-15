//
//  GameScene.m
//  pacman
//
//  Created by towry on 14/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import "GameScene.h"
#import "SpaceshipScene.h"

@interface GameScene()

@property BOOL contentCreated;

@end

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents {
    self.backgroundColor = [SKColor blueColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    [self addChild: [self newHelloNode]];
    
    SKSpriteNode *spaceship = [self newSpaceship];
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-150);
    [self addChild:spaceship];
}

- (SKSpriteNode *)newSpaceship {
    SKSpriteNode *hull = [[SKSpriteNode alloc] initWithColor:[SKColor grayColor] size:CGSizeMake(64,32)];
    
    SKAction *hover = [SKAction sequence:@[
                                           [SKAction waitForDuration:1.0],
                                           [SKAction moveByX:100 y:50.0 duration:1.0],
                                           [SKAction waitForDuration:1.0],
                                           [SKAction moveByX:-100.0 y:-50 duration:1.0]]];
    [hull runAction: [SKAction repeatActionForever:hover]];
    
    return hull;
}

- (SKLabelNode *)newHelloNode {
    SKLabelNode *helloNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    helloNode.text = @"Hello, World";
    helloNode.fontSize = 42;
    helloNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    helloNode.name = @"helloNode";
    return helloNode;
}

- (void)mouseDown:(NSEvent *)event {
    SKNode *helloNode = [self childNodeWithName:@"helloNode"];
    if (helloNode != nil) {
        helloNode.name = nil;
        SKAction *moveUp = [SKAction moveByX:0 y: 100.0 duration: 0.5];
        SKAction *zoom = [SKAction scaleTo: 2.0 duration: 0.25];
        SKAction *pause = [SKAction waitForDuration: 0.5];
        SKAction *fadeAway = [SKAction fadeOutWithDuration: 0.25];
        SKAction *remove = [SKAction removeFromParent];
        SKAction *moveSequence = [SKAction sequence:@[moveUp, zoom, pause, fadeAway, remove]];
        [helloNode runAction: moveSequence completion:^ {
            SKScene *spaceshipScene = [[SpaceshipScene alloc] initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration: 0.5];
            [self.view presentScene:spaceshipScene transition:doors];
        }];
    }
}

@end
