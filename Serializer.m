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
    
    NSMutableString *reading = [[NSMutableString alloc] initWithString:@"strart to reading dictionary \n"];
    for (id key in dictionary)
    {
        [reading appendString:[Serializer switching:[dictionary objectForKey:key]]];
    }
    
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
    NSMutableString *reading = [[NSMutableString alloc] initWithString:@"\n this item is a dictionary \n"];
    for (id key in dictionary)
    {
        [reading appendString:[Serializer switching:[dictionary objectForKey:key]]];
    }
    
    return reading;

}

+(NSString*)serializeSet:(NSSet*) set
{
    NSMutableString *reading = [[NSMutableString alloc] initWithString:@"\n this item is a set \n"];
    for (id item in set)
    {
        [reading appendString:[Serializer switching:item]];
    }
    
    return reading;
}

+(NSString*)serializeArray:(NSArray*) array
{
    NSMutableString *reading = [[NSMutableString alloc] initWithString:@"\n this item is an array \n"];
    for (id item in array)
    {
        [reading appendString:[Serializer switching:item]];
    }
    
    return reading;
}

+(NSString*)serializeNull:(NSNull*) nullValue
{
    return @" null";
}

+(NSString*)serializeNumber:(NSNumber*) number
{
    NSMutableString *reading = [[NSMutableString alloc] initWithString:@" "];
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendFormat: @"%s", [number objCType]];
    if([str  isEqual: @"c"])
    {
        if([[number stringValue]  isEqual: @"1"])
        {
            [reading appendFormat: @"%@", @"YES"];
            return reading;
        }
        else if ([[number stringValue]  isEqual: @"0"])
        {
            [reading appendFormat: @"%@", @"NO"];
            return reading;
        }
        [reading appendFormat: @"%c", [number charValue]];
        return reading;
    }
    
    [reading appendFormat: @"%@", [number stringValue]];
    return reading;
}

+(NSString*)serializeNSValue:(NSValue*) value
{
    NSMutableString *reading = [[NSMutableString alloc] initWithString:@"\n This is a CGRect \n"];
    CGRect rect;
    [value getValue:&rect];
    [reading appendFormat: @"%s", " X "];
    [reading appendFormat: @"%f", rect.origin.x];
    [reading appendFormat: @"%s", " Y "];
    [reading appendFormat: @"%f", rect.origin.y];
    [reading appendFormat: @"%s", " height "];
    [reading appendFormat: @"%f", rect.size.height];
    [reading appendFormat: @"%s", " width "];
    [reading appendFormat: @"%f", rect.size.width];
    return reading;
}
@end
