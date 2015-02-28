#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "Serializator.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        // Dictinary
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        for (int i = 0 ; i <= 9 ; i++)
        {
            NSMutableSet *set = [[NSMutableSet alloc] init];
            for (int j = 0 ; j < 10 ; j++)
            {
                NSNumber *number = [NSNumber numberWithInt:j];
                
                [set addObject:number];
            }
            dict[[NSNumber numberWithInt:i]] = set;
        }
        
        Serializator *serializator = [[Serializator alloc] init];
        NSError *error;
        
        NSString *string = [serializator serializeByDictinary:dict error:&error];
        
        NSLog(@"%@",string);
        
    }
}
