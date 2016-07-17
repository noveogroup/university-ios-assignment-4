//
//  NSValue+Serialize.m
//  Task4
//
//  Created by Sergey Plotnikov on 14.07.16.
//
//

#import "NSValue+Serializable.h"
#import "Serializable.h"

@implementation NSValue (Serializable)

+ (NSValue *)valueWithCGRect:(CGRect)cgrect
{
    return [NSValue valueWithRect:NSRectFromCGRect(cgrect)];
}

- (NSString *)serialize:(NSError *__autoreleasing *)error
{
    NSString *tmpString = [self description];
    NSRange range = [tmpString rangeOfString:@"NSRect: "];
    if (range.location == NSNotFound) {
        if (error) {
            *error = [NSError errorWithDomain:@"ru.nsu.plotnikov.NSValue+Serializable"
                                         code:SerializationErrorCodeObjectCanNotBeSerialized
                                     userInfo:nil];
        }
        return nil;
    }
    return [NSString stringWithFormat:@"%@",
        [tmpString substringFromIndex:[@"NSRect: " length]]];
}

@end
