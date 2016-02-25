
#import <Foundation/Foundation.h>

@interface Serializer : NSObject

typedef NS_ENUM(NSInteger, SerializerOptions) {
    SerializerWithClassNames = 1,
    SerializerWithoutClassNames = 0,
};


+ (NSString*) getStringFromData:(id)data withOptions:(SerializerOptions) options withError:(NSError *__autoreleasing*) error;
//- (instancetype) init NS_UNAVAILABLE;

@end
