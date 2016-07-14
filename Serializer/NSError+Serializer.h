//
//  NSError+Serializer.h
//  Serializer
//

#import <Foundation/Foundation.h>

extern NSString *const kSerializerErrorDomain;

typedef NS_ENUM(NSInteger, SerializerErrorCode)
{
    SerializerErrorCodeWrongObject = 0,
    SerializerErrorCodeWrongKey = 1,
    SerializerErrorCodeWrongValue = 2,
};


@interface NSError (Serializer)

+ (NSError *)errorWithKey:(id)key;
+ (NSError *)errorWithObject:(id)object;
+ (NSError *)errorWithValue:(NSValue *)val;

@end
