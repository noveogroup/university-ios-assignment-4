//
//  Serializator.m
//  Serializator
//
//  Created by Иван Букшев on 3/1/15.
//  Copyright (c) 2015 Иван Букшев. All rights reserved.
//

#import "Serializator.h"

@implementation Serializator

- (NSString *)serialize:(id)dictionary error:(NSError *__autoreleasing *)error
{
    if ([dictionary isKindOfClass:[NSDictionary class]])
    {
        return [[dictionary serializeWithError:error] copy];
    }
    else if (!!error)
    {
        NSDictionary *info = @{@"InputDataIsNotDictionary" : [dictionary class]};
        (*error) = [NSError errorWithDomain:@"MyDomain"
                                       code:errorInputObjectIsNotDictionary
                                   userInfo:info];
    }
    
    return nil;
}

@end
