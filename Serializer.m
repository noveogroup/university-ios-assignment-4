//
//  Serializer.m
//  4lab
//
//  Created by Сонечка on 26.07.14.
//  Copyright (c) 2014 Сонечка. All rights reserved.
//

#import "Serializer.h"

@implementation Serializer
+(NSString*)serialize: dictionary
{
    if(![dictionary isKindOfClass:[NSDictionary class]])
        return NO; //TODO: error
    
    NSMutableString *reading = [[NSMutableString alloc] initWithString:@"\n"];
    [reading appendString: [Serializer switching:dictionary]];
    
   

    return reading;
}

+(NSString*)switching:(NSObject*)object
{
    NSMutableString *reading = [[NSMutableString alloc] initWithString:@" "];
    
    if([object isKindOfClass:[NSDictionary class]])
    {
        [reading appendString:[Serializer serializeDictionary:(NSDictionary*)object]];
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        [reading appendString:[Serializer serializeNull:(NSNull*)object]];
    }
    else if([object isKindOfClass:[NSNumber class]])
    {
        [reading appendString:[Serializer serializeNumber:(NSNumber*)object]];
    }
    else if([object isKindOfClass:[NSArray class]])
    {
        [reading appendString:[Serializer serializeArray:(NSArray*)object]];
    }
    else if([object isKindOfClass:[NSSet class]])
    {
        [reading appendString:[Serializer serializeSet:(NSSet*)object]];
    }
    else if([object isKindOfClass:[NSValue class]])
    {
        [reading appendString:[Serializer serializeNSValue:(NSValue*)object]];
    }
    
    return reading;
}

+(NSString*)serializeDictionary:(NSDictionary*) dictionary
{
    NSMutableString *reading = [[NSMutableString alloc] initWithString:@"\n{"];
    for (id key in dictionary)
    {
        [reading appendString:@"\n    \""];
        [reading appendString:key];
        [reading appendString:@"\":"];
        [reading appendString:[Serializer switching:[dictionary objectForKey:key]]];
    }
    
    NSRange range;
    range.location = reading.length - 2;
    range.length = 1;
    [reading deleteCharactersInRange:range];
    [reading appendString:@"\n}"];
    return reading;

}

+(NSString*)serializeSet:(NSSet*) set
{
    NSMutableString *reading = [[NSMutableString alloc] initWithString:@"["];
    for (id item in set)
    {
        [reading appendString:@"\n"];
        [reading appendString:[Serializer switching:item]];
        [reading appendString:@", "];
    }
    NSRange range;
    range.location = reading.length - 2;
    range.length = 1;
    [reading deleteCharactersInRange:range];
    
    [reading appendString:@"]"];
    return reading;
}

+(NSString*)serializeArray:(NSArray*) array
{
    NSMutableString *reading = [[NSMutableString alloc] initWithString:@"["];
    for (id item in array)
    {
        [reading appendString:@"\n"];
        [reading appendString:[Serializer switching:item]];
        [reading appendString:@", "];
    }
    
    NSRange range;
    range.location = reading.length - 3;
    range.length = 2;
    [reading deleteCharactersInRange:range];

    [reading appendString:@"]"];
    return reading;
}

+(NSString*)serializeNull:(NSNull*) nullValue
{
    return @"null";
}

+(NSString*)serializeNumber:(NSNumber*) number
{
    NSMutableString *reading = [[NSMutableString alloc] initWithString:@""];
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendFormat: @"%s", [number objCType]];
    if([str  isEqual: @"c"])
    {
        if([[number stringValue]  isEqual: @"1"])
        {
            [reading appendString:@"\""];
            [reading appendFormat: @"%@", @"YES"];
            [reading appendString:@"\""];
            return reading;
        }
        else if ([[number stringValue]  isEqual: @"0"])
        {
            [reading appendString:@"\""];
            [reading appendFormat: @"%@", @"NO"];
            [reading appendString:@"\""];
            return reading;
        }
        [reading appendString:@"\""];
        [reading appendFormat: @"%c", [number charValue]];
        [reading appendString:@"\""];
        return reading;
    }
    
    [reading appendFormat: @"%@", [number stringValue]];
    return reading;
}

+(NSString*)serializeNSValue:(NSValue*) value
{
    NSMutableString *reading = [[NSMutableString alloc] initWithString:@"\n{\n"];
    CGRect rect;
    [value getValue:&rect];
    
    [reading appendString: @"\"origin.x\": \""];
    [reading appendFormat: @"%f", rect.origin.x];
    [reading appendString: @"\"\n"];
    
    [reading appendString: @"\"origin.y\": \""];
    [reading appendFormat: @"%f", rect.origin.y];
    [reading appendString: @"\"\n"];
    
    [reading appendString: @"\"size.height\": \""];
    [reading appendFormat: @"%f", rect.size.height];
    [reading appendString: @"\"\n"];
    
    [reading appendString: @"\"size.width\": \""];
    [reading appendFormat: @"%f", rect.size.width];
    [reading appendString: @"\"\n}"];
    return reading;
}
@end
