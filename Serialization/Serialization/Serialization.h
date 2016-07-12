
#import <Foundation/Foundation.h>
#import "Serializing.h"

@interface Serialization : NSObject

+ (NSString *)stringFromDictionary:(id)dict error:(NSError **)error;

@end
