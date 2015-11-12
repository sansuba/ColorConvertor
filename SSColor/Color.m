//
//  HexColor.m
//  SSColor
//
//  Created by Subhash Sanjeewa on 11/11/15.
//  Copyright © 2015 Persystance Networks. All rights reserved.
//

#import "Color.h"

@implementation Color
@end

UIColor* colorFromHex(NSString* hexValue) {
    UIColor *defaultResult = [UIColor blackColor];
    if ([hexValue hasPrefix:@"#"] && [hexValue length] > 1) {
        hexValue = [hexValue substringFromIndex:1];
    }
    NSUInteger componentLength = 0;
    if ([hexValue length] == 3)
    {
        componentLength = 1;
    }
    else if ([hexValue length] == 6)
    {
        componentLength = 2;
    }
    else
    {
        return defaultResult;
    }
    
    BOOL isValid = YES;
    CGFloat components[3];
    
    for (NSUInteger i = 0; i < 3; i++) {
        NSString *component = [hexValue substringWithRange:NSMakeRange(componentLength * i, componentLength)];
        if (componentLength == 1) {
            component = [component stringByAppendingString:component];
        }
        NSScanner *scanner = [NSScanner scannerWithString:component];
        unsigned int value;
        isValid &= [scanner scanHexInt:&value];
        components[i] = (CGFloat)value / 256.0f;
    }
    
    if (!isValid) {
        return defaultResult;
    }
    
    return [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:1.0];
}

UIColor* colorFromHexLong(long hexValue) {
    return colorFromHex([NSString stringWithFormat:@"%lu",hexValue]);
}

UIColor* colorFromView(UIView* view) {
    return view.backgroundColor;
}

NSString* hexStringFromColor(UIColor* color) {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}

CGFloat colorComponentFrom(NSString* string, NSUInteger start, NSUInteger length) {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

UIColor* colorWithHexString (NSString* hexString) {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    
    NSLog(@"colorString :%@",colorString);
    CGFloat alpha, red, blue, green;
    
    // #RGB
    alpha = 1.0f;
    red   = colorComponentFrom(colorString, 0, 2);
    green = colorComponentFrom(colorString, 2, 2);
    blue  = colorComponentFrom(colorString, 4, 2);
    
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}