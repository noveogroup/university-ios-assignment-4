#include <CoreGraphics/CGGeometry.h>
#import <UIKit/UIKit.h>
#import "Serializator.h"
#import "SerializationError.h"
#import "Serializable.h"

@implementation Serializator

+(NSString*) serializeByDictinary:(id)dictinary error:(NSError *__autoreleasing *)error
{
    NSString *resultStr;
    
    if (![dictinary isKindOfClass:[NSDictionary class]])
    {
        NSStringFromClass(dictinary);
        
        *error = [SerializationError getErrorWrongInputParametersWithClass:[dictinary class]];
    }
    else
    {
        resultStr = [((id<Serializable>) dictinary) serializeWithError:error];
        if (*error != nil)
            return nil;
    }
    
    return resultStr;
}

@end

@implementation NSDictionary (Serializable)

-(NSString*) serializeWithError:(NSError *__autoreleasing *) error
{
    NSMutableString *resultStr = [@"\n{Dict" mutableCopy];
    
    // Empty check
    if ([self count] == 0)
        return [resultStr stringByAppendingString:@" - empty}"];
    
    // Go by Dict
    for (id key in self)
    {
        if ([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]])
        {
            if ([self[key] respondsToSelector:@selector(serializeWithError:)])
            {
                [resultStr appendString:[self[key] serializeWithError:error]];
                [resultStr appendString:@" ; "];
            }
            else
            {
                *error = [SerializationError getErrorNotSupportedObjectWithClass:[self[key] class]];
                return @"";
            }
        }
        else
        {
            *error = [SerializationError getErrorNotSupportedKeyWithClass:[key class]];
            return @"";
        }
    }
    
    return [resultStr stringByAppendingString:@"}"];
}

@end

@implementation NSArray (Serializable)

-(NSString*) serializeWithError:(NSError *__autoreleasing *) error
{
    NSMutableString* resultStr = [@"\n{NSArray " mutableCopy];
    
    // Empty check
    if ([self count] == 0)
        return [resultStr stringByAppendingString:@" - empty}\n"];
    
    // Go By Array
    for (id element in self)
    {
        if ([element respondsToSelector:@selector(serializeWithError:)])
        {
            [resultStr appendString:[element serializeWithError:error]];
            [resultStr appendString:@" ; "];
        }
        else
        {
            *error = [SerializationError getErrorNotSupportedObjectWithClass:element];
            return @"";
        }
    }
    
    return [resultStr stringByAppendingString:@"}"];
}

@end

@implementation NSSet (Serializable)

-(NSString*) serializeWithError:(NSError *__autoreleasing *) error
{
    NSMutableString *resultStr = [@"\n{NSSet" mutableCopy];
    
    // Empty check
    if ([self count] == 0)
        return [resultStr stringByAppendingString:@" - empty}\n"];
    
    // Go By Set
    for (id element in self)
    {
        if ([element respondsToSelector:@selector(serializeWithError:)])
        {
            [resultStr appendString:[element serializeWithError:error]];
            [resultStr appendString:@" ; "];
        }
        else
        {
            *error = [SerializationError getErrorNotSupportedObjectWithClass:element];
            return @"";
        }
    }
    
    return [resultStr stringByAppendingString:@"}"];
}

@end

@implementation NSValue (Serializable)

-(NSString*) serializeWithError:(NSError *__autoreleasing *) error
{
    if (strcmp(@encode(CGRect),[self objCType]))
    {
        CGRect rect;
        [self getValue:&rect];
        
        return NSStringFromCGRect(rect);
    }
    else
    {
        *error = [SerializationError getErrorNotSupportedObjectWithClass:[self class]];
    }
    
    return @"";
}

@end

@implementation NSNumber (Serializable)

-(NSString*) serializeWithError:(NSError *__autoreleasing *) error
{
    return [self stringValue];
}

@end


@implementation NSString (Serializable)

-(NSString*) serializeWithError:(NSError *__autoreleasing *) error
{
    return [self copy];
}

@end


@implementation NSNull (Serializable)

-(NSString*) serializeWithError:(NSError *__autoreleasing *) error
{
    return @"";
}

@end




