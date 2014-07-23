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

+ (NSString *)serialize:(id)sourceObject error:(NSError *__autoreleasing *) anError {
    if ([sourceObject respondsToSelector:@selector(serialize:)]) {
        return [sourceObject serialize:anError];
    }
    else {
        *anError = [NSError errorWithDomain:@"com.se.containerSerializer" code:1 userInfo:[NSDictionary dictionary]];
        return nil;
    }
}


@end
