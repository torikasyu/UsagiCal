//
//  ViewController.m
//  UsagiCal
//
//  Created by Hiroki Tanaka on 12/01/02.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@interface ViewController (private)
-(void)setImageAtIndex:(NSInteger)index toImageView:(UIImageView*)imageView;
-(void)setupNextImage;
-(void)setupPreviousImage;
-(void)renewImages;
-(void)adjustViews;
@end

@synthesize currentIndex;

@synthesize mainScrollView;
@synthesize prevImage;
@synthesize currentImage;
@synthesize nextImage;

const int maxImageFiles = 12;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
	if (!decelerate) {
		// 画像の更新
		[self renewImages];
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
	[self renewImages];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	///
}

-(void)renewImages
{
	CGRect      rect;
	NSString*   fileName;
    NSString*   path;
	UIImage*    image;
	
	// 現在のインデックスを保存
    int oldIndex = currentIndex;
	
	// コンテントオフセットを取得
	CGPoint offset;
	offset = mainScrollView.contentOffset;

	NSLog(@"%f",offset.x);
	
	if (offset.x == 0) {
		// 前の画像へ移動
		currentIndex--;
		//[self setupPreviousImage];
		//[self adjustViews];
	}
	if (offset.x >= mainScrollView.contentSize.width - CGRectGetWidth(mainScrollView.frame)) {
	//if(offset.x >= 1000) {
		// 次の画像へ移動
		currentIndex++;
		//[self setupNextImage];
		//[self adjustViews];
	}
	
	// インデックスの値をチェック
    if (currentIndex < 0) {
        currentIndex = 0;
    }
    if (currentIndex > maxImageFiles - 1) {
        currentIndex = maxImageFiles - 1;
    }
    
    if (currentIndex == oldIndex) {
        return;
    }
	
	NSLog(@"%d",currentIndex);
	
	// 最初の画像のとき
    if (currentIndex == 0) {
        // 左側のimage viewは表示しない
        rect = CGRectZero;
        image = nil;
    }
    // 最初の画像以外のとき
    else {
        // 左側のimage viewのframe
        //rect.origin = CGPointZero;
        //rect.size = self.view.frame.size;
		//rect.size.height = 320;
		//rect.size.width = 480;
		
        // 左側のimage viewの画像の読み込み
        fileName = [NSString stringWithFormat:@"%02d", currentIndex];
        path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
        image = [[UIImage alloc] initWithContentsOfFile:path];
    }
	
	// 左側のimage viewの設定
    //prevImage.frame = rect;
    prevImage.image = image;
    [image release];
	
	// 中央のimage viewの画像の読み込み
    fileName = [NSString stringWithFormat:@"%02d", currentIndex + 1];
    path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    image = [[UIImage alloc] initWithContentsOfFile:path];
	currentImage.image = image;
    [image release];
	
	// 最後の画像のとき
    if (currentIndex >= maxImageFiles - 1) {
        rect = CGRectZero;
        image = nil;
    }
    // 最後の画像以外のとき
    else {
        // 右側のimage viewのframe
        //rect.origin.x = CGRectGetMaxX(_subScrollView.frame) + 20.0f;
		//rect.origin.x = CGRectGetMaxX(_imageView2.frame) + 20.0f;
        //rect.origin.y = 0;
        //rect.size = self.view.frame.size;
		//rect.size.height = 320;
		//rect.size.width = 480;
        
        // 右側のimage viewの画像の読み込み
        fileName = [NSString stringWithFormat:@"%02d", currentIndex + 2];
        path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
        image = [[UIImage alloc] initWithContentsOfFile:path];
    }
    
    // 右側のimage viewの設定
    //_imageView2.frame = rect;
    nextImage.image = image;
    [image release];
	
	// コンテントサイズとオフセットの設定
    CGSize  size;
	if(currentIndex <= 0 || currentIndex >= maxImageFiles - 1)
	{
		size.width = 1000;
	}
	else
	{
		size.width = 1500;
	}
	//size.width = 1500;
	size.height = 0;
	
    mainScrollView.contentSize = size;
	mainScrollView.contentOffset = currentImage.frame.origin;
}
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat position = scrollView.contentOffset.x / scrollView.bounds.size.width;
	CGFloat delta = position - (CGFloat)self.currentIndex;
	
	if (fabs(delta) >= 1.0f) {
		//self.currentScrollView.zoomScale = 1.0;
		//self.currentScrollView.contentOffset = CGPointZero;
		
		if (delta > 0) {
			// the current page moved to right
			self.currentIndex = self.currentIndex+1; // no check (no over case)
			[self setupNextImage];
			
		} else {
			// the current page moved to left
			self.currentIndex = self.currentIndex-1; // no check (no over case)
			[self setupPreviousImage];
		}
		
	}	
}
*/

