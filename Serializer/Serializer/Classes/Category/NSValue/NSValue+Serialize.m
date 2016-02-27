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
    
    if(strcmp([self objCType], @encode(CGRect)) == 0) {
        
        CGRect rect = [self CGRectValue];
        NSNumber *originX = @(rect.origin.x);
        NSNumber *originY = @(rect.origin.y);
        NSNumber *width = @(rect.size.width);
        NSNumber *height = @(rect.size.height);
        
        NSDictionary *dict = @{@"rect" : @{@"originX" : originX,
                                           @"originY" : originY,
                                           @"width" : width,
                                           @"height" : height}};
        
        return [dict serializeWithError:error];

    }
    
    return nil;
}

@end


