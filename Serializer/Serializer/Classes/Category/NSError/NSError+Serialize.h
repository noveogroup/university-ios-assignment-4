//
//  NSError+Serialize.h
//  Serializer
//
//  Created by Vik on 27.02.16.
//  Copyright © 2016 Viktor Erfilov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VEErrors.h"

@interface NSError (Serialize)

+ (instancetype)errorObjectNotDictionary:(id)object;
+ (instancetype)errorInvalidObjectType:(id)object;
+ (instancetype)errorInvalidKeyType:(id)object;


@end
