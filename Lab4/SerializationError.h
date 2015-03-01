//
//  SerializationError.h
//  Lab4
//
//  Created by Пользователь on 28/02/15.
//  Copyright (c) 2015 Пользователь. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    ErrorWrongInputParameters = 100,
    ErrorNotSupportedObject = 200,
    ErrorNotSupportedKeyOnDictinary = 300
} Error;

@interface SerializationError : NSObject

+(NSError*) getErrorWrongInputParametersWithClass:(Class) _class;
+(NSError*) getErrorNotSupportedKeyWithClass:(Class) _class;
+(NSError*) getErrorNotSupportedObjectWithClass:(Class) _class;

@end