-(void)setupPreviousImage
{
	//UIScrollView* tmpView = self.currentScrollView;
	//self.currentScrollView = self.previousScrollView;
	//self.previousScrollView = self.nextScrollView;
	//self.nextScrollView = tmpView;
	
	UIImageView *tmpImage = self.currentImage;
	self.currentImage = self.prevImage;
	self.prevImage = self.nextImage;
	self.nextImage = tmpImage;
	
	CGRect frame = self.currentImage.frame;
	frame.origin.x -= frame.size.width;
	self.prevImage.frame = frame;
	[self setImageAtIndex:self.currentIndex-1 toImageView:self.prevImage];
}

-(void)setupNextImage
{
	//UIScrollView* tmpView = self.currentScrollView;	
	//self.currentScrollView = self.nextScrollView;
	//self.nextScrollView = self.previousScrollView;
	//self.previousScrollView = tmpView;
	
	UIImageView *tmpImage = self.currentImage;
	self.currentImage = self.nextImage;
	self.nextImage = self.prevImage;
	self.prevImage = tmpImage;
	
	CGRect frame = self.currentImage.frame;
	frame.origin.x += frame.size.width;
	self.nextImage.frame = frame;
	[self setImageAtIndex:self.currentIndex+1 toImageView:self.nextImage];
}

- (void)adjustViews
{
	//CGSize contentSize = CGSizeMake(
	//								self.currentImage.frame.size.width * maxImageFiles,
	//								self.currentImage.frame.size.height);
	CGSize contentSize = CGSizeMake(1500, 320);
	self.mainScrollView.contentSize = contentSize;
	
	[self setImageAtIndex:self.currentIndex-1 toImageView:self.prevImage];
	[self setImageAtIndex:self.currentIndex   toImageView:self.currentImage];
	[self setImageAtIndex:self.currentIndex+1 toImageView:self.nextImage];
}

- (void)setImageAtIndex:(NSInteger)index toImageView:(UIImageView*)imageView
{
	if (index < 0 || maxImageFiles <= index) {
		imageView.image = nil;
		//mainScrollView.delegate = nil;
		return;
	}
	
	//UIImage* image = [UIImage imageWithContentsOfFile:[self.imageFiles objectAtIndex:index]];
	NSString *fileName;
	NSString *path;
	UIImage *image;
	fileName = [NSString stringWithFormat:@"%02d", index+1];
	path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
	image = [[UIImage alloc] initWithContentsOfFile:path];
	
	imageView.image = image;
	//imageView.contentMode = (image.size.width > image.size.height) ?
	//UIViewContentModeScaleAspectFit : UIViewContentModeScaleAspectFill;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	//mainScrollView.delegate = self;
	
	self.currentIndex = -1;
	[self renewImages];
}

- (void)viewDidUnload
{
    [self setMainScrollView:nil];
    [self setPrevImage:nil];
    [self setCurrentImage:nil];
    [self setNextImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	//return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	
	switch(interfaceOrientation)
	{
		case UIInterfaceOrientationPortrait:
		case UIInterfaceOrientationPortraitUpsideDown:
			return NO;
		default:
			return YES;
	}
}

- (void)dealloc {
    [mainScrollView release];
    [prevImage release];
    [currentImage release];
    [nextImage release];
    [super dealloc];
}
@end
