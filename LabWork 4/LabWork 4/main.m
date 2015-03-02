
#import "NSArray+Serializable.h"
#import "NSDictionary+Serializable.h"
#import "NSSet+Serializable.h"
#import "NSValue+Serializable.h"
#import "NSNull+Serializable.h"
#import "NSValue+Serializable.h"
#import "Serializer.h"
#import <CoreGraphics/CoreGraphics.h>



int main(int argc, char * argv[]) {
    @autoreleasepool
    {
        NSError *__autoreleasing error = nil;
        CGRect rect = CGRectMake(4.5, 1.2, 6.7, 4.3);
        NSValue *somevalue = [NSValue value:&rect withObjCType:@encode(CGRect)];
        NSArray *array1 = @[@345, @34, @45, @1];
        NSArray *array2 = @[@12, @23, array1, somevalue];
        
        NSDictionary *dictionary1 = @{@"Number1": @23, @"Number2": @123, @"Array": array2};
        
        //Dictionary with unsupported object
        NSDictionary *dictionary2 = @{@"Number2": @23, @"Array": array2, @"String": @"Somestring"};
        
        NSString *result = [Serializer serialize:dictionary1 WithError:&error];
        NSLog(@"Serialize: %@", result);
        
        NSString *resultWithError = [Serializer serialize:dictionary2 WithError:&error];
        if(resultWithError == nil)
        {
            NSLog(@"Error: %@", error);
        }
        
        
        
        
        return 0;
    }
}
