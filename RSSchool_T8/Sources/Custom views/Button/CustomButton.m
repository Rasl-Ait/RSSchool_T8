//
//  CustomButton.m
//  AuthApp
//
//  Created by rasul on 7/6/21.
//

#import "CustomButton.h"
#import "UIColor+Extension.h"
#import "UIFont+Extensions.h"

@implementation CustomButton

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];

	if (highlighted) {
		self.layer.shadowRadius = 3.0;
		self.layer.shadowOpacity = 1.0;
		self.layer.shadowColor = [UIColor lightGreenSea:1.0].CGColor;
	} else {
		self.layer.shadowRadius = 1.5;
		self.layer.shadowOpacity = 0.25;
		self.layer.shadowColor = UIColor.blackColor.CGColor;
	}
}

- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
	if (selected) {
		self.layer.shadowRadius = 3.0;
		self.layer.shadowOpacity = 1.0;
		self.layer.shadowColor = [UIColor lightGreenSea:1.0].CGColor;
	} else {
		self.layer.shadowRadius = 1.5;
		self.layer.shadowOpacity = 0.25;
		self.layer.shadowColor = UIColor.blackColor.CGColor;
	}
}

- (instancetype)init
{
	self = [super init];
	if (self) {
	}
	return self;
}

- (id)initWithType:(NSString *)title {
	self = [super init];
	if(self ) {
		[self setup:title];
	}
	return self;
}

- (void) setup:(NSString *)title {
	self.translatesAutoresizingMaskIntoConstraints = false;
	[self setTitle:title forState:UIControlStateNormal];
	self.titleLabel.font = [UIFont montserratRegular:18];
	[self setTitleColor: [UIColor lightGreenSea:1.0]
						 forState: UIControlStateNormal];
	[self setTitleColor: [UIColor lightGreenSea:0.5]
						 forState: UIControlStateDisabled];
	self.layer.backgroundColor = UIColor.whiteColor.CGColor;
	self.layer.cornerRadius = 8.0;
	self.layer.shadowRadius = 1.5;
	self.layer.shadowOpacity = 0.25;
	self.layer.shadowOffset = CGSizeZero;
self.layer.shadowColor = UIColor.blackColor.CGColor;
}


@end
