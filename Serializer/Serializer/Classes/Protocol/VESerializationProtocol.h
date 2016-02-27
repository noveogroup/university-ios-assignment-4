//
//  SerializationProtocol.h
//  Serializer
//
//  Created by Vik on 27.02.16.
//  Copyright © 2016 Viktor Erfilov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VESerializationProtocol <NSObject>

@optional
- (NSString *)serializeWithError:(NSError **)error;

@end
