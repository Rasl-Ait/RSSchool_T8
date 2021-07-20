//
//  DrawView.h
//  RSSchool_T8
//
//  Created by rasul on 7/17/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DrawViewType) {
	DrawPlanet = 0,
	DrawHead,
	DrawTree,
	DrawLandscape
	
};

@interface DrawView : UIView
@property (nonatomic, assign) CGFloat persent;
@property (nonatomic, assign) DrawViewType type;
@property (weak, nonatomic) CAShapeLayer *shapeLayer;
@property (assign, nonatomic) float progress;

-(void)changeStrokeEnd;

@end

NS_ASSUME_NONNULL_END
