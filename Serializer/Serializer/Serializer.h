//
//  Serializer.h
//  Serializer
//
//  Created by Admin on 23/07/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Serializer : NSObject
-(NSString*)stringWithDictionary:(id)dictionary error:(NSError*__autoreleasing *)error;
@end
