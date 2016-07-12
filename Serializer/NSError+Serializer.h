//
//  NSError+Serializer.h
//  Serializer
//

#import <Foundation/Foundation.h>

@interface NSError (Serializer)

+ (NSError *)errorWithKey:(id)key;
+ (NSError *)errorWithObject:(id)object;
+ (NSError *)errorWithValue:(NSValue *)val;

@end
