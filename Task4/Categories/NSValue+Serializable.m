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
    if (strcmp(self.objCType, @encode(NSRect))) {
        
        if (error) {
            *error = [NSError errorWithDomain:kSerializationErrorDomain
                                         code:SerializationErrorCodeObjectCanNotBeSerialized
                                     userInfo:nil];
            return nil;
        }
        
    }
    NSString *tmpString = [self description];
    return [NSString stringWithFormat:@"%@",
            [tmpString substringFromIndex:[@"NSRect: " length]]];
}

@end
