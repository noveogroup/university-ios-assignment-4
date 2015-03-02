

#import <Foundation/Foundation.h>

@interface Serializer : NSObject

+ (NSString *)serialize:(id)dictionary WithError:(NSError *__autoreleasing *)error;

@end
