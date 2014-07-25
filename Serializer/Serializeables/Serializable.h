#import <Foundation/Foundation.h>

@protocol Serializable <NSObject>
- (NSString *)serializeWithError:(NSError **)error;
@end