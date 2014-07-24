#import <Foundation/Foundation.h>

@protocol Serializeable <NSObject>
- (NSString *)serialize;
@end