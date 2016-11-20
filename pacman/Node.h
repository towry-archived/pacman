//
//  Node.h
//  pacman
//
//  Created by towry on 20/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#ifndef Node_h
#define Node_h

typedef enum {
    DirectionUp,
    DirectionLeft,
    DirectionRight,
    DirectionDown,
} NodeDirection;

typedef enum {
    EntityPean,      // o
    EntityBigPean,   // m
    EntityWall,      // w
    EntityBlock,     // x
    EntityCellBlock, // T
    EntityPacman,    // P
} EntityEnum;

#endif /* Node_h */
