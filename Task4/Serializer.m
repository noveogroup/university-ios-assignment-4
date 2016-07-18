//
//  Serializer.m
//  Task4
//
//  Created by Sergey Plotnikov on 13.07.16.
//
//

#import <Foundation/Foundation.h>
#import "Serializer.h"

@implementation Serializer

+ (NSString *)serializeContainer:(id)container error:(NSError *__autoreleasing *)error
{
    NSString *serializationString = nil;
    
    if ([container isKindOfClass: NSDictionary.class]) {
        serializationString = [container serialize:error];
    } else {
        *error = [NSError errorWithDomain:kSerializationErrorDomain
                                    code:SerializationErrorCodeContainerIsNotDictionary
                                userInfo:nil];
        return nil;
    }
    return serializationString;
}

@end
