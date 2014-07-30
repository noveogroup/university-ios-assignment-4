//
//  Serializer.m
//  4lab
//
//  Created by Сонечка on 26.07.14.
//  Copyright (c) 2014 Сонечка. All rights reserved.
//

#import "Serializer.h"

@implementation Serializer
+(NSString*)serialize:(id)dictionary error:(NSError **)error;
{
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: NSLocalizedString(@"Serialization was unsuccessful.", nil),
                               NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"Wrong input data", nil),
                               NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Set an another type of an object", nil)
                               };
    
    if(![dictionary isKindOfClass:[NSDictionary class]])
    {
        *error = [NSError errorWithDomain:@"wrong input type" code:5 userInfo: userInfo];
        return nil;
    }
    
    NSMutableString *reading = [[NSMutableString alloc] initWithString:@"\n"];
    [reading appendString: [Serializer switching:dictionary error: error]];
    
    if(error)
    {
        return nil;
    }
    
    return reading;
}

+(NSString*)switching:(NSObject*)object error:(NSError **)error
{
    NSMutableString *reading = [[NSMutableString alloc] initWithString:@" "];
    
    if([object isKindOfClass:[NSDictionary class]])
    {
        [reading appendString:[Serializer serializeDictionary:(NSDictionary*)object error:error]];
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
        [reading appendString:[Serializer serializeArray:(NSArray*)object error:error]];
    }
    else if([object isKindOfClass:[NSSet class]])
    {
        [reading appendString:[Serializer serializeSet:(NSSet*)object error: error]];
    }
    else if([object isKindOfClass:[NSValue class]])
    {
        [reading appendString:[Serializer serializeNSValue:(NSValue*)object error:error]];
    }
    else
    {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Serialization was unsuccessful.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"Wrong input data inside of dictionary", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Set an another type of an object", nil)
                                   };
        
        *error = [NSError errorWithDomain:@"forbidden type of an object" code:5 userInfo: userInfo];
        return @"";
    }
    
    return reading;
}

+(NSString*)serializeDictionary:(NSDictionary*) dictionary error:(NSError **)error
{
    NSMutableString *reading = [[NSMutableString alloc] initWithString:@"\n{"];
    for (id key in dictionary)
    {
        if([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]])
        {
            
            [reading appendString:@"\n    \""];
            [reading appendString:key];
            [reading appendString:@"\":"];
            if(error)
            {
                [reading appendString:[Serializer switching:[dictionary objectForKey:key ] error: error]];
            }
            else
            {
                return nil;
            }
        }
        
        else
        {
            NSDictionary *userInfo = @{
                                       NSLocalizedDescriptionKey: NSLocalizedString(@"Serialization was unsuccessful.", nil),
                                       NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"Wrong input type of a key id dictionary", nil),
                                       NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Set an another type of an object", nil)
                                       };
            
            *error = [NSError errorWithDomain:@"forbidden type of a key" code:5 userInfo: userInfo];
            return @"";
        }
    }
    
    NSRange range;
    range.location = reading.length - 2;
    range.length = 1;
    [reading deleteCharactersInRange:range];
    [reading appendString:@"\n}"];
    return reading;

}

+(NSString*)serializeSet:(NSSet*) set error:(NSError **)error
{
    NSMutableString *reading = [[NSMutableString alloc] initWithString:@"["];
    for (id item in set)
    {
        [reading appendString:@"\n"];
        [reading appendString:[Serializer switching:item error:error]];
        [reading appendString:@", "];
    }
    NSRange range;
    range.location = reading.length - 2;
    range.length = 1;
    [reading deleteCharactersInRange:range];
    
    [reading appendString:@"]"];
    return reading;
}

+(NSString*)serializeArray:(NSArray*) array error:(NSError **)error
{
    NSMutableString *reading = [[NSMutableString alloc] initWithString:@"["];
    for (id item in array)
    {
        [reading appendString:@"\n"];
        [reading appendString:[Serializer switching:item error: error]];
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

+(NSString*)serializeNSValue:(NSValue*) value error:(NSError **)error
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
