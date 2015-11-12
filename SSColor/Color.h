//
//  HexColor.h
//  SSColor
//
//  Created by Subhash Sanjeewa on 11/11/15.
//  Copyright © 2015 Persystance Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

extern UIColor* colorFromHex(NSString* hexValue);
extern UIColor* colorFromHexLong(long hexValue);

extern NSString* hexStringFromColor(UIColor* color);
extern UIColor* colorWithHexString (NSString* hexString);

@interface Color : UIView
@end
