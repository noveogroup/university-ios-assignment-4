#import <Foundation/Foundation.h>

@interface Serializer : NSObject
- (NSString *)serialize:(id)object WithError:(NSError **)error;
@end