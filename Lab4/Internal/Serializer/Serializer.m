
#import "Serializer.h"

#import <UIKit/UIKit.h>

static NSString *const SerializerErrorDomain = @"SerializerErrorDomain";
static NSString *const kSerializerErrorDescription = @"SerializerErrorDescription";

static const NSInteger SerializerErrorCodeIncorectKeyClass = 100;
static const NSInteger SerializerErrorCodeIncorectInputDataClass = 200;
static const NSInteger SerializerErrorCodeIncorectValueClass = 300;



@interface Serializer ()

@property (assign, nonatomic) SerializerOptions options;

@end

@implementation Serializer

+ (NSString*) getStringFromData:(id)data withOptions:(SerializerOptions)options withError:(NSError*__autoreleasing*) error{
    Serializer* serializer = [[Serializer alloc] init];
    serializer.options = options;
    
    if (![data isKindOfClass:[NSDictionary class]]) {
        //Error: data isnt kind of NSDictionary class
        NSDictionary* userinfo = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [data class], @"input object class",
                                  @"переданный объект не является словарем", kSerializerErrorDescription, nil];
        if (error) {
            *error = [NSError errorWithDomain:SerializerErrorDomain
                                         code:SerializerErrorCodeIncorectInputDataClass
                                     userInfo:userinfo];
        }
        
        return nil;
    } else {
        //data is kind of NSDictionary class
        
        NSError* localError = nil;
        
        NSString* string = [serializer getStringFromDictionary:data withLevel:0 error:&localError];

        if (error) {
            *error = localError;
        }
        return string;
        
    }
    
    return nil;
}



- (NSString*) getStringForUnknownValue:(id) value withLevel:(NSInteger) level error:(NSError*__autoreleasing*) error{
    
    if ([value isKindOfClass:[NSArray class]]) {
        return [self getStringFromArray:value withLevel:level error:error];
    } else if ([value isKindOfClass:[NSDictionary class]]){
        return [self getStringFromDictionary:value withLevel:level error:error];
    } else if ([value isKindOfClass:[NSSet class]]){
        return [self getStringFromSet:value withLevel:level error:error];
    } else if ([value isKindOfClass:[NSNumber class]]){
        return [self getStringFromNumber:value];
    } else if ([value isKindOfClass:[NSValue class]]){
        return [self getStringFromValue:value withLevel:level error:error];
    } else if ([value isKindOfClass:[NSNull class]]){
        return [@"null" mutableCopy];
    } else {
        NSDictionary* userinfo = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [value class], @"bad object class",
                                  @"переданный словарь содержит объект недопустимого типа", kSerializerErrorDescription, nil];
        *error = [NSError errorWithDomain:SerializerErrorDomain
                                     code:SerializerErrorCodeIncorectValueClass
                                 userInfo:userinfo];
        return nil;
    }
}



- (NSString*) getStringFromArray:(NSArray*) array withLevel:(NSInteger) level error:(NSError*__autoreleasing*) error{
    NSMutableString* string = [NSMutableString string];
    
    if (self.options) {
        [string appendFormat:@"\n%@[  (array)  \n", [self getVoidStringWithLevel:level]];
    } else {
        [string appendFormat:@"\n%@[\n", [self getVoidStringWithLevel:level]];
    }
    
    for (int i = 0; i < [array count]; i++) {
        id object = [array objectAtIndex:i];
        
        ////exception
        if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]] || [object isKindOfClass:[NSSet class]]) { // I realy don't know a better way to do it
            NSInteger length = [string length];
            [string deleteCharactersInRange:NSMakeRange(length - 1, 1)];//delete /n
        }
        ////
        
        [string appendString:[self getVoidStringWithLevel:(level + 1)]];
        
        NSString* valueString = [self getStringForUnknownValue:object withLevel:(level + 1) error:error];
        if (*error) {
            return nil;
        }
        
        if (i == array.count - 1) { //is last
            [string appendFormat:@"%@\n", valueString];
        } else {
            [string appendFormat:@"%@,\n", valueString];
        }
    }
    
    NSInteger length = [string length];
    [string deleteCharactersInRange:NSMakeRange(length - 1, 1)];
    
    [string appendFormat:@"\n%@]", [self getVoidStringWithLevel:level]];
    
    return string;
}

