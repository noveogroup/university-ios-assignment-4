
#import <Foundation/Foundation.h>

@interface Serializer : NSObject

typedef BOOL SerializerOptions;
NS_ENUM(NSStringEncoding) {
    SerializerWithClassNames = YES,
    SerializerWithoutClassNames = NO,
};


+ (NSString*) getStringFromData:(id)data withOptions:(SerializerOptions) options withError:(NSError *__autoreleasing*) error;
//- (instancetype) init NS_UNAVAILABLE;

@end
