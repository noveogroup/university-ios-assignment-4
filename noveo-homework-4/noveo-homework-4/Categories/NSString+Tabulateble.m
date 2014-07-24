//
//  NSString+Tabulateble.m
//  noveo-homework-4
//
//  Created by Wadim on 7/24/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import "NSString+Tabulateble.h"

@implementation NSString (Tabulateble)


// Method very slow and non-optimized but still returns tabulated string.

+ (NSString *) tabulatedStringFromString: (NSString *)sourceString withSpaces: (NSString *)spaces {
    // MutableString for creating tabulated string in __block
    NSMutableString __block *destinationString = [NSMutableString stringWithString:@""];
    // Count for space_tabs in __block init by 0
    NSInteger __block spacesCount = 0;
    // Start enumerating via sourceString by Lines
    [sourceString enumerateSubstringsInRange:NSMakeRange(0, [sourceString length]-1)
                                     options:NSStringEnumerationByLines
                                  usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [destinationString appendString:[NSString stringWithFormat:@"%@\n",substring]];
        // Check for special symbols
        NSRange openTag = [substring rangeOfString:@">"];
        NSRange closeTag = [substring rangeOfString:@"</"];
        NSRange quotesTag = [substring rangeOfString:@"\""];
        // Handle tag open
        if (openTag.location!=NSNotFound && closeTag.location==NSNotFound) {
            spacesCount++;
        }
        // Handle tag close
        if (closeTag.location!=NSNotFound) {
            spacesCount--;
            [destinationString deleteCharactersInRange:NSMakeRange([destinationString length]-[substring length]-
                                                                   [spaces length]-1, [spaces length])];
        }
        // Handle quotes
        if (quotesTag.location!=NSNotFound ) {
            [destinationString insertString:@"\n" atIndex:[destinationString length]-[substring length]-
             [spaces length]*spacesCount-1];
        }
        // Can we use blocks into blocks? Leave this question bis morning.
        for (NSInteger i = 0; i<spacesCount; i++) {
            [destinationString appendString:[NSString stringWithFormat:@"%@",spaces]];
        }
        
    }];
    return destinationString;
}

@end
