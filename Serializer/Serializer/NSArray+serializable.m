//
//  NSArray+serializable.m
//  Serializer
//
//  Created by Admin on 23/07/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import "NSArray+serializable.h"
#import "Serializer.h"

@implementation NSArray(serializable)
-(NSMutableString*)serializeWithError:(NSError* __autoreleasing *)error{
    NSMutableString *res = [[NSMutableString alloc]init];
    NSMutableString *append = [[NSMutableString alloc]init];
    for(id obj in self){
        if([obj respondsToSelector:@selector(serializeWithError:)]){
            if((append = [obj serializeWithError:error]) == nil){
                return nil;
            }
            NSRange range = NSMakeRange(-1, 0);
            int location = 0;
            while (range.location != NSNotFound){
                NSString *insert = [NSString stringWithFormat:@"NSArray[%d]/",[self indexOfObject:obj]];
                [append insertString:insert atIndex:location+range.location+1];
                location += range.location+[insert length];
                range = [[append substringFromIndex:location] rangeOfString:@"\n"];
            };
            [res appendString:append];
            [res appendString:@"\n"];
        } else {
            if (!!error) {
                NSDictionary* userInfo = [NSDictionary dictionaryWithObject:[obj class] forKey:@"WrongObject"];
                (*error) = [NSError errorWithDomain:@"serializerErrorDomain"
                                               code:serializeErrorObjectIsNotSerializable
                                           userInfo:userInfo];
            }
            return nil;
        }
    }
    res = [[res substringToIndex:[res length] - 1] mutableCopy];
    return res;
}
@end
