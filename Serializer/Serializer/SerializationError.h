//
//  SerializationError.h
//  Serializer
//
//  Created by Admin on 28/07/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SerializationError : NSError

typedef NS_ENUM(NSUInteger, SerializationErrorCode)
{
    unsupportedObject = 100,
    notDictionary = 101,
    wrongKeyType = 102
};

+ (SerializationError *) getUnsupportedObjectErrorForClassName:(NSString *)className;
+ (SerializationError *) getWrongKeyTypeErrorForClassName:(NSString *)className;
+ (SerializationError *) getNotDictionaryErrorForClassName:(NSString *)className;

@end
