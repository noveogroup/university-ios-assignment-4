//
//  NSValue+Serialize.m
//  Serializer
//
//  Created by Vik on 24.02.16.
//  Copyright © 2016 Viktor Erfilov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSValue+Serialize.h"
#import "NSDictionary+Serialize.h"

@implementation NSValue (Serialize)

- (NSString *)serializeWithError:(NSError **)error {
    
    CGRect rect = [self CGRectValue];
    NSNumber *originX = [NSNumber numberWithFloat:rect.origin.x];
    NSNumber *originY = [NSNumber numberWithFloat:rect.origin.y];
    NSNumber *width = [NSNumber numberWithFloat:rect.size.width];
    NSNumber *height = [NSNumber numberWithFloat:rect.size.height];

    NSDictionary *dict = @{@"rect" : @{@"originX" : originX,
                                       @"originY" : originY,
                                       @"width" : width,
                                       @"height" : height}};
    
    return [dict serializeWithError:error];
}

@end
