//
//  Serializable.h
//  Serializer
//
//  Created by Admin on 25/07/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import <Foundation/Foundation.h>

// All classes that can be serialized with Serializer
// must implement this protocol
@protocol Serializable <NSObject>

@required
- (NSString *) serializeAtDepth:(unsigned int)depth
                      withError:(NSError *__autoreleasing *)error;

@end
