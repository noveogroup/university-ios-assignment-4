#import <Foundation/Foundation.h>

@protocol Serializable <NSObject>
@required 
- (NSString *)serializeWithError:(NSError **)error;
@end