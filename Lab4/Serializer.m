
#import "Serializer.h"

#import <UIKit/UIKit.h>

@interface Serializer ()

@property (assign, nonatomic) SerializerOptions options;

@end

@implementation Serializer

+ (NSString*) getStringFromData:(id)data withOptions:(SerializerOptions)options withError:(NSError**) error{
    Serializer* serializer = [[Serializer alloc] init];
    serializer.options = options;
    
    if (![data isKindOfClass:[NSDictionary class]]) {
        //Error: data isnt kind of NSDictionary class
        NSDictionary* userinfo = [[NSDictionary alloc] initWithObjectsAndKeys:[data class], @"input object class", nil];
        (*error) = [NSError errorWithDomain:@"переданный объект не является словарем" code:1 userInfo:userinfo];
        return nil;
    } else {
        //data is kind of NSDictionary class
        NSMutableString* string = [serializer getStringFromDictionary:data withLevel:0 error:error];
        return [string copy];
    }
    
    return nil;
}



- (NSMutableString*) getStringForUnknownValue:(id) value withLevel:(NSInteger) level error:(NSError**) error{
    
    if ([value isKindOfClass:[NSArray class]]) {
        return [self getStringFromArray:value withLevel:level error:error];
    } else if ([value isKindOfClass:[NSDictionary class]]){
        return [self getStringFromDictionary:value withLevel:level error:error];
    } else if ([value isKindOfClass:[NSSet class]]){
        return [self getStringFromSet:value withLevel:level error:error];
    } else if ([value isKindOfClass:[NSNumber class]]){
        return [self getStringFromNumber:value];
    } else if ([value isKindOfClass:[NSValue class]]){
        return [self getStringFromValue:value withLevel:level];
    } else if ([value isKindOfClass:[NSNull class]]){
        return [@"null" mutableCopy];
    } else {
        NSDictionary* userinfo = [[NSDictionary alloc] initWithObjectsAndKeys:[value class], @"bad object class", nil];
        *error = [NSError errorWithDomain:@"переданный словарь содержит объект недопустимого типа"
                                         code:2
                                     userInfo:userinfo];
        return nil;
    }
}



- (NSMutableString*) getStringFromArray:(NSArray*) array withLevel:(NSInteger) level error:(NSError**) error{
    NSMutableString* string = [NSMutableString string];
    
    if (self.options) {
        [string appendFormat:@"\n%@[  (array)  \n", [self getVoidStringWithLevel:level]];
    } else {
        [string appendFormat:@"\n%@[\n", [self getVoidStringWithLevel:level]];
    }
    
    for (id object in array) {
        
        ////exception
        if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]] || [object isKindOfClass:[NSSet class]]) { // I realy don't know a better way to do it
            NSInteger length = [string length];
            [string deleteCharactersInRange:NSMakeRange(length - 1, 1)];//delete /n
        }
        ////
        
        [string appendString:[self getVoidStringWithLevel:(level + 1)]];
        
        NSMutableString* valueString = [self getStringForUnknownValue:object withLevel:(level + 1) error:error];
        if (*error) {
            return nil;
        }
        
        [string appendFormat:@"%@,\n", valueString];
    }
    
    [string appendFormat:@"%@]", [self getVoidStringWithLevel:level]];
    
    return string;
}

