//
//  AppDelegate.m
//  RSSchool_T8
//
//  Created by rasul on 7/17/21.
//

#import "AppDelegate.h"
#import "AtristViewController.h"
#import "UIColor+Extension.h"
#import "UIFont+Extensions.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] init];
	self.window.frame = [UIScreen mainScreen].bounds;
	AtristViewController *viewController = [[AtristViewController alloc] init];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
	self.window.rootViewController = navController;
	self.window.backgroundColor = [UIColor whiteColor];
	[self.window makeKeyAndVisible];
	
	//Navbar color
	
	NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor blackColor],
															 NSFontAttributeName:[UIFont montserratRegular:17]};

	[[UINavigationBar appearance] setTintColor:[UIColor lightGreenSea:1.0]];
	[[UINavigationBar appearance] setTranslucent:false];
	[[UINavigationBar appearance] setTitleTextAttributes:attributes];
 // [[UIBarItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];


	return YES;
}

@end
