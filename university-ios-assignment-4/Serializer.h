//
//  Serializer.h
//  university-ios-assignment-4
//
//  Created by Admin on 10.07.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Serilisable.h"

@interface Serializer : NSObject

+ (NSString *)serializerByDictionary:(id)dictionary
                               error:(NSError **)error;

@end
