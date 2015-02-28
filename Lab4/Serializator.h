//
//  Serializator.h
//  Lab4
//
//  Created by Пользователь on 25/02/15.
//  Copyright (c) 2015 Пользователь. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Serializator : NSObject

-(NSString*) serializeByDictinary:(id) dictinary
                          error:(NSError *__autoreleasing *) error;
@end
