//
//  PaletteDrawView.m
//  RSSchool_T8
//
//  Created by rasul on 7/18/21.
//

#import "PaletteDrawView.h"

@implementation PaletteDrawView

- (instancetype)init {
	self = [super init];
	if (self) {
		self.backgroundColor = UIColor.clearColor;
		self.color = UIColor.redColor;
		self.layerState = false;
		[self setUserInteractionEnabled:true];
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestupreTap:)];
		[self addGestureRecognizer:tap];
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGFloat width = (!_layerState ? 24.0 : 32.0);
	CGFloat x = (!_layerState ? 8.0 : 4.0);
	//// Color Declarations
	UIColor* fillColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];

	//// Shadow Declarations
	NSShadow* shadow = [[NSShadow alloc] init];
	shadow.shadowColor = [UIColor.blackColor colorWithAlphaComponent: 0.55];
	shadow.shadowOffset = CGSizeMake(0, 0);
	shadow.shadowBlurRadius = 1;

	//// unchecked.svg Group
	
			//// Group 2
			{
					//// Rectangle Drawing
					UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(1, 1, 38, 38) cornerRadius: 10];
					CGContextSaveGState(context);
					CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
					[fillColor setFill];
					[rectanglePath fill];
					CGContextRestoreGState(context);



					//// Rectangle 2 Drawing
					UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(x, x, width, width) cornerRadius: 6];
					[_color setFill];
					[rectangle2Path fill];
			}
}

- (void)gestupreTap:(UITapGestureRecognizer *)sender {
	[self.delegate didViewTapped:sender];
}

@end
