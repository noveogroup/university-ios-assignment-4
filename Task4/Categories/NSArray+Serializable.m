//
//  NSObject+NSDictionaty_Serialize.m
//  Task4
//
//  Created by Sergey Plotnikov on 13.07.16.
//
//

#import "NSArray+Serializable.h"
#import "Serializable.h"

@implementation NSArray (Serializable)

- (NSString *)serialize:(NSError *__autoreleasing *)error
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (id obj in self) {
        if ([obj conformsToProtocol: @protocol(Serializable)]) {
            NSString *tmpString = [obj serialize:error];
            if (*error) {
                return nil;
            }
            [mutableArray addObject:tmpString];
        } else {
            *error = [NSError errorWithDomain:@"ru.nsu.plotnikov.NSArray+Serializable"
                                         code:SerializationErrorCodeObjectCanNotBeSerialized
                                     userInfo:nil];
            return nil;
        }
    }
    NSString *result = [mutableArray componentsJoinedByString:@", "];
    return [NSString stringWithFormat:@"{%@}", result];
}


@end
