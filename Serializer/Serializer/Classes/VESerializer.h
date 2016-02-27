//
//  ViewController.h
//  Serializer
//
//  Created by Vik on 23.02.16.
//  Copyright © 2016 Viktor Erfilov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VESerializationProtocol.h"


@interface VESerializer : NSObject <VESerializationProtocol>


- (NSString *)serializeDictionary:(id)dict withError:(NSError **)error;


@end

