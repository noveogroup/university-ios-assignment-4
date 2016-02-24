//
//  ViewController.h
//  Serializer
//
//  Created by Vik on 23.02.16.
//  Copyright © 2016 Viktor Erfilov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VESerializer : NSObject


- (NSString *)serializeDictionary:(id)dict withError:(NSError *__autoreleasing *)error;


@end

