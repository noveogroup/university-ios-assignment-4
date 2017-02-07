//
//  NSString+Tabulateble.h
//  noveo-homework-4
//
//  Created by Wadim on 7/24/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Tabulateble)

+ (NSString *) tabulatedStringFromString: (NSString *)sourceString withSpaces: (NSString *)spaces;

@end
