
#import "Foundation/Foundation.h"

typedef NS_ENUM(NSUInteger, SerialisationErrorCode) {
    SerialisationErrorNonDictionaryRootObject,
    SerialisationErrorInvalidValueObject,
    SerialisationErrorInvalidKeyObject
};

extern NSString *const SerialisationErrorDomain;

@protocol Serializing <NSObject>

- (void)serializeToString:(NSMutableString *)string error:(NSError *__autoreleasing *)error;

@end