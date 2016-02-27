//
//  NSError+Serialize.m
//  Serializer
//
//  Created by Vik on 27.02.16.
//  Copyright © 2016 Viktor Erfilov. All rights reserved.
//

#import "NSError+Serialize.h"

@implementation NSError (Serialize)

+ (instancetype)errorInvalidObjectType:(id)object {
    
    if (self == [NSError class]) {
        
        NSString *errorMessage = [NSString stringWithFormat: @"Object of type %@ is not supported", NSStringFromClass([object class])];
        
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorMessage};
        
        return [NSError errorWithDomain:VEErrorDomain
                                   code:VEErrorDictionaryContainsInvalidObjectType
                               userInfo:userInfo];

    }
    
    return nil;
}

+ (instancetype)errorInvalidKeyType:(id)object {
    
    if (self == [NSError class]) {
        
        NSString *errorMessage = [NSString stringWithFormat: @"Key of type %@ is not supported", NSStringFromClass([object class])];
        
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorMessage};
        
        return [NSError errorWithDomain:VEErrorDomain
                                   code:VEErrorKeyIsObjectOfIncorrectType
                               userInfo:userInfo];
    }
    
    return nil;
}


+ (instancetype)errorObjectNotDictionary:(id)object {
    
    if (self == [NSError class]) {
        NSString *errorMessage = [NSString stringWithFormat: @"Object of type %@ is not dictionary", NSStringFromClass([object class])];
        
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorMessage};
        
        return [NSError errorWithDomain:VEErrorDomain
                                   code:VEErrorObjectNotDictionary
                               userInfo:userInfo];
    }
    
    return nil;
}


@end
