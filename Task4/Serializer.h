//
//  Serializer.h
//  Task4
//
//  Created by Sergey Plotnikov on 13.07.16.
//
//

#import <Foundation/Foundation.h>
#import "Serializable.h"

@interface Serializer : NSObject <Serializable>

+ (NSString *)serializeContainer:(NSDictionary *)container error:(NSError *__autoreleasing *)error;

@end
