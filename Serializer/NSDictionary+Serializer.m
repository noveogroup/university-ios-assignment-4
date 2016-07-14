//
//  NSDictionary+Serializer.m
//  Serializer
//

#import "NSDictionary+Serializer.h"
#import "NSError+Serializer.h"

@implementation NSDictionary (Serializer)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    *error = nil;
    NSMutableString *result = [NSMutableString stringWithString:@"{\n"];
    for (id key in self) {
        NSString *keyString;
        NSString *objectString;
        if ([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]]) {
            keyString = [key serializeWithError:error];
        }
        else {
            *error = [NSError errorWithKey:key];
            return nil;
        }
        if ([self[key] conformsToProtocol:@protocol(Serializable)]) {
            objectString = [self[key] serializeWithError:error];
        }
        else {
            *error = [NSError errorWithObject:self[key]];
            return nil;
        }
        if (*error) {
            return nil;
        }
        else {
            [result appendFormat:@"%@ : %@\n", keyString, objectString];
        }
    }
    [result appendString:@"}"];
    return [result copy];
}

@end
