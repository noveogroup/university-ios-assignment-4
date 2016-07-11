
#import "Serialisation.h"

NSString *const SerialisationErrorDomain = @"SerialisationErrorDomain";

@implementation Serialisation

+ (void)removeLastCommaAndSpaceInString:(NSMutableString *)string
{
    if ([[string substringFromIndex:[string length]-2] isEqualToString:@", "]) {
        [string deleteCharactersInRange:NSMakeRange([string length]-2, 2)];
    }
}

+ (void)appendDictionary:(NSDictionary *)dict toString:(NSMutableString *)string error:(NSError **)error
{
    [string appendString:@"{ "];
    
    for (id key in dict) {
        
        if ([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]]) {
            
            [string appendString:[NSString stringWithFormat:@"%@: ", key]];
            [self appendObject:dict[key] toString:string error:error];
            
            if (*error) {
                return;
            }
            
            [string appendString:@", "];
            
        } else {
            
            *error = [[NSError alloc] initWithDomain:SerialisationErrorDomain code:SerialisationErrorInvalidKeyObject userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Key object of dictionary is not a NSString or NSNumber", nil)}];
            return;
        }
    }
    
    [self removeLastCommaAndSpaceInString:string];
    [string appendString:@" }"];
}

+ (void)appendArray:(NSArray *)array toString:(NSMutableString *)string error:(NSError **)error
{
    [string appendString:@"[ "];
    
    for (id elem in array) {
        
        [self appendObject:elem toString:string error:error];
        
        if (*error) {
            return;
        }
        
        [string appendString:@", "];
    }
    
    [self removeLastCommaAndSpaceInString:string];
    [string appendString:@" ]"];
}

+ (void)appendSet:(NSSet *)set toString:(NSMutableString *)string error:(NSError **)error
{
    [string appendString:@"Set{ "];
    
    for (id elem in set) {
        
        [self appendObject:elem toString:string error:error];
        
        if (*error) {
            return;
        }
        
        [string appendString:@", "];
    }
    
    [self removeLastCommaAndSpaceInString:string];
    [string appendString:@" }"];
}

+ (void)appendObject:(id)object toString:(NSMutableString *)string error:(NSError **)error
{
    if (*error) {
        return;
    }
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        
        [self appendDictionary:object toString:string error:error];
    }
    else if ([object isKindOfClass:[NSArray class]]) {
        
        [self appendArray:object toString:string error:error];
    }
    else if ([object isKindOfClass:[NSSet class]]) {
        
        [self appendSet:object toString:string error:error];
    }
    else if ([object isKindOfClass:[NSNumber class]]) {
        
        [string appendString:[NSString stringWithFormat:@"%@", object]];
    }
    else if ([object isKindOfClass:[NSNull class]]) {
        
        [string appendString:[NSString stringWithFormat:@"(null)"]];
    }
    else if ([object isKindOfClass:[NSValue class]]) {
        
        CGRect rect;
        [(NSValue *)object getValue:&rect];
        [string appendString:[NSString stringWithFormat:@"CGRect(%g, %g, %g, %g)", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height]];
    }
    else {
        
        NSString *description = [NSString stringWithFormat:@"Found object of class %@, which is not a NSDictionary, NSArray, NSSet, NSNumber, NSNull or CGRect", [object class]];
        *error = [[NSError alloc] initWithDomain:SerialisationErrorDomain code:SerialisationErrorInvalidValueObject userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(description, nil)}];
        return;
    }
}

+ (NSString *)stringFromDictionary:(id)dict error:(NSError **)error
{
    if (*error) {
        return nil;
    }
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
        
        NSMutableString *string = [[NSMutableString alloc] init];
        
        [self appendObject:dict toString:string error:error];
        
        if (*error) {
            return nil;
        }
    
        return [NSString stringWithString:string];
        
    } else {
        
        *error = [[NSError alloc] initWithDomain:SerialisationErrorDomain code:SerialisationErrorNonDictionaryRootObject userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Root object is not a NSDictionary object", nil)}];
    }
    
    return nil;
}

@end












