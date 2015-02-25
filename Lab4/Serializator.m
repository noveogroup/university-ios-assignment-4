//
//  Serializator.m
//  Lab4
//
//  Created by Пользователь on 25/02/15.
//  Copyright (c) 2015 Пользователь. All rights reserved.
//

#import "Serializator.h"
#import "Serializator_NSDictinary.h"
#import "Serializator_NSSet.h"
#import "Serializator_NSArray.h"
#import "Serializator_NSNull.h"
#import "Serializator_NSNumber.h"
#import "Serializator_NSValue.h"

@class Serializator_NSDictinary;

@implementation Serializator

+(id<SerializatorProtocol>) initSerializatorByObject:(NSObject*) object
                                   error:(NSError*) error
{
    
    if ([object isKindOfClass:[NSDictionary class]])
        return [[Serializator_NSDictinary alloc] init];
    
    if ([object isKindOfClass:[NSSet class]])
        return [[Serializator_NSSet alloc] init];
    
    if ([object isKindOfClass:[NSArray class]])
        return [[Serializator_NSArray alloc] init];
    
    if ([object isKindOfClass:[NSNull class]])
        return [[Serializator_NSNull alloc] init];
    
    if ([object isKindOfClass:[NSValue class]])
        return [[Serializator_NSValue alloc] init];
    
    if ([object isKindOfClass:[NSNumber class]])
        return [[Serializator_NSNumber alloc] init];
    
    return nil;
}

-(NSString*) serializeDictinary:(NSDictionary *)dictinary error:(NSError *)error
{
    return [[Serializator initSerializatorByObject:dictinary error:error] serializeByObject:dictinary error:error];
}

@end
