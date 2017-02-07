//
//  NSNull+Serializable.m
//  noveo-homework-4
//
//  Created by Wadim on 7/24/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import "NSNull+Serializable.h"

@implementation NSNull (Serializable)

- (NSString *)serialize:(NSError *__autoreleasing*)error {
    // Just return "null" value
    return @"<NSNull>\nnull\n</NSNull>\n";
}

@end
