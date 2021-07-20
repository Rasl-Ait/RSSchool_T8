//
//  ArtistDrawView.h
//  RSSchool_T8
//
//  Created by rasul on 7/17/21.
//

#import <UIKit/UIKit.h>
#import "DrawView.h"

typedef enum {
	idle,
	draw,
	done
} State;

#pragma mark Delegate
@protocol ArtistViewDelegate <NSObject>
- (void) didButtonTapped: (NSInteger)index;
@end

NS_ASSUME_NONNULL_BEGIN

@interface ArtistView : UIView
@property (nonatomic) State stateView;
@property (nonatomic, assign) NSInteger currentDraw;
@property (nonatomic, assign) CGFloat progressValue;
@property (nonatomic, weak) id<ArtistViewDelegate> delegate;
@property (nonatomic, strong) DrawView *drawView;

- (void) setCurrentDraw:(NSInteger)currentDraw;
- (void) setProgressValue:(CGFloat)progressValue;

@end

NS_ASSUME_NONNULL_END
