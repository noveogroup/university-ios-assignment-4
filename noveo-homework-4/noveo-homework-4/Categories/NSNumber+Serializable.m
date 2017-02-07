//
//  NSNumber+Serializable.m
//  noveo-homework-4
//
//  Created by Wadim on 7/23/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import "NSNumber+Serializable.h"

@implementation NSNumber (Serializable)

- (NSString *)serialize:(NSError *__autoreleasing*)error {
    // Just return correct value
    return [NSString stringWithFormat:@"<NSNumber>\n%@\n</NSNumber>\n",[self description]];
}


@end
