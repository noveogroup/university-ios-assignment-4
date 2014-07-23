//
//  NSString+Tabulateble.m
//  noveo-homework-4
//
//  Created by Wadim on 7/24/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import "NSString+Tabulateble.h"

@implementation NSString (Tabulateble)

+ (NSString *) tabulatedStringFromString: (NSString *)sourceString withSpaces: (NSString *)spaces {
    NSMutableString __block *destinationString = [NSMutableString stringWithString:@""];
    NSInteger __block spacesCount = 0;
    [sourceString enumerateSubstringsInRange:NSMakeRange(0, [sourceString length]-1) options:NSStringEnumerationByLines usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [destinationString appendString:[NSString stringWithFormat:@"%@\n",substring]];
        NSRange openTag = [substring rangeOfString:@">"];
        NSRange closeTag = [substring rangeOfString:@"</"];
        NSRange quotesTag = [substring rangeOfString:@"\""];
        if (openTag.location!=NSNotFound && closeTag.location==NSNotFound) {
            spacesCount++;
        }
        if (closeTag.location!=NSNotFound) {
            spacesCount--;
            [destinationString deleteCharactersInRange:NSMakeRange([destinationString length]-[substring length]-[spaces length]-1, 2)];
        }
        if (quotesTag.location!=NSNotFound) {
            [destinationString insertString:@"\n" atIndex:[destinationString length]-[substring length]-[spaces length]*spacesCount-1];
        }
        for (NSInteger i = 0; i<spacesCount; i++) {
            [destinationString appendString:[NSString stringWithFormat:@"%@",spaces]];
        }
        
    }];
    return destinationString;
}

@end
