#import <Foundation/Foundation.h>

@interface Serializer : NSObject

+ (NSString *)serializeDictionary:(id)dictionary error:(NSError **)error;

@end
