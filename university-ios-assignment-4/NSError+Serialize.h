//
// Created by admin on 12/07/16.
// Copyright (c) 2016 tanya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Serialize)

+ (instancetype)errorNotDictionary:(id)object;
+ (instancetype)errorIncorrectType:(id)object;
+ (instancetype)errorInvalidKey:(id)object;
@end