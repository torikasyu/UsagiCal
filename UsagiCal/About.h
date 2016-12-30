//
//  About.h
//  UsagiCal
//
//  Created by Hiroki Tanaka on 12/01/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface About : UIViewController<UIAlertViewDelegate>
{
    BOOL is4inch;
}
- (IBAction)shopClick:(id)sender;
- (IBAction)siteTopClick:(id)sender;
- (IBAction)backgroundClick:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *imgAbout;

-(void)openWebSite:(NSString*)urlString;

@end
