//
//  main.m
//  Serializer
//
//  Created by admin on 11/07/16.
//  Copyright © 2016 Saveliy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSNumber+Serializer.h"
#import "NSValue+Serializer.h"
#import "NSDictionary+Serializer.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSError *error = nil;
        CGRect rect = {1,2,3,4};
        NSValue *val = [NSValue valueWithRect:rect];
        NSDictionary *dict = @{@1:@[@112, @345],
                               @2:val};
        NSLog(@"%@", [dict serializeWithError:&error]);
    }
    return 0;
}
