//
//  Serializable.h
//  Serializer
//
//  Created by admin on 11/07/16.
//  Copyright © 2016 Saveliy. All rights reserved.
//

@class NSMutableString;
@class NSError;

@protocol Serializable <NSObject>

- (NSMutableString *)serializeError:(NSError *__autoreleasing*)error;

@end