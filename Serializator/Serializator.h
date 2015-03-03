//
//  Serializator.h
//  Serializator
//
//  Created by Иван Букшев on 3/1/15.
//  Copyright (c) 2015 Иван Букшев. All rights reserved.
//

#import "Header.h"

@interface Serializator : NSObject

- (NSString *)serialize:(id)dictionary error:(NSError *__autoreleasing *) error;

@end
