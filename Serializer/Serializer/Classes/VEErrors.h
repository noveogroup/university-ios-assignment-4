//
//  VEErrors.h
//  Serializer
//
//  Created by Vik on 24.02.16.
//  Copyright © 2016 Viktor Erfilov. All rights reserved.
//


#import <Foundation/Foundation.h>

extern NSString *const VEErrorDomain;

typedef enum {
    VEErrorNoErrors,
    VEErrorObjectNotDictionary,
    VEErrorDictionaryContainsInvalidObjectType,
    VEErrorKeyIsObjectOfIncorrectType,
} VEErrorCode;


