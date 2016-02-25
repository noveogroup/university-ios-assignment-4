//
//  ViewController.m
//  Serializer
//
//  Created by Vik on 23.02.16.
//  Copyright © 2016 Viktor Erfilov. All rights reserved.
//

#import "VESerializer.h"
#import "VEErrors.h"


@interface VESerializer ()

@end

@implementation VESerializer

- (NSString *)serializeDictionary:(id)dict withError:(NSError **)error {
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
                
        return [NSString stringWithFormat:@"%@", [dict serializeWithError:error]];
    
    } else {
        
        if (error) {
            
            NSDictionary *userInfo = @{@"ObjectNotDictionary" : [dict class]};
            
            (*error) = [NSError errorWithDomain:VEErrorDomain
                                           code:VEErrorObjectNotDictionary
                                       userInfo:userInfo];
            return nil;
        }
    
    }
    
    return nil;
}




@end
