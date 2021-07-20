//
//  ArtistDrawView.m
//  RSSchool_T8
//
//  Created by rasul on 7/17/21.
//

#import "ArtistView.h"
#import "UIColor+Extension.h"
#import "CustomButton.h"

@interface ArtistView()

#pragma mark Properties
@property (nonatomic, strong) CustomButton *openPaletteButton;
@property (nonatomic, strong) CustomButton *openTimerButton;
@property (nonatomic, strong) CustomButton *drawButton;
@property (nonatomic, strong) CustomButton *shareButton;
@property (nonatomic, strong) CustomButton *resetButton;

@end

@implementation ArtistView

- (instancetype)init {
	self = [super init];
	if (self) {
		[self setupDrawView];
		[self setupButton];
		[self setupStackView];
		self.stateView = idle;
		[self updateState:idle];
		[self addTagrest];
		
		_currentDraw = _drawView.type;
		_progressValue = 1.0;
		
	}
	return self;
}

- (void)setCurrentDraw:(NSInteger)currentDraw {
	_currentDraw = currentDraw;
	_drawView.type = currentDraw;
}

- (void) setupDrawView {
	_drawView = [[DrawView alloc] init];
	_drawView.translatesAutoresizingMaskIntoConstraints = false;
	
	[self addSubview: self.drawView];
	[self.drawView.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor constant:40.0].active = YES;
	[self.drawView.heightAnchor constraintEqualToConstant: 300.0].active = YES;
	[self.drawView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant:37].active = YES;
	[self.drawView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant:-37].active = YES;
}

- (void)setupButton {
	_openPaletteButton = [[CustomButton alloc] initWithType:@"Open Pallete"];
	_openTimerButton = [[CustomButton alloc] initWithType:@"Open Timer"];
	_drawButton = [[CustomButton alloc] initWithType:@"Draw"];
	_shareButton = [[CustomButton alloc] initWithType:@"Share"];
	
	_openPaletteButton.tag = 0;
	_openTimerButton.tag = 1;
	_drawButton.tag = 2;
	_shareButton.tag = 3;
	
	[_openPaletteButton.widthAnchor constraintEqualToConstant: 163.0].active = YES;
	[_openTimerButton.widthAnchor constraintEqualToConstant: 151.0].active = YES;
	[_drawButton.widthAnchor constraintEqualToConstant: 91.0].active = YES;
	[_shareButton.widthAnchor constraintEqualToConstant: 95.0].active = YES;
	
	[_openPaletteButton.heightAnchor constraintEqualToConstant: 32.0].active = YES;
	[_openTimerButton.heightAnchor constraintEqualToConstant: 32.0].active = YES;
	[_drawButton.heightAnchor constraintEqualToConstant: 32.0].active = YES;
	[_shareButton.heightAnchor constraintEqualToConstant: 32.0].active = YES;
}

- (void)setupStackView {
	UIStackView *hStack = [[UIStackView alloc] init];
	hStack.translatesAutoresizingMaskIntoConstraints = NO;
	hStack.axis = UILayoutConstraintAxisHorizontal;
	hStack.distribution = UIStackViewDistributionFill;
	hStack.alignment = UIStackViewAlignmentFill;
	hStack.spacing = 20;
	
	UIStackView *vButtonStackOne = [[UIStackView alloc] init];
	vButtonStackOne.translatesAutoresizingMaskIntoConstraints = NO;
	vButtonStackOne.axis = UILayoutConstraintAxisVertical;
	vButtonStackOne.distribution = UIStackViewDistributionFillProportionally;
	vButtonStackOne.alignment = UIStackViewAlignmentLeading;
	vButtonStackOne.spacing = 20;
	
	UIStackView *vButtonStackTwo = [[UIStackView alloc] init];
	vButtonStackTwo.translatesAutoresizingMaskIntoConstraints = NO;
	vButtonStackTwo.axis = UILayoutConstraintAxisVertical;
	vButtonStackTwo.distribution = UIStackViewDistributionFillProportionally;
	vButtonStackTwo.alignment = UIStackViewAlignmentCenter;
	vButtonStackTwo.spacing = 20;
	
	[vButtonStackOne addArrangedSubview:_openPaletteButton];
	[vButtonStackOne addArrangedSubview:_openTimerButton];
	[vButtonStackTwo addArrangedSubview:_drawButton];
	[vButtonStackTwo addArrangedSubview:_shareButton];
	[hStack addArrangedSubview:vButtonStackOne];
	[hStack addArrangedSubview:vButtonStackTwo];
	
	[self addSubview: hStack];
	[hStack.topAnchor constraintEqualToAnchor:self.drawView.bottomAnchor constant:50.0].active = YES;
	//[hStack.heightAnchor constraintEqualToConstant: 300.0].active = YES;
	[hStack.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant:20].active = YES;
	[hStack.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant:-40].active = YES;
}

-(void)selectDraw {
		float progress = _progressValue / 60.0;
		NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:progress
																																 target:_drawView
																															 selector:@selector(changeStrokeEnd)
																															 userInfo:nil
																																repeats:true];
	__weak typeof(self) weakSelf = self;
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_progressValue * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[timer invalidate];
		[weakSelf updateState:done];

	});

	[_drawView setNeedsDisplay];

}

-(void) addTagrest {
	[_openPaletteButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[_openTimerButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[_drawButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[_shareButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)updateState:(State)stateView {
	switch (stateView) {
		case idle:
			_drawButton.tag = 2;
			[_drawButton setTitle:@"Draw" forState:UIControlStateNormal];
			[_shareButton setEnabled:false];
			[_openTimerButton setEnabled:true];
			[_openPaletteButton setEnabled:true];
			[_drawButton setEnabled:true];
			break;
		case draw:
			[_shareButton setEnabled:false];
			[_openTimerButton setEnabled:false];
			[_openPaletteButton setEnabled:false];
			[_drawButton setEnabled:false];
			break;
		case done:
			_drawButton.tag = 4;
			[_drawButton setTitle:@"Reset" forState:UIControlStateNormal];
			[_openTimerButton setEnabled:false];
			[_openPaletteButton setEnabled:false];
			[_drawButton setEnabled:true];
			[_shareButton setEnabled:true];
			break;
			
		default:
			break;
	}
}

- (void)setProgressValue:(CGFloat)progressValue {
	_progressValue = progressValue;
}

#pragma mark Actoin
- (void)buttonTapped:(UIButton *)sender {
	NSInteger index = sender.tag;
	[self.delegate didButtonTapped:index];
		switch (index) {
			case 2:
				[self selectDraw];
				[self updateState:draw];
				break;
			case 4:
				[_drawView.shapeLayer removeFromSuperlayer];
				[_drawView setNeedsDisplay];
				[self updateState:idle];
				break;
				
			default:
				break;
		}
}

@end
