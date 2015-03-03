//
//  Header.h
//  Serializator
//
//  Created by Иван Букшев on 3/1/15.
//  Copyright (c) 2015 Иван Букшев. All rights reserved.
//

#ifndef Serializator_Header_h
#define Serializator_Header_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "AppDelegate.h"
#import "NSDictionary+serializable.h"
#import "NSArray+serializable.h"
#import "NSSet+serializable.h"
#import "NSNull+serializable.h"
#import "NSNumber+serializable.h"

typedef enum
{
    // 0 - Successed finish.
    errorInputObjectIsNotDictionary = 1,
    errorObjectIsNotSerializable,
    errorWrongKey
    
} SerializatorError;

#endif
