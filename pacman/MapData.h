//
//  MapData.h
//  pacman
//
//  Created by towry on 19/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapData : NSObject
- (void)initWithString:(NSString *)content;
- (void)map:(void (^)(NSArray *))block;
@end
