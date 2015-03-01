#include <CoreGraphics/CGGeometry.h>
#import <UIKit/UIKit.h>
#import "Serializator.h"
#import "SerializationError.h"

@interface Serializator()

-(NSString*) serializeNSDictionary:(NSDictionary*) object error:(NSError *__autoreleasing *) error;
-(NSString*) serializeNSSet:(NSSet*) object error:(NSError *__autoreleasing *) error;
-(NSString*) serializeNSArray:(NSArray*) object error:(NSError *__autoreleasing *) error;
-(NSString*) serializeNSNull:(NSNull*) object error:(NSError *__autoreleasing *) error;
-(NSString*) serializeNSValue:(NSValue*) object error:(NSError *__autoreleasing *) error;
-(NSString*) serializeNSNumber:(NSNumber*) object error:(NSError *__autoreleasing *) error;

-(NSString*) launchSerialzerByObject:(id) object error:(NSError *__autoreleasing *) error;

@end

@implementation Serializator

+(NSString*) serializeByDictinary:(id)dictinary error:(NSError *__autoreleasing *)error
{
    Serializator *serializator = [[Serializator alloc] init];
    NSString *resultStr;
    
    if (![dictinary isKindOfClass:[NSDictionary class]])
    {
        NSStringFromClass(dictinary);
        
        *error = [SerializationError getErrorWrongInputParametersWithClass:[dictinary class]];
    }
    else
    {
        resultStr = [serializator serializeNSDictionary:dictinary error:error];
        if (*error != nil)
            return nil;
    }
    
    return resultStr;
}

-(NSString*) launchSerialzerByObject:(id)object error:(NSError *__autoreleasing *)error
{
    
    if ([object isKindOfClass:[NSDictionary class]])
        return [self serializeNSDictionary:object error:error];
    
    if ([object isKindOfClass:[NSSet class]])
        return [self serializeNSSet:object error:error];
    
    if ([object isKindOfClass:[NSArray class]])
        return [self serializeNSArray:object error:error];
    
    if ([object isKindOfClass:[NSNumber class]])
        return [self serializeNSNumber:object error:error];
    
    if ([object isKindOfClass:[NSNull class]])
        return [self serializeNSNull:object error:error];
    
    if ([object isKindOfClass:[NSValue class]])
        return [self serializeNSValue:object error:error];
    
    *error = [SerializationError getErrorNotSupportedObjectWithClass:[object class]];
    
    return [@"" mutableCopy];
}

-(NSString*) serializeNSDictionary:(NSDictionary *)object error:(NSError *__autoreleasing *)error
{
    NSMutableString *resultStr = [@"\n{Dict" mutableCopy];
    
    // Empty check
    if ([object count] == 0)
        return [resultStr stringByAppendingString:@" - empty}"];
    
    // Go by Dict
    for (id key in object)
    {
        if ([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]])
        {
            [resultStr appendString:[self launchSerialzerByObject:object[key] error:error]];
            [resultStr appendString:@" ; "];
        }
        else
        {
            *error = [SerializationError getErrorNotSupportedKeyWithClass:[key class]];
            return [@"" mutableCopy];
        }
    }
    
    return [resultStr stringByAppendingString:@"}"];;
}

-(NSString*) serializeNSArray:(NSArray *)object error:(NSError *__autoreleasing *)error
{
    NSMutableString* resultStr = [@"\n{NSArray " mutableCopy];
    
    // Empty check
    if ([object count] == 0)
        return [resultStr stringByAppendingString:@" - empty}\n"];
    
    // Go By Array
    for (id element in object)
    {
        [resultStr appendString:[self launchSerialzerByObject:element error:error]];
        [resultStr appendString:@" ; "];
    }
    
    return [resultStr stringByAppendingString:@"}"];
}

-(NSString*) serializeNSSet:(NSSet *)object error:(NSError *__autoreleasing *)error
{
    NSMutableString *resultStr = [@"\n{NSSet" mutableCopy];
    
    // Empty check
    if ([object count] == 0)
        return [resultStr stringByAppendingString:@" - empty}\n"];
    
    // Go By Set
    for (id element in object)
    {
        [resultStr appendString:[self launchSerialzerByObject:element error:error]];
        [resultStr appendString:@" ; "];
    }
    
    return [resultStr stringByAppendingString:@"}"];;
}

-(NSString*) serializeNSNumber:(NSNumber *)object error:(NSError *__autoreleasing *)error
{
    return [object stringValue];
}

-(NSString*) serializeNSNull:(NSNull *)object error:(NSError *__autoreleasing *)error
{
    return @"NSNull";
}

-(NSString*) serializeNSValue:(NSValue *)object error:(NSError *__autoreleasing *)error
{
    NSString *resultStr;
    
    if (strcmp(@encode(CGRect),[object objCType]))
    {
        CGRect rect;
        [object getValue:&rect];
        
        return NSStringFromCGRect(rect);
    }
    else
    {
        *error = [SerializationError getErrorNotSupportedObjectWithClass:[object class]];
    }
    
    return resultStr;
}

@end