- (NSString*) getStringFromDictionary:(NSDictionary*) dictionary withLevel:(NSInteger) level error:(NSError*__autoreleasing*) error{
    NSMutableString* string = [NSMutableString string];
    
    if (self.options) {
        [string appendFormat:@"\n%@{  (dictionary)  \n", [self getVoidStringWithLevel:level]];
    } else {
        [string appendFormat:@"\n%@{\n", [self getVoidStringWithLevel:level]];
    }
    
    NSArray* keys = [dictionary allKeys];
    
    for (int i = 0; i < [keys count]; i++) {
        id key = [keys objectAtIndex:i];
        
        if ([key isKindOfClass:[NSString class]]) {
            
            [string appendString:[self getVoidStringWithLevel:(level + 1)]];
            
            NSString* valueString = [self getStringForUnknownValue:dictionary[key] withLevel:(level + 1) error:error];
            if (*error) {
                return nil;
            }
            
            //[string appendFormat:@"%@ : %@,\n", key, valueString];
            
            if (i == keys.count - 1) { //is last
                [string appendFormat:@"%@ : %@\n", key, valueString];
            } else {
                [string appendFormat:@"%@ : %@,\n", key, valueString];
            }
            
        } else if ([key isKindOfClass:[NSNumber class]]){
            
            [string appendString:[self getVoidStringWithLevel:(level + 1)]];
            
            NSString* valueString = [self getStringForUnknownValue:dictionary[key] withLevel:(level + 1) error:error];
            if (*error) {
                return nil;
            }
            
            //[string appendFormat:@"%0.2f : %@,\n", [key floatValue], valueString];
            
            if (i == keys.count - 1) { //is last
                [string appendFormat:@"%0.2f : %@\n", [key floatValue], valueString];
            } else {
                [string appendFormat:@"%0.2f : %@,\n", [key floatValue], valueString];
            }
            
        } else {
            NSDictionary* userinfo = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      [key class], @"bad key class",
                                      @"один из ключей является объектом недопустимого типа", kSerializerErrorDescription, nil];
            *error = [NSError errorWithDomain:SerializerErrorDomain
                                             code:SerializerErrorCodeIncorectKeyClass
                                         userInfo:userinfo];
            return nil;
        }
    }
    
    [string appendFormat:@"%@}", [self getVoidStringWithLevel:level]];

    return string;
}

- (NSString*) getStringFromSet:(NSSet*) set withLevel:(NSInteger) level error:(NSError*__autoreleasing*) error{
    NSMutableString* string = [NSMutableString string];
    
    if (self.options) {
        [string appendFormat:@"\n%@(  (set)  \n", [self getVoidStringWithLevel:level]];
    } else {
        [string appendFormat:@"\n%@(\n", [self getVoidStringWithLevel:level]];
    }
    
    
    NSArray* array = [set allObjects];
    for (int i = 0; i < [array count]; i++) {
        id object = [array objectAtIndex:i];
        
        ////exception
        if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]] || [object isKindOfClass:[NSSet class]]) { // I realy don't know a better way to do it
            NSInteger length = [string length];
            [string deleteCharactersInRange:NSMakeRange(length - 2, 2)];
        }
        ////
        
        [string appendString:[self getVoidStringWithLevel:(level + 1)]];
        
        NSString* valueString = [self getStringForUnknownValue:object withLevel:(level + 1) error:error];
        if (*error) {
            return nil;
        }
        
        if (i == array.count - 1) { //is last
            [string appendFormat:@"%@\n", valueString];
        } else {
            [string appendFormat:@"%@,\n", valueString];
        }
    }
    
    [string appendFormat:@"%@)", [self getVoidStringWithLevel:level]];
    
    return string;
}

- (NSString*) getStringFromNumber:(NSNumber*) number{
    NSMutableString* string = [NSMutableString stringWithFormat:@"%@", number];
    return string;
}

- (NSString*) getStringFromValue:(NSValue*) value withLevel:(NSInteger) level error:(NSError*__autoreleasing*) error{ //for CGRect serializing
    CGRect rect = [value CGRectValue];
    //CGRectZero
    
    NSValue *rectValue = [NSValue valueWithCGRect:CGRectZero];
    if (strcmp((const char *)value.objCType, (const char *)rectValue.objCType)==0){
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
    } else {
        NSDictionary* userinfo = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  @"не корректный тип обернут в NSValue", kSerializerErrorDescription, nil];
        *error = [NSError errorWithDomain:SerializerErrorDomain
                                     code:SerializerErrorCodeIncorectValueClass
                                 userInfo:userinfo];
        
        return nil;
    }
    
    
}

- (NSString*) getVoidStringWithLevel:(NSInteger) level{
    NSMutableString* string = [NSMutableString string];
    for (int i = 0; i < level; i++) {
        [string appendString:@"   "];
    }
    return string;
}


@end
