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
    
    // create rocks.
    SKAction *makeRocks = [SKAction sequence: @[[SKAction performSelector:@selector(addRock) onTarget:self],
                                                [SKAction waitForDuration: 0.10 withRange: 0.15]]];
    [self runAction: [SKAction repeatActionForever:makeRocks]];
}

static inline CGFloat skRandf() {
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
}

- (void)addRock {
    SKSpriteNode *rock = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(8, 8)];
    rock.position = CGPointMake(skRand(0, self.size.width), self.size.height - 50);
    rock.name = @"rock";
    rock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection = YES;
    [self addChild:rock];
}

- (SKSpriteNode *)newSpaceship {
    SKSpriteNode *hull = [[SKSpriteNode alloc] initWithColor:[SKColor grayColor] size:CGSizeMake(64,32)];
    
    SKSpriteNode *light1 = [self newLight];
    light1.position = CGPointMake(-28.0, 6.0);
    [hull addChild:light1];
    
    SKSpriteNode *light2 = [self newLight];
    light2.position = CGPointMake(28.0, 6.0);
    [hull addChild:light2];
    
    SKAction *hover = [SKAction sequence:@[
       [SKAction waitForDuration:1.0],
       [SKAction moveByX:100 y:50.0 duration:1.0],
       [SKAction waitForDuration:1.0],
       [SKAction moveByX:-100.0 y:-50 duration:1.0]]
                       ];
    [hull runAction: [SKAction repeatActionForever:hover]];
    
    hull.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hull.size];
    hull.physicsBody.dynamic = NO;
    
    return hull;
}

- (SKSpriteNode *)newLight {
    SKSpriteNode *light = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(8,8)];
    
    SKAction *blink = [SKAction sequence:@[
                                           [SKAction fadeOutWithDuration:0.25],
                                           [SKAction fadeInWithDuration:0.25]]];
    SKAction *blinkForever = [SKAction repeatActionForever:blink];
    [light runAction: blinkForever];
    
    return light;
}

- (SKLabelNode *)newHelloNode {
    SKLabelNode *helloNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    helloNode.text = @"Hello, World";
    helloNode.fontSize = 42;
    helloNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    helloNode.name = @"helloNode";
    return helloNode;
}

- (void)didSimulatePhysics {
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0) {
            [node removeFromParent];
        }
    }];
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
