//
//  ColorsModel.m
//  RSSchool_T8
//
//  Created by rasul on 7/17/21.
//

#import "ColorsModel.h"

@implementation ColorsModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
		self = [super init];
		if (self) {
				_hexColor = dictionary[@"hexColor"];
		}
		return self;
}


@end
