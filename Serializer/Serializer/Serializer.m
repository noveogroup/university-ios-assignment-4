//
//  Serializer.m
//  Serializer
//
//  Created by Admin on 23/07/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import "Serializer.h"

@interface Serializer ()
-(NSString*)stringWithObject:(id)object error:(NSError*__autoreleasing *)error;
@end

@implementation Serializer
-(NSString*)stringWithDictionary:(id)dictionary error:(NSError *__autoreleasing *)error{
    if([dictionary isKindOfClass:[NSDictionary class]])
        return [self stringWithObject:dictionary error:error];
    //error
    return nil;
}
-(NSString*)stringWithObject:(id)object error:(NSError *__autoreleasing *)error{
    NSMutableString* res = [[NSMutableString alloc]init];
    for(id cur in object){
        if([cur isKindOfClass:[NSDictionary class]]){
            
        } else if([cur isKindOfClass:[NSArray class]]){
            
        } else if([cur isKindOfClass:[NSSet class]]){
            
        }
    }
    return nil;
}
@end
