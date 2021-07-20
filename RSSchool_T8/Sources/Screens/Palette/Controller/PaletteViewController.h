//
//  Palette.h
//  RSSchool_T8
//
//  Created by rasul on 7/17/21.
//

#import <UIKit/UIKit.h>
#import "PaletteDrawView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PaletteViewController:UIViewController<PaletteDrawDelegate>
@property (copy, nonatomic) void (^didSaveButton)(void);
@property (copy, nonatomic) void (^didSelectButton)(UIColor *color);

@end

NS_ASSUME_NONNULL_END
