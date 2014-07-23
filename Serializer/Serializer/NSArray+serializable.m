//
//  NSArray+serializable.m
//  Serializer
//
//  Created by Admin on 23/07/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import "NSArray+serializable.h"

@implementation NSArray(serializable)
-(NSMutableString*)serializeWithError:(NSError* __autoreleasing *)error{
    NSMutableString *res = [[NSMutableString alloc]init];
    NSMutableString *append = [[NSMutableString alloc]init];
    for(id obj in self){
        if([obj respondsToSelector:@selector(serializeWithError:)]){
            if((append = [obj serializeWithError:error]) == nil){
                //error
                return nil;
            }
            NSRange range = NSMakeRange(0, 0);
            do{
                [append insertString:[NSString stringWithFormat:@"%d/",[self indexOfObject:obj]] atIndex:range.location];
                range = [append rangeOfString:@"\n"];
            }while (range.location != NSNotFound);
            [res appendFormat:append,@"\n"];
        } else {
            //error
            return nil;
        }
    }
    res = [[res substringToIndex:[res length] - 1] mutableCopy];
    return res;
}
@end
