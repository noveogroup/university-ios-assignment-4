//
//  NSSET+serializable.m
//  Serializer
//
//  Created by Admin on 23/07/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import "NSSet+serializable.h"

@implementation NSSet(serializable)
-(NSMutableString*)serializeWithError:(NSError* __autoreleasing *)error{
    NSMutableString *res = [[NSMutableString alloc]init];
    NSMutableString *append = [[NSMutableString alloc]init];
    for(id obj in self){
        if([obj respondsToSelector:@selector(serializeWithError:)]){
            if((append = [obj serializeWithError:error]) == nil){
                //error
                return nil;
            }
            [res appendFormat:append,@"\n"];
        } else {
            //error
            return nil;
        }
    }
    res = [[res substringToIndex:[res length] - 1] mutableCopy];
    NSRange range = NSMakeRange(0, 0);
    do{
        [res insertString:[NSString stringWithFormat:@"%@/",[NSSet description]] atIndex:range.location];
        range = [res rangeOfString:@"\n"];
    }while (range.location != NSNotFound);
    return res;
}
@end
