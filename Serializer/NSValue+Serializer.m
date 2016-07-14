//
//  NSValue+Serializer.m
//  Serializer
//

#import "NSValue+Serializer.h"
#import "NSError+Serializer.h"

@implementation NSValue (Serializer)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    *error = nil;
    NSMutableString *result = nil;
    if (strcmp(self.objCType, @encode(CGRect)) != 0) {
        *error = [NSError errorWithValue:self];
        return nil;
    }
    else {
        result = [NSMutableString stringWithFormat:@"%@", self];
    }
    return [result copy];
}

@end
