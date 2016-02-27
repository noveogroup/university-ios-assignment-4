//
//  ViewController.m
//  Serializer
//
//  Created by Vik on 23.02.16.
//  Copyright © 2016 Viktor Erfilov. All rights reserved.
//

#import "VESerializer.h"
#import "VEErrors.h"
#import "NSError+Serialize.h"


@interface VESerializer ()

@end

@implementation VESerializer

- (NSString *)serializeDictionary:(id)dict withError:(NSError **)error {
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
                
        return [dict serializeWithError:error];
    
    } else {
        
        if (error) {
                        
            (*error) = [NSError errorObjectNotDictionary:dict];
            
            return nil;
        }
    
    }
    
    return nil;
}





@end
