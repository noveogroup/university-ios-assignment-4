#import <Foundation/Foundation.h>

@protocol Serializeable <NSObject>
- (NSString *)serializeWithError:(NSError **)error;
@end