//
//  NSDictionary+Serializable.h
//  noveo-homework-4
//
//  Created by Wadim on 7/23/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SEContainerSerializer.h"

@interface NSDictionary (Serializable)

- (NSString *)serialize:(NSError *__autoreleasing*)error;

@end
