//
//  ViewController.m
//  RSSchool_T8
//
//  Created by rasul on 7/17/21.
//

#import "AtristViewController.h"
#import "UIColor+Extension.h"
#import "UIFont+Extensions.h"
#import "UIColor+HEX.h"
#import "PaletteViewController.h"
#import "RSSchool_T8-Swift.h"

@interface AtristViewController () <ArtistViewDelegate, TimerViewControllerDelegate, DrawingsViewDelegate>

#pragma mark Properties
@property (nonatomic, strong) ArtistView *artistView;
@property (nonatomic, strong) UIView *contanerView;
@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;
@property (nonatomic, strong) TimerViewController *timerController;
@property (nonatomic, strong) PaletteViewController *paletteController;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation AtristViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self configureNavigationBar];
	[self setupArtistView];
	[self setupContainerView];
}

- (void) configureNavigationBar {
	self.title = @"Artist";

	UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Drawings"
																																				 style:UIBarButtonItemStyleDone
																																				target:self
																																				action: @selector(rightBarButtonItemTapped)];
	self.navigationItem.rightBarButtonItem = rightBarButtonItem;

	NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor lightGreenSea:1.0],
															 NSFontAttributeName:[UIFont montserratRegular:17]};
	[self.navigationItem.rightBarButtonItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

- (void) setupArtistView {
	_artistView = [[ArtistView alloc] init];
	_artistView.translatesAutoresizingMaskIntoConstraints = false;
	_artistView.delegate = self;

	[self.view addSubview: _artistView];
	[_artistView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
	[_artistView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor].active = YES;
	[_artistView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor].active = YES;
	[_artistView.bottomAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
}

- (void) setupContainerView {
	_contanerView = [[UIView alloc] init];
	_contanerView.translatesAutoresizingMaskIntoConstraints = false;
	//[_contanerView setHidden:true];
	_contanerView.layer.backgroundColor = UIColor.whiteColor.CGColor;
	_contanerView.layer.maskedCorners = UIRectCornerTopLeft | UIRectCornerTopRight;
	_contanerView.layer.cornerRadius = 40.0;
	_contanerView.layer.shadowRadius = 3.0;
	_contanerView.layer.shadowOpacity = 0.25;
	_contanerView.layer.shadowOffset = CGSizeZero;
	_contanerView.layer.shadowColor = UIColor.blackColor.CGColor;

	[self.view addSubview: _contanerView];
	_heightConstraint = [_contanerView.heightAnchor constraintEqualToConstant:0];
	_heightConstraint.active = true;
	[_contanerView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor].active = YES;
	[_contanerView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor].active = YES;
	[_contanerView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor].active = YES;
}

- (void)setupColorsVC {
	_paletteController = [[PaletteViewController alloc] init];
	_paletteController.view.translatesAutoresizingMaskIntoConstraints = false;
	__weak typeof(self) weakSelf = self;
	[_paletteController setDidSaveButton:^{
		[weakSelf removeColorsVC];
		[weakSelf onConstaintHightAnimate:0];
	}];

	[_paletteController setDidSelectButton:^(UIColor * _Nonnull color) {
		weakSelf.contanerView.backgroundColor = color;
		[weakSelf.timer invalidate];
		weakSelf.timer = nil;
		
		if (!weakSelf.timer) {
			weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
				weakSelf.contanerView.backgroundColor = UIColor.whiteColor;
				[weakSelf.timer invalidate];
				weakSelf.timer = nil;
			}];
		}
	}];

	[self addChildViewController:_paletteController];
	[_contanerView addSubview:_paletteController.view];
	[_paletteController didMoveToParentViewController:self];

	[_paletteController.view.topAnchor constraintEqualToAnchor: _contanerView.topAnchor constant:20].active = YES;
	[_paletteController.view.leadingAnchor constraintEqualToAnchor: _contanerView.leadingAnchor constant:5].active = YES;
	[_paletteController.view.trailingAnchor constraintEqualToAnchor: _contanerView.trailingAnchor constant:-5].active = YES;
	[_paletteController.view.bottomAnchor constraintEqualToAnchor: _contanerView.bottomAnchor].active = YES;
}

- (void)removeColorsVC {
	[self willMoveToParentViewController:nil];
	[_paletteController.view removeFromSuperview];
	[_paletteController removeFromParentViewController];
	_paletteController = nil;
}

- (void)removeTimerVC {
	[_timerController willMoveToParentViewController:nil];
	[_timerController.view removeFromSuperview];
	[_timerController removeFromParentViewController];
	_timerController = nil;
}

- (void)setupTimerVC {
	_timerController = [[TimerViewController alloc] init];
	_timerController.progressValue = _artistView.progressValue;
	_timerController.view.translatesAutoresizingMaskIntoConstraints = false;
	_timerController.delegate = self;

	[self addChildViewController:_timerController];
	[_contanerView addSubview:_timerController.view];
	[_timerController didMoveToParentViewController:self];

	[_timerController.view.topAnchor constraintEqualToAnchor: _contanerView.topAnchor constant:20].active = YES;
	[_timerController.view.leadingAnchor constraintEqualToAnchor: _contanerView.leadingAnchor constant:5].active = YES;
	[_timerController.view.trailingAnchor constraintEqualToAnchor: _contanerView.trailingAnchor constant:-5].active = YES;
	[_timerController.view.bottomAnchor constraintEqualToAnchor: _contanerView.bottomAnchor].active = YES;
}


- (void) rightBarButtonItemTapped {
	[self pushDrawingsVC];
}

- (void)pushDrawingsVC {
	DrawingsViewController * controller = [[DrawingsViewController alloc] init];
	controller.currentPlanet = _artistView.currentDraw;
	controller.delegate = self;
	[self.navigationController pushViewController:controller animated:true];
}

- (void)onConstaintHightAnimate:(CGFloat)height {
	[self.heightConstraint setConstant:height];
	[UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		[self.view layoutIfNeeded];
	} completion:^(BOOL finished) {

	}];
}

-(void)shareSelect {
	UIGraphicsBeginImageContext(self.artistView.drawView.layer.frame.size);
	[self.artistView.drawView.layer renderInContext:UIGraphicsGetCurrentContext()];
		UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
	NSData *data = UIImagePNGRepresentation(img);
		UIActivityViewController *activityViewControntroller = [[UIActivityViewController alloc] initWithActivityItems:@[data] applicationActivities:nil];
	[self presentViewController:activityViewControntroller animated:YES completion:nil];
}

#pragma mark ArtistViewDelegate
- (void)didButtonTapped:(NSInteger)index {
		switch (index) {
			case 0:
				[self onConstaintHightAnimate:333];
				[self setupColorsVC];
				break;
			case 1:
				[self onConstaintHightAnimate:333];
				[self setupTimerVC];
				break;
			case 3:
				[self shareSelect];
				break;

			default:
				break;
		}
}

#pragma mark TimerViewControllerDelegate
- (void)didSaveButton {
	[self removeTimerVC];
	[self onConstaintHightAnimate:0];

}

- (void)didChangeValue:(float)value {
	[_artistView setProgressValue:value];
}

#pragma mark DrawingsViewDelegate
- (void)didSelect:(NSInteger)index {
	[_artistView setCurrentDraw:index];
}

@end
