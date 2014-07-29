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

+ (SerializationError *)getNotDictionaryErrorForClass:(Class)classValue {
    
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"NSDictionary expected instead of %@", NSStringFromClass(classValue)] };
    
    return [NSError errorWithDomain:domain
                               code:ErrorCodeForNotDictionary
                           userInfo:userInfo];
}

+ (SerializationError *)getUnsupportedObjectErrorForClass:(Class)classValue {
    
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Unsupported object type: %@", NSStringFromClass(classValue)] };
    
    return [NSError errorWithDomain:domain
                               code:ErrorCodeForUnsupportedObject
                           userInfo:userInfo];
}

+ (SerializationError *)getWrongKeyTypeErrorForClass:(Class)classValue {
    
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Wrong type of NSDictionary key: %@", NSStringFromClass(classValue)] };
    
    return [NSError errorWithDomain:domain
                               code:ErrorCodeForWrongKeyType
                           userInfo:userInfo];
}

@end
