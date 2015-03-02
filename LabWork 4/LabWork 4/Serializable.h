


#import <Foundation/Foundation.h>

@protocol Serializable <NSObject>

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error;

@end

