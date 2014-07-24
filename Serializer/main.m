//
//  main.m
//  Serializer
//
//  Created by Admin on 23/07/14.
//  Copyright (c) 2014 Horns and hooves. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char * argv[])
{
   /* @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }*/

	id a = [NSNumber numberWithInt:'a'];

	NSLog(@"%@", [NSValue valueWithCGRect:CGRectMake(0,0,0,0)]);

	return 0;
}
