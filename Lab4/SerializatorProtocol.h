//
//  SerializatorProtocol.h
//  Lab4
//
//  Created by Пользователь on 25/02/15.
//  Copyright (c) 2015 Пользователь. All rights reserved.
//

#ifndef Lab4_SerializatorProtocol_h
#define Lab4_SerializatorProtocol_h

@protocol SerializatorProtocol <NSObject>

-(NSString*) serializeByObject:(NSObject*) object
                         error:(NSError*) error;

@end

#endif
