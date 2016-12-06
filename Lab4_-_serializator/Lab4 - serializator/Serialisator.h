#import <Foundation/Foundation.h>


@interface Serialisator : NSObject

+ (NSString *)serialise:(id)dict error:(NSError **)error;

@end