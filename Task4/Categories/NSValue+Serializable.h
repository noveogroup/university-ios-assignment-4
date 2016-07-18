//
//  NSValue+Serialize.h
//  Task4
//
//  Created by Sergey Plotnikov on 14.07.16.
//
//

#import <Foundation/Foundation.h>
#import "Serializable.h"

@interface NSValue (Serializable) <Serializable>

+ (NSValue *)valueWithCGRect:(CGRect)rect;

@end
