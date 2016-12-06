#import <Foundation/Foundation.h>

static NSString *SerialisableErrorDomain = @"SerialisableErrorDomain";

typedef NS_ENUM(NSUInteger, SerialiseErrorCode){
    SERIALISE_ERROR_NOT_DICTIONARY,
    SERIALISE_ERROR_INCORRECT_TYPE,
    SERIALISE_ERROR_INCORRECT_KEY
};

@protocol Serialisable <NSObject>

- (NSString *)serialiseWithErrorLink:(NSError *__autoreleasing *)error;

@end
