//
//  Palette.m
//  RSSchool_T8
//
//  Created by rasul on 7/17/21.
//

#import "PaletteViewController.h"
#import "ColorsModel.h"
#import "UIColor+HEX.h"
#import "CustomButton.h"
#import "ColorButton.h"
#import "PaletteDrawView.h"

@interface PaletteViewController ()
@property (nonatomic, strong) NSMutableArray<ColorsModel *> *models;
@property (nonatomic, strong) CustomButton *saveButton;
@property (nonatomic, strong) NSMutableArray<PaletteDrawView *> *drawViews;
@property (nonatomic, strong) NSMutableArray *selectIndexs;

@end

@implementation PaletteViewController
int selectedIndex = -1;

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.clearColor;
  _models = [[NSMutableArray<ColorsModel *> alloc] init];

  [self fetch];
  _selectIndexs = [[NSMutableArray alloc] init];

  
  [self setupButton];
  [self setupSecureView];
 
  
}

- (void)fetch {
  NSString *path = [[NSBundle mainBundle] pathForResource:@"colors" ofType:@"json"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
  
  for (NSDictionary *dict in array) {
    ColorsModel *m =  [[ColorsModel alloc] initWithDictionary:dict];
    [_models addObject:m];
  }
}

- (void)setupButton {
  _saveButton = [[CustomButton alloc] initWithType:@"Save"];
  [_saveButton addTarget:self action:@selector(saveButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_saveButton];
  
  [_saveButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant: 10.0].active = YES;
  [_saveButton.widthAnchor constraintEqualToConstant: 85.0].active = YES;
  [_saveButton.heightAnchor constraintEqualToConstant: 32.0].active = YES;
  [_saveButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant: -40.0].active = YES;
}

- (void) setupSecureView {
  UIStackView *vStack = [[UIStackView alloc] init];
  vStack.translatesAutoresizingMaskIntoConstraints = NO;
  vStack.axis = UILayoutConstraintAxisVertical;
  vStack.distribution = UIStackViewDistributionFill;
  vStack.alignment = UIStackViewAlignmentFill;
  vStack.spacing = 20;
  
  UIStackView *hStackOne = [[UIStackView alloc] init];
  hStackOne.translatesAutoresizingMaskIntoConstraints = NO;
  hStackOne.axis = UILayoutConstraintAxisHorizontal;
  hStackOne.distribution = UIStackViewDistributionFillEqually;
  hStackOne.alignment = UIStackViewAlignmentFill;
  hStackOne.spacing = 20;
  
  UIStackView *hStackTwo = [[UIStackView alloc] init];
  hStackTwo.translatesAutoresizingMaskIntoConstraints = NO;
  hStackTwo.axis = UILayoutConstraintAxisHorizontal;
  hStackTwo.distribution = UIStackViewDistributionFillEqually;
  hStackTwo.alignment = UIStackViewAlignmentFill;
  hStackTwo.spacing = 20;
  
  int count = (int)[_models count];
  int middle = count / 2;
  NSArray<ColorsModel *> *leftArray = [_models subarrayWithRange: NSMakeRange(0, middle)];
  
  _drawViews = [[NSMutableArray<PaletteDrawView *> alloc] init];
  NSInteger tag = 0;
  for (int i = 0; i < leftArray.count ; i++) {
    PaletteDrawView *buttonView = [[PaletteDrawView alloc] init];
    buttonView.translatesAutoresizingMaskIntoConstraints = false;
    buttonView.delegate = self;
    buttonView.color = [UIColor colorWithHexString:leftArray[i].hexColor];
    buttonView.tag = i;
    tag = i;
    [_drawViews addObject:buttonView];
    [buttonView.heightAnchor constraintEqualToConstant: 40.0].active = YES;
    [buttonView.widthAnchor constraintEqualToConstant: 40.0].active = YES;
    [hStackOne addArrangedSubview:buttonView];
    [vStack addArrangedSubview: hStackOne];
  }
  
  for (int i = 6; i < _models.count ; i++) {
    PaletteDrawView *buttonView = [[PaletteDrawView alloc] init];
    buttonView.translatesAutoresizingMaskIntoConstraints = false;
    buttonView.delegate = self;
    buttonView.color = [UIColor colorWithHexString:_models[i].hexColor];
    buttonView.tag = i;
    [_drawViews addObject:buttonView];
    [buttonView.heightAnchor constraintEqualToConstant: 40.0].active = YES;
    [buttonView.widthAnchor constraintEqualToConstant: 40.0].active = YES;
    
    [hStackTwo addArrangedSubview:buttonView];
    [vStack addArrangedSubview: hStackTwo];
  }
  
  [self.view addSubview: vStack];
  
  [vStack.topAnchor constraintEqualToAnchor:self.saveButton.bottomAnchor constant:30].active = YES;
  [vStack.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant:12].active = YES;
  //[vStack.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor constant:-20].active = YES;
  //[vStack.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor].active = YES;
}


#pragma mark Action
- (void)saveButtonTapped:(UIButton *)sender {
  self.didSaveButton();
}


#pragma mark ColorDrawDelegate
- (void)didViewTapped:(UITapGestureRecognizer *)sender {
  NSInteger index = sender.view.tag;
  
  //NSLog(_drawViews[index].layerState ? @"YES" : @"NO");
  
  if (_drawViews[index].layerState == false) {
    [_selectIndexs addObject:@(index)];
    selectedIndex += 1;
    if (selectedIndex == 3) {
      int i = [_selectIndexs[0] intValue];
      _drawViews[i].layerState = !_drawViews[i].layerState;
      [self.drawViews[i] setNeedsDisplay];
      
      _drawViews[index].layerState = !_drawViews[index].layerState;
      [self.drawViews[index] setNeedsDisplay];
      
      [_selectIndexs removeObjectAtIndex:0];
      selectedIndex -= 1;
      
    } else {
      _drawViews[index].layerState = !_drawViews[index].layerState;
      [self.drawViews[index] setNeedsDisplay];
    }
    
    self.didSelectButton([UIColor colorWithHexString:_models[index].hexColor]);
  } else {
    _drawViews[index].layerState = !_drawViews[index].layerState;
    [self.drawViews[index] setNeedsDisplay];
    [_selectIndexs removeObjectAtIndex:selectedIndex];
    selectedIndex -= 1;
  }
}

@end
