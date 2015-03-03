//
//  NSDictionary+serializable.h
//  Serializator
//
//  Created by Иван Букшев on 3/2/15.
//  Copyright (c) 2015 Иван Букшев. All rights reserved.
//

#import "Header.h"

@interface NSDictionary (serializable)

- (NSMutableString *)serializeWithError:(NSError *__autoreleasing *)error;

@end
