//
//  SerializationError.m
//  Lab4
//
//  Created by Пользователь on 28/02/15.
//  Copyright (c) 2015 Пользователь. All rights reserved.
//

#import "SerializationError.h"

@implementation SerializationError

+(NSError*) getErrorNotSupportedKeyWithClass:(Class)_class
{
    NSDictionary *details = @{NSLocalizedDescriptionKey:
                                  [NSString stringWithFormat:@"Not supported key - [%@] on dictinary",[_class description]]};
    
    return [NSError errorWithDomain:nil code:ErrorNotSupportedKeyOnDictinary userInfo:details];
}

+(NSError*) getErrorNotSupportedObjectWithClass:(Class)_class
{
    NSDictionary *details = @{NSLocalizedDescriptionKey:
                                  [NSString stringWithFormat:@"Not supported object - [%@]",[_class description]]};
    
    return [NSError errorWithDomain:nil code:ErrorNotSupportedObject userInfo:details];
}

+(NSError*) getErrorWrongInputParametersWithClass:(Class)_class
{
    NSDictionary *details = @{NSLocalizedDescriptionKey:
                                  [NSString stringWithFormat:@"Wrong input parameters, serializer not supported - [%@]",[_class description]]};
    
    return [NSError errorWithDomain:nil code:ErrorWrongInputParameters userInfo:details];
}

@end
