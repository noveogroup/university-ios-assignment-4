//
//  SEContainerSerializer.m
//  noveo-homework-4
//
//  Created by Wadim on 7/23/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import "SEContainerSerializer.h"
#import "NSDictionary+Serializable.h"

@implementation SEContainerSerializer


+ (NSString *)serialize:(id)sourceObject error:(NSError *__autoreleasing *) error {
    NSString *xmlString = nil;
    if ([sourceObject isKindOfClass:[NSDictionary class]]) {
        xmlString = [sourceObject serialize:error];
    }
    else {
        if (error) {
            *error = [NSError errorWithDomain:@"com.se.containerSerializer"
                                         code:serializeErrorCodeRootIsNotDictionary
                                     userInfo:nil];
        }

        return nil;
    }
    return xmlString;
}


@end
