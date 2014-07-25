//
//  Serializer.m
//  Serializer
//
//  Created by Admin on 23/07/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import "Serializer.h"

@interface Serializer ()

- (NSString *) serializeDictionary:(NSDictionary *)dictionary
                           atDepth:(unsigned int)depth
                         withError:(NSError *__autoreleasing *)error;

- (NSString *) serializeArray:(NSArray *)array
                      atDepth:(unsigned int)depth
                    withError:(NSError *__autoreleasing *)error;

- (NSString *) serializeSet:(NSSet *)set
                    atDepth:(unsigned int)depth
                  withError:(NSError *__autoreleasing *)error;

- (NSString *) serializeNumber:(NSNumber *)number
                       atDepth:(unsigned int)depth
                     withError:(NSError *__autoreleasing *)error;

- (NSString *) serializeNull:(NSDictionary *)nullObject
                     atDepth:(unsigned int)depth
                   withError:(NSError *__autoreleasing *)error;

- (NSString *) serializeCGRect:(NSValue *)rect
                       atDepth:(unsigned int)depth
                     withError:(NSError *__autoreleasing *)error;

@end

@implementation Serializer

- (NSString *)serialize:(id)dictionary
                  error:(NSError **)error {
    if (![dictionary isMemberOfClass:[NSDictionary class]]) {
        // TODO: create WrongClass error
        
        return nil;
    }
    
    return [self serializeDictionary:dictionary atDepth:0 withError:error];
}

- (NSString *)serializeDictionary:(NSDictionary *)dictionary atDepth:(unsigned int)depth withError:(NSError *__autoreleasing *)error {
    return nil;
}

- (NSString *)serializeArray:(NSArray *)array atDepth:(unsigned int)depth withError:(NSError *__autoreleasing *)error {
    return nil;
}

- (NSString *)serializeSet:(NSSet *)set atDepth:(unsigned int)depth withError:(NSError *__autoreleasing *)error {
    return nil;
}

- (NSString *)serializeNumber:(NSNumber *)number atDepth:(unsigned int)depth withError:(NSError *__autoreleasing *)error {
    return nil;
}

- (NSString *)serializeNull:(NSDictionary *)nullObject atDepth:(unsigned int)depth withError:(NSError *__autoreleasing *)error {
    return nil;
}

- (NSString *)serializeCGRect:(NSValue *)rect atDepth:(unsigned int)depth withError:(NSError *__autoreleasing *)error {
    return nil;
}

@end
