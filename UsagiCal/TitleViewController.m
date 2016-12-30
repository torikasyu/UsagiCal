//
//  TitleViewController.m
//  UsagiCal
//
//  Created by 広樹 田中 on 12/03/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TitleViewController.h"
#import "ImageViewController.h"
#import "About.h"
#import "RssViewController.h"

@interface TitleViewController ()

@end

@implementation TitleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	//[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
	//[UIApplication sharedApplication].statusBarHidden = YES;	
}

-(void)viewWillAppear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)showCalendar:(id)sender {
    NSLog(@"koko!!");
    
	ImageViewController *ivc = [[[ImageViewController alloc] initWithNibName:@"ImageViewController" bundle:nil] autorelease];	
	//UINavigationController *navCon = [[UINavigationController alloc] init];
    //[navCon pushViewController:ivc animated:YES];
	[self.navigationController pushViewController:ivc animated:YES];
    //[self.view addSubview:navCon.view];
}

- (IBAction)showInfo:(id)sender {
	About *aboutViewController = [[About alloc] init];
	//[aboutViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
	//[self presentModalViewController:aboutViewController animated:YES];
	
	[self.navigationController pushViewController:aboutViewController animated:YES];
	[aboutViewController release];
}

- (IBAction)showRss:(id)sender {
    RssViewController *rssView = [[[RssViewController alloc] initWithNibName:@"RssViewController" bundle:nil] autorelease];
    [self.navigationController pushViewController:rssView animated:YES];
}
- (void)dealloc {
    [super dealloc];
}
@end
