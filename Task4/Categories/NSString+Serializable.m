//
//  NSString+Serializable.m
//  Task4
//
//  Created by Sergey Plotnikov on 17.07.16.
//
//

#import "NSString+Serializable.h"

@implementation NSString (Serializable)

- (NSString *)serialize:(NSError *__autoreleasing *)error
{
    return [NSString stringWithFormat:@"%@", self.description];
}

@end
