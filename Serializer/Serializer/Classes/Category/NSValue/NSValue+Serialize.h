//
//  NSValue+Serialize.h
//  Serializer
//
//  Created by Vik on 24.02.16.
//  Copyright © 2016 Viktor Erfilov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSValue (Serialize)

- (NSString *)serializeWithError:(NSError **)error;

@end
