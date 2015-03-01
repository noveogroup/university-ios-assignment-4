#import <Foundation/Foundation.h>

@interface Serializer : NSObject

+ (NSString *)serializeDictionary:(id)dictionary error:(NSError **)error;
+ (NSString *)serializeDictionary:(id)dictionary
                        byOneLine:(BOOL)isOneLined
                            error:(NSError *__autoreleasing *)error;

@end
