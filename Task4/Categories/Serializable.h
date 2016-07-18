//
//  Serializable.h
//  Task4
//
//  Created by Sergey Plotnikov on 14.07.16.
//
//

#import <Foundation/Foundation.h>

NSString *const kSerializationErrorDomain;

@protocol Serializable <NSObject>

typedef NS_ENUM (NSInteger, SerializationErrorCode) {
    SerializationErrorCodeContainerIsNotDictionary = 1,
    SerializationErrorCodeInvalidKeyType = 2,
    SerializationErrorCodeObjectCanNotBeSerialized = 3
};

@optional
- (NSString *)serialize:(NSError *__autoreleasing *)error;

@end
