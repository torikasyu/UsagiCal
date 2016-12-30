//
//  ViewController.h
//  UsagiCal
//
//  Created by Hiroki Tanaka on 12/01/02.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>
{
	NSInteger currentIndex_;
}
@property (nonatomic, assign) NSInteger currentIndex;

@property (retain, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (retain, nonatomic) IBOutlet UIImageView *prevImage;
@property (retain, nonatomic) IBOutlet UIImageView *currentImage;
@property (retain, nonatomic) IBOutlet UIImageView *nextImage;

@end
