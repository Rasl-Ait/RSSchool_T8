//
//  UIColor+Extension.m
//  AuthApp
//
//  Created by rasul on 7/4/21.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)


+(UIColor *)lightGreenSea:(CGFloat)alpha  {
	return [UIColor colorWithRed: 33/255.0
												 green: 176/255.0
													blue: 142/255.0
												 alpha: alpha];
}

+(UIColor *)chillSky {
	return [[UIColor alloc] initWithRed:0.0/255.0
																green:178.0/255.0
																 blue:255.0/255.0
																alpha:1.0];

}

@end
