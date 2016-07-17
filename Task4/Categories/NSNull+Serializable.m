//
//  NSNull+Serializable.m
//  Task4
//
//  Created by Sergey Plotnikov on 15.07.16.
//
//

#import "NSNull+Serializable.h"

@implementation NSNull (Serializable)

- (NSString *)serialize:(NSError *__autoreleasing *)error
{
    return [NSString stringWithFormat:@"%@", self.description];
}

@end
