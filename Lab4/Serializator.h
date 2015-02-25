//
//  Serializator.h
//  Lab4
//
//  Created by Пользователь on 25/02/15.
//  Copyright (c) 2015 Пользователь. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SerializatorProtocol.h"

@interface Serializator : NSObject

+(id<SerializatorProtocol>) initSerializatorByObject:(NSObject*) object
                                    error:(NSError*) error;

-(NSString*) serializeDictinary:(NSDictionary*) dictinary
                         error:(NSError*) error;
@end
