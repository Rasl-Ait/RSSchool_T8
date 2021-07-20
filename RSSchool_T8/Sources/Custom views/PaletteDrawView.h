//
//  PaletteDrawView.h
//  RSSchool_T8
//
//  Created by rasul on 7/18/21.
//

#import <UIKit/UIKit.h>

#pragma mark Procotol
@protocol  PaletteDrawDelegate <NSObject>
- (void)didViewTapped:(UITapGestureRecognizer *_Nullable)sender;
@end

NS_ASSUME_NONNULL_BEGIN

@interface PaletteDrawView : UIView
@property  UIColor* color;
@property BOOL layerState;
@property (nonatomic, weak) id<PaletteDrawDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
