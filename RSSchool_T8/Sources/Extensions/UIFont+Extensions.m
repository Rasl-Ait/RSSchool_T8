//
//  UIFont+Extensions.m
//  RSSchool_T8
//
//  Created by rasul on 7/17/21.
//

#import "UIFont+Extensions.h"

@implementation UIFont (Extensions)

+ (UIFont *)montserratRegular:(CGFloat)size {
	return [UIFont fontWithName:@"Montserrat Regular"
												 size: size];;
}

+ (UIFont *)montserratMedium:(CGFloat)size {
	return [UIFont fontWithName:@"Montserrat Medium"
												 size: size];;
}


@end