- (NSMutableString*) getStringFromDictionary:(NSDictionary*) dictionary withLevel:(NSInteger) level error:(NSError**) error{
    NSMutableString* string = [NSMutableString string];
    
    if (self.options) {
        [string appendFormat:@"\n%@[  (dictionary)  \n", [self getVoidStringWithLevel:level]];
    } else {
        [string appendFormat:@"\n%@[\n", [self getVoidStringWithLevel:level]];
    }
    
    NSArray* keys = [dictionary allKeys];
    for (id key in keys) {
        if ([key isKindOfClass:[NSString class]]) {
            
            [string appendString:[self getVoidStringWithLevel:(level + 1)]];
            
            NSMutableString* valueString = [self getStringForUnknownValue:dictionary[key] withLevel:(level + 1) error:error];
            if (*error) {
                return nil;
            }
            
            [string appendFormat:@"%@ : %@,\n", key, valueString];
            
        } else if ([key isKindOfClass:[NSNumber class]]){
            
            [string appendString:[self getVoidStringWithLevel:(level + 1)]];
            
            NSMutableString* valueString = [self getStringForUnknownValue:dictionary[key] withLevel:(level + 1) error:error];
            if (*error) {
                return nil;
            }
            
            [string appendFormat:@"%0.2f : %@,\n", [key floatValue], valueString];
            
        } else {
            NSDictionary* userinfo = [[NSDictionary alloc] initWithObjectsAndKeys:[key class], @"bad key class", nil];
            *error = [NSError errorWithDomain:@"один из ключей является объектом недопустимого типа"
                                             code:2
                                         userInfo:userinfo];
            return nil;
        }
    }
    
    [string appendFormat:@"%@}", [self getVoidStringWithLevel:level]];

    return string;
}

- (NSMutableString*) getStringFromSet:(NSSet*) set withLevel:(NSInteger) level error:(NSError**) error{
    NSMutableString* string = [NSMutableString string];
    
    if (self.options) {
        [string appendFormat:@"\n%@[  (set)  \n", [self getVoidStringWithLevel:level]];
    } else {
        [string appendFormat:@"\n%@[\n", [self getVoidStringWithLevel:level]];
    }
    
    for (id object in set) {
        
        ////exception
        if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]] || [object isKindOfClass:[NSSet class]]) { // I realy don't know a better way to do it
            NSInteger length = [string length];
            [string deleteCharactersInRange:NSMakeRange(length - 2, 2)];
        }
        ////
        
        [string appendString:[self getVoidStringWithLevel:(level + 1)]];
        
        NSMutableString* valueString = [self getStringForUnknownValue:object withLevel:(level + 1) error:error];
        if (*error) {
            return nil;
        }
        
        [string appendFormat:@"%@,\n", valueString];
    }
    
    [string appendFormat:@"%@]", [self getVoidStringWithLevel:level]];
    
    return string;
}

- (NSMutableString*) getStringFromNumber:(NSNumber*) number{
    NSMutableString* string;
    
    float value = [number floatValue];
    if (value - (int)value != 0) { // if value is realy float value
        string = [NSMutableString stringWithFormat:@"%0.2f", value];
    } else {
        string = [NSMutableString stringWithFormat:@"%0.0f", value];
    }
    return string;
}

- (NSMutableString*) getStringFromValue:(NSValue*) value withLevel:(NSInteger) level{ //for CGRect serializing
    CGRect rect = [value CGRectValue];
    
    NSMutableString* string = [NSMutableString string];
    
    if (self.options) {
        [string appendFormat:@"\n%@[  (CGRect)  \n", [self getVoidStringWithLevel:level]];
    } else {
        [string appendFormat:@"\n%@[\n", [self getVoidStringWithLevel:level]];
    }
    
    [string appendString:[self getVoidStringWithLevel:(level + 1)]];
    [string appendFormat:@"x = %0.2f,\n", rect.origin.x];
    
    [string appendString:[self getVoidStringWithLevel:(level + 1)]];
    [string appendFormat:@"y = %0.2f,\n", rect.origin.y];

    [string appendString:[self getVoidStringWithLevel:(level + 1)]];
    [string appendFormat:@"width = %0.2f,\n", rect.size.width];
    
    [string appendString:[self getVoidStringWithLevel:(level + 1)]];
    [string appendFormat:@"height = %0.2f,\n", rect.size.height];
    
    [string appendFormat:@"%@]", [self getVoidStringWithLevel:level]];
    
    return string;
}

- (NSMutableString*) getVoidStringWithLevel:(NSInteger) level{
    NSMutableString* string = [NSMutableString string];
    for (int i = 0; i < level; i++) {
        [string appendString:@"   "];
    }
    return string;
}


@end
