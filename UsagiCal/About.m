//
//  About.m
//  UsagiCal
//
//  Created by Hiroki Tanaka on 12/01/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "About.h"

@implementation About

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
    {
        is4inch = YES;
    }
    else{
        //NSLog(@"ランドスケープモードだった場合。");
        is4inch = NO;
    }
    
    NSString *path;
    if(is4inch)
    {
        path = [[NSBundle mainBundle] pathForResource:@"shoukai-568h@2x" ofType:@"png"];
    }
    else
    {
        path = [[NSBundle mainBundle] pathForResource:@"shoukai" ofType:@"png"];        
    }
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
    self.imgAbout.image = img;
    
}

- (void)viewDidUnload
{
    [self setImgAbout:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
	//[self.navigationController setNavigationBarHidden:YES];
	//self.navigationController.navigationBar.hidden = NO;
	self.wantsFullScreenLayout = YES;
    [super viewWillAppear:animated];


}

-(void)viewDidAppear:(BOOL)animated
{
	self.navigationController.navigationBar.hidden = YES;
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)shopClick:(id)sender {
	UIAlertView* alert1 = [[[UIAlertView alloc] init] autorelease];
	alert1.delegate = self;
	alert1.title = @"Safariで「うさぎ王国ショップ」にアクセスしますか?";
	//alert1.message = @"Reset Score ?";
	alert1.tag = 0;
	[alert1 addButtonWithTitle:@"いいえ"];
	[alert1 addButtonWithTitle:@"はい"];	
	alert1.cancelButtonIndex = 0;
	[alert1 show];
}

- (IBAction)siteTopClick:(id)sender {
	UIAlertView* alert1 = [[[UIAlertView alloc] init] autorelease];
	alert1.delegate = self;
	alert1.title = @"Safariで「うさぎ王国」にアクセスしますか?";
	//alert1.message = @"Reset Score ?";
	alert1.tag = 1;
	[alert1 addButtonWithTitle:@"いいえ"];
	[alert1 addButtonWithTitle:@"はい"];	
	alert1.cancelButtonIndex = 0;
	[alert1 show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertView.tag == 0)
	{
		switch (buttonIndex) {
			case 0:
				break;
			default:
				[self openWebSite:@"http://shop.usagi-mimi.net/item_901/940.html"];
				break;
		}
	}
	else	//tag == 1
	{
		switch (buttonIndex) {
			case 0:
				break;
			default:					
				[self openWebSite:@"http://shop.usagi-mimi.net/"];
				break;
		}		
	}
}

-(void)openWebSite:(NSString*)urlString
{
	NSURL *url = [NSURL URLWithString:urlString];
	[[UIApplication sharedApplication] openURL:url];
}

- (IBAction)backgroundClick:(id)sender {	
	//BOOL hidden = (self.navigationController.navigationBar.hidden == true) ? false : true;
	BOOL hidden;
	if(self.navigationController.navigationBar.hidden == true)
	{
		hidden = false;
	}
	else
	{
		hidden = true;
	}
	//self.navigationController.navigationBar.hidden = hidden;
	//[UIApplication sharedApplication].statusBarHidden = hidden;
	[self.navigationController setNavigationBarHidden:hidden];
}
- (void)dealloc {
    [_imgAbout release];
    [super dealloc];
}
@end
