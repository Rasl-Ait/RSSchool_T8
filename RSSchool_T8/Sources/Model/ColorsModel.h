//
//  ColorsModel.h
//  RSSchool_T8
//
//  Created by rasul on 7/17/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorsModel : NSObject

@property (nonatomic, strong) NSString *hexColor;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
