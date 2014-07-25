//
//  NSValue+serializable.h
//  Serializer
//
//  Created by Admin on 25/07/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSValue(serializable)
-(NSMutableString*)serializeWithError:(NSError* __autoreleasing *)error;
@end
