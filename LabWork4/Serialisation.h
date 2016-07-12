
#import <Foundation/Foundation.h>
#import "Serializing.h"

@interface Serialisation : NSObject

+ (NSString *)stringFromDictionary:(id)dict error:(NSError **)error;

@end
