//
//  MapData.m
//  pacman
//
//  Created by towry on 19/11/2016.
//  Copyright © 2016 towry. All rights reserved.
//

#import "MapData.h"

const char *kMapFile = "map";
const int kGridNumH = 19;
const int kGridNumV = 25;

@interface MapData() {
    NSArray *_map;
}
@end

@implementation MapData
- (instancetype)init {
    self = [super init];
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:kMapFile] ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    [self initWithString:content];
    
    return self;
}

- (void)initWithString:(NSString *)content {
    NSArray *arr = [content componentsSeparatedByString:@"\n"];
    _map = arr;
}

- (void)map:(void (^)(NSArray *))block {
    if (_map == nil) {
        return;
    }
    
    block(_map);
}
@end
