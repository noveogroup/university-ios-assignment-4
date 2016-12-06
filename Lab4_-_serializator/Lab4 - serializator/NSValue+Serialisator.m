#import "NSValue+Serialisator.h"
#import "ViewController.h"

@implementation NSValue (Serialisator)

- (NSString *)serialiseWithErrorLink:(NSError *__autoreleasing *)error
{
    if(!strcmp([self objCType], @encode(CGRect))){
        CGRect rect = [self CGRectValue];
        return [NSString stringWithFormat:@"CGRect: (%.2f; %.2f) %.2fx%.2f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
    } else {

        NSDictionary *userinfo = @{ NSLocalizedDescriptionKey: @"It is not CGRect"};
                *error = [NSError errorWithDomain:SerialisableErrorDomain code:SERIALISE_ERROR_INCORRECT_TYPE userInfo:userinfo];
        return nil;
    }
}

@end
