//
//  NSNumber+Serialize.m
//  Serializer
//
//  Created by Vik on 24.02.16.
//  Copyright © 2016 Viktor Erfilov. All rights reserved.
//

#import "VEErrors.h"
#import "NSNumber+Serialize.h"

@implementation NSNumber (Serialize)

- (NSString *)serializeWithError:(NSError **)error {
    
    return [NSString stringWithFormat:@"%@", self];
    
}

@end
