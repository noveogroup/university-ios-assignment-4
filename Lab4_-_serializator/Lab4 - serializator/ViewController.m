#import "ViewController.h"
#import "Serialisator.h"
#import "NSDictionary+Serialisator.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect rect = CGRectMake(0, 0, 50, 50);
//    CGPoint rect1 = CGPointMake(10, 10);

    NSError *error;
    NSDictionary *dictionary = @{@"stroka": @"bukva a",
            @"object": @{@1: @"odin", @2: @"dva"},
            @"cifra": @15,
//            @"Null": [NSNull null],
            @"massiv": @[@"a", @"b", @"c", @"d", @[@"aa", @"bb"]],
            @"set": [NSSet setWithArray:@[@"s1", @"s2", @"s3", @"s4", @"s5"]],
            @"cgrect": [NSValue value:&rect withObjCType:@encode(CGRect)],
//            @"cgrect1": [NSValue value:&rect1 withObjCType:@encode(CGPoint)]
    };

    NSString *string = [Serialisator serialise:dictionary error:&error];
    if(error){
        NSLog(@"%@", error);
    } else {
        NSLog(@"%@", string);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
