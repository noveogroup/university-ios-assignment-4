//
//  NSSet+Serializer.m
//  Serializer
//

#import "NSSet+Serializer.h"
#import "NSError+Serializer.h"

@implementation NSSet (Serializer)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    *error = nil;
    NSMutableString *result = [NSMutableString stringWithString:@"(\n"];
    NSString *objString;
    for (id obj in self) {
        if ([obj conformsToProtocol:@protocol(Serializable)]) {
            objString = [obj serializeWithError:error];
        }
        else {
            *error = [NSError errorWithObject:obj];
            return nil;
        }
        if (!*error) {
            [result appendFormat:@"%@\n",objString];
        }
        else {
            return nil;
        }
    }
    [result appendString:@")"];
    return [result copy];
}

@end
