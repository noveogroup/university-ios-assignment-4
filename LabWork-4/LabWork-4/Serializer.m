#import "Serializer.h"

@implementation Serializer

// The only public method
+ (NSString *)serializeDictionary:(id)dictionary error:(NSError **)error {
    //TODO check if not a dictionary
    NSMutableString *result = [[NSMutableString alloc] init];
    return [[self class] serializeObject:dictionary result:&result];
}

+ (NSString *)serializeObject:(id)object result:(NSMutableString **)result {
    if ([object isKindOfClass:[NSDictionary class]]) {
        [[self class] serializeNSDictionary:(NSDictionary *)object result:&*result];
    }
    else if ([object isKindOfClass:[NSArray class]]) {
        [[self class] serializeNSArray:(NSArray *)object result:&*result];
    }
    else if ([object isKindOfClass:[NSSet class]]) {
        [[self class] serializeNSSet:(NSSet *)object result:&*result];
    }
    else if ([object isKindOfClass:[NSNumber class]]) {
        [[self class] serializeNSNumber:(NSNumber *)object result:&*result];
    }
    else if ([object isKindOfClass:[NSNull class]]) {
        [[self class] serializeNSNull:(NSNull *)object result:&*result];
    }
    else if ([object isKindOfClass:[NSValue class]]) {
        [[self class] serializeCGRect:(NSValue *)object result:&*result];
    }
    else {
        //TODO return error
    }
    return *result;
}

+ (void)serializeNSDictionary:(NSDictionary *)dictionary result:(NSMutableString **)result {
    [*result appendString: @"{"];
    NSArray *dictionaryKeys = [dictionary allKeys];
    for (id key in dictionaryKeys) {
        [*result appendFormat:@"\"%@\": ", key];
        [[self class] serializeObject: dictionary[key] result:*&result];
        if (key != [dictionaryKeys lastObject]) {
            [*result appendString: @", "];
        }
    }
    [*result appendString: @"}"];
}

+ (void)serializeNSArray:(NSArray *)array result:(NSMutableString **)result {
    [*result appendString: @"["];
    for (id item in array) {
        [[self class] serializeObject:item result:&*result];
        if (item != [array lastObject]) {
            [*result appendString: @", "];
        }
    }
    [*result appendString: @"]"];
}

+ (void)serializeNSSet:(NSSet *)set result:(NSMutableString **)result {
    NSArray *tempArray = [set allObjects];
    [[self class] serializeNSArray:tempArray result:*&result];
}

+ (void)serializeNSNumber:(NSNumber *)number result:(NSMutableString **)result {
    [*result appendString: [number stringValue]];
}

+ (void)serializeNSNull:(NSNull *)null result:(NSMutableString **)result {
    [*result appendString: @"null"];
}

+ (void)serializeCGRect:(NSValue *)value result:(NSMutableString **)result {
    CGRect rect = [value rectValue];
    NSDictionary *tempDict = @{@"width": [NSNumber numberWithFloat:rect.size.width],
                               @"height": [NSNumber numberWithFloat:rect.size.height],
                               @"x": [NSNumber numberWithFloat:rect.origin.x],
                               @"y": [NSNumber numberWithFloat:rect.origin.y]};
    [[self class] serializeNSDictionary:tempDict result:*&result];
}

@end
