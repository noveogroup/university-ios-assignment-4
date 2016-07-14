
#import "Foundation/Foundation.h"

typedef NS_ENUM(NSUInteger, SerialisationErrorCode) {
    SerialisationErrorNonDictionaryRootObject,
    SerialisationErrorInvalidValueObject,
    SerialisationErrorInvalidKeyObject
};

extern NSString *const SerialisationErrorDomain;

@protocol Serializing <NSObject>

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error;

@end