
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SerialisationErrorCode) {
    SerialisationErrorNonDictionaryRootObject,
    SerialisationErrorInvalidValueObject,
    SerialisationErrorInvalidKeyObject
};

@interface Serialisation : NSObject

+ (NSString *)stringFromDictionary:(id)dict error:(NSError **)error;

@end
