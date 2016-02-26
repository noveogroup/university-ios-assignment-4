
#import "ViewController.h"

#import "Serializer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = CGRectMake(21, 5, 48, 64);
    
    NSSet* set1 = [NSSet setWithArray:@[@(23),@(45)]];
    
    NSDictionary* dict1 = [[NSDictionary alloc] initWithObjectsAndKeys:
                           @"test value", @"key1", //value mistake
                           @(54.23f), @"key2",
                           @[@(1), @(2), set1, @(4)], @"array", nil];
    
    NSDictionary* dictWithValueMistake = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          @(234), @"key1",
                                          @(123), @"92",
                                          dict1, @"dict",
                                          [NSValue valueWithCGRect:rect], @"rect", nil];

    NSDictionary* dictWithKeyMistake = [[NSDictionary alloc] initWithObjectsAndKeys:
                                        @(234), @[@(1), @(3)], //key mistake
                                        @(123), @"92",
                                        set1, @"set",
                                        [NSValue valueWithCGRect:rect], @"rect", nil];
    
    NSDictionary* normalDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                        @(234), @(432),
                                        @(123), @"92",
                                        set1, @"set",
                                        @[@(1), @(2), set1, @(4)], @"array",
                                        [NSNull null], @"NSNull",
                                        [NSValue valueWithCGRect:rect], @"rect", nil];
    
    NSError* error = nil;
    
    //demonstration of value mistake
    NSString* string;
    
    NSLog(@"\n\n");
    string = [Serializer getStringFromData:dictWithValueMistake withOptions:SerializerWithClassNames withError:&error];
    if (!error) {
        NSLog(@"%@", string);
    } else {
        NSLog(@"error %@", error);
    }
    
    //demonstration of key mistake
    NSLog(@"\n\n");
    error = nil;
    string = [Serializer getStringFromData:dictWithKeyMistake withOptions:SerializerWithClassNames withError:&error];
    if (!error) {
        NSLog(@"%@", string);
    } else {
        NSLog(@"error %@", error);
    }
    
    //demonstration of input data format mistake
    NSLog(@"\n\n");
    error = nil;
    string = [Serializer getStringFromData:@[@(2), @(3), @(6)] withOptions:SerializerWithClassNames withError:&error];
    if (!error) {
        NSLog(@"%@", string);
    } else {
        NSLog(@"error %@", error);
    }
    
    //demonstration of normal working
    NSLog(@"\n\n");
    error = nil;
    string = [Serializer getStringFromData:normalDict withOptions:SerializerWithClassNames withError:&error];
    if (!error) {
        NSLog(@"%@", string);
    } else {
        NSLog(@"error %@", error);
    }
    
    
    
    //// final working test
    NSMutableArray* topArray = [@[@(1)] mutableCopy];
    for (int i = 0; i < 10; i++) {
        NSMutableArray* newArray = [@[@(i), topArray, @(i)] mutableCopy];
        topArray = newArray;
    }
    NSDictionary* finalDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:topArray, @"arrays", nil];
    
    NSLog(@"\n\n\n\n FINAL DEMONSTRATION \n");
    error = nil;
    string = [Serializer getStringFromData:finalDictionary withOptions:SerializerWithoutClassNames withError:&error];
    if (!error) {
        NSLog(@"%@", string);
    } else {
        NSLog(@"error %@", error);
    }
}



@end
