//
//  Serializer.m
//  Serializer
//
//  Created by Admin on 23/07/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import "Serializer.h"
#import "NSDictionary+serializable.h"

@implementation Serializer
-(NSString*)serializeDictionary:(id)dictionary error:(NSError *__autoreleasing *)error{
    if([dictionary isKindOfClass:[NSDictionary class]])
        return [[dictionary serializeWithError:error] copy];
    if (!!error) {
        NSDictionary* userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  @"Input Object is not dictionary",
                                  [dictionary class], nil];
        (*error) = [NSError errorWithDomain:@"serializerErrorDomain"
                                       code:serializeErrorInputObjectIsNotDictionary
                                   userInfo:userInfo];
    }
    return nil;
}
@end
