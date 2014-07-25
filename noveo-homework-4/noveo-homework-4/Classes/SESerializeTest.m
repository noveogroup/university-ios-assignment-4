//
//  SESerializeTest.m
//  noveo-homework-4
//
//  Created by Wadim on 7/25/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import "SESerializeTest.h"
#import "SEContainerSerializer.h"
#import "NSString+Tabulateble.h"

@implementation SESerializeTest

+ (void) test:(id)testingObject {
    NSError *__autoreleasing error = nil;
    NSString *serializedObject = [SEContainerSerializer serialize:testingObject error:&error];
    if (testingObject && !error) {
        NSLog(@"\nObject has been serialized: \n%@",[NSString tabulatedStringFromString:serializedObject withSpaces:@"   "]);
    }
    else {
        NSLog(@"\n\nSerialize error has been occured:\n%@",[error description]);
    }
}

@end
