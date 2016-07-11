//
//  Serializer.m
//  university-ios-assignment-4
//
//  Created by Admin on 10.07.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "Serializer.h"
#import "NSDictionary+Serialize.h"

@implementation Serializer

+ (NSString *)serializerByDictionary:(id)dictionary
                               error:(NSError **)error
{
    if ([dictionary isKindOfClass:[NSDictionary class]] ){
        NSString *string = [dictionary serialiseWithError:error];
        if(*error){
            return nil;
        }
        return string;
    } else{
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Not dictionary - %@", [dictionary class]]
                                   };
        *error = [[NSError alloc]initWithDomain:SerializerErrorDomain code:SerializerErrorNotDictionary userInfo:userInfo];
        return nil;
    }
    return nil;
}
@end
