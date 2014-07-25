#import <Foundation/Foundation.h>
#import "Serializable.h"


@interface Serializer : NSObject
+ (NSString *)serialize:(id<Serializable>)object withError:(NSError **)error;
@end