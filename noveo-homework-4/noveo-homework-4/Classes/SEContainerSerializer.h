//
//  SEContainerSerializer.h
//  noveo-homework-4
//
//  Created by Wadim on 7/23/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

/*
 * Class serialize input NSDictionary, NSArray, NSSet, NSNumber, NSNull or CGRect [NSValue] to NSString
 * and can notificate user with NSError about state of serializing
 *
 */

#import <Foundation/Foundation.h>

@interface SEContainerSerializer : NSObject

+ (NSString *)serialize:(id)sourceObject error:(NSError *__autoreleasing *) anError;

@end
