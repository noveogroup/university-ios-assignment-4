//
//  NSNull+Serializable.h
//  noveo-homework-4
//
//  Created by Wadim on 7/24/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNull (Serializable)

- (NSString *)serialize:(NSError *__autoreleasing*)error;

@end
