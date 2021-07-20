//
//  ColorButton.m
//  RSSchool_T8
//
//  Created by rasul on 7/18/21.
//

#import "ColorButton.h"
#import "UIColor+Extension.h"
#import "UIFont+Extensions.h"

@implementation ColorButton

//- (void)setHighlighted:(BOOL)highlighted {
//	[super setHighlighted:highlighted];
//
//	if (highlighted) {
//		self.backgroundColor = [UIColor colorBlue:0.2];
//	} else {
//		self.backgroundColor = [UIColor clearColor];
//	}
//}

- (instancetype)init {
  self = [super init];
  if (self) {
  }
  return self;
}

- (id)initWithType:(UIColor *)bgColor {
  self = [super init];
  if(self ) {
    [self setup:bgColor];
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  UIColor* fillColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
  UIColor* fillColor2 = [UIColor colorWithRed: 0.886 green: 0.106 blue: 0.173 alpha: 1];
  
  //// unchecked.svg Group
  {
    //// Group 2
    {
      //// Rectangle Drawing
      UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(90, 22, 40, 40) cornerRadius: 10];
      [fillColor setFill];
      [rectanglePath fill];
    }
    
    
    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(98, 30, 24, 24) cornerRadius: 6];
    [fillColor2 setFill];
    [rectangle2Path fill];
  }
}

- (void) setup:(UIColor *)bgColor {
  self.translatesAutoresizingMaskIntoConstraints = false;
  
  self.layer.backgroundColor = bgColor.CGColor;
  self.layer.cornerRadius = 6;
  self.layer.shadowRadius = 1.0;
  self.layer.shadowOpacity = 0.25;
  self.layer.borderWidth = 9.0;
  self.layer.borderColor = UIColor.whiteColor.CGColor;
  self.layer.shadowOffset = CGSizeZero;
  self.layer.shadowColor = UIColor.blackColor.CGColor;
}
@end
