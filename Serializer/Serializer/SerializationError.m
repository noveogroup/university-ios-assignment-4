//
//  SerializationError.m
//  Serializer
//
//  Created by Admin on 28/07/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import "SerializationError.h"

@implementation SerializationError

NSString *domain = @"com.noveogroup.summerinternship2014.Serializer.SerializationError";

+ (SerializationError *)getNotDictionaryErrorForClassName:(NSString *)className {
    
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"NSDictionary expected instead of %@", className] };
    
    return [NSError errorWithDomain:domain
                               code:notDictionary
                           userInfo:userInfo];
}

+ (SerializationError *)getUnsupportedObjectErrorForClassName:(NSString *)className {
    
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Unsupported object type: %@", className] };
    
    return [NSError errorWithDomain:domain
                               code:unsupportedObject
                           userInfo:userInfo];
}

+ (SerializationError *)getWrongKeyTypeErrorForClassName:(NSString *)className {
    
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Wrong type of NSDictionary key: %@", className] };
    
    return [NSError errorWithDomain:domain
                               code:wrongKeyType
                           userInfo:userInfo];
}

@end
