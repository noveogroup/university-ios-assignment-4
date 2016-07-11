
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SerialisationErrorCode) {
    SerialisationErrorNonDictionaryRootObject,
    SerialisationErrorInvalidValueObject,
    SerialisationErrorInvalidKeyObject
};

extern NSString *const SerialisationErrorDomain;

@interface Serialisation : NSObject

+ (NSString *)stringFromDictionary:(id)dict error:(NSError **)error;

@end
