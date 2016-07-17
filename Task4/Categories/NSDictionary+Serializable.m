//
//  NSObject+NSDictionary.m
//  Task4
//
//  Created by Sergey Plotnikov on 13.07.16.
//
//

#import "NSDictionary+Serializable.h"
#import "Serializable.h"

@implementation NSDictionary (Serializable)

- (NSString *)serialize:(NSError *__autoreleasing *)error
{
    NSMutableString *serializationString = [NSMutableString string];
    NSString *tmpString = nil;
    
    for (id key in self) {
        if (!([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]])) {
            *error = [NSError errorWithDomain:@"ru.nsu.plotnikov.NSDictionary+Serializable"
                                        code:SerializationErrorCodeInvalidKeyType
                                    userInfo:nil];
            return serializationString;
        }
        
        if ([[self objectForKey:key] conformsToProtocol:@protocol(Serializable)]) {
            if ((tmpString = [[self objectForKey:key]serialize:error])) {
                [serializationString appendString:[NSString stringWithFormat:@"\nKey: \"%@\"\n", key]];
                [serializationString appendString:tmpString];
            }
            else if (error) {
                *error = [NSError errorWithDomain:@"ru.nsu.plotnikov.NSDictionary+Serializable"
                                             code:SerializationErrorCodeObjectCanNotBeSerialized
                                         userInfo:nil];
                serializationString = nil;
                return serializationString;
            }
        }
    }

    return serializationString;
}


@end
