//
//  AppDelegate.h
//  UsagiCal
//
//  Created by Hiroki Tanaka on 12/01/02.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class ImageViewController;
@class TitleViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) ImageViewController *viewController;
@property(strong,nonatomic)TitleViewController *viewController;

@end