// ImageViewController.m

#import "ImageViewController.h"
#import "About.h"

static int  _maxPage = 12;

@interface ImageViewController (private)

// Appearance
- (void)_renewImages;
- (void)openWebsite;

@end

@implementation ImageViewController

//--------------------------------------------------------------//
#pragma mark -- View --
//--------------------------------------------------------------//

- (void)viewDidLoad
{
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
	self.wantsFullScreenLayout = YES;

	
	[self.navigationController setNavigationBarHidden:NO];
	
	// ナビゲーションバーを半透明に（selfはUIViewController）
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	self.navigationController.navigationBar.translucent = YES;
	
    // 4インチ判別
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
    {
        is4inch = YES;
    }
    else
    {
        is4inch = NO;
    }
    
	//保存ボタンの追加
	UIBarButtonItem* buttonSave = 
    [[UIBarButtonItem alloc] initWithTitle:@"画像を保存" 
                                     style:UIBarButtonItemStyleBordered 
                                    target:self 
                                    action:@selector(clickSave:)];
	self.navigationItem.rightBarButtonItem = buttonSave;
	[buttonSave release];
	
	//説明ボタンの追加
	UIBarButtonItem* buttonAbout = 
    [[UIBarButtonItem alloc] initWithTitle:@"Title" 
                                     style:UIBarButtonItemStyleBordered 
                                    target:self 
                                    //action:@selector(clickAbout:)];
									action:@selector(clickTitle:)];
	self.navigationItem.leftBarButtonItem = buttonAbout;
	[buttonAbout release];
	
    // innerViewをメインスクロールビューに追加
    [_mainScrollView addSubview:_innerView];
    
    // メインスクロールビューのコンテントサイズを設定
    _mainScrollView.contentSize = _innerView.frame.size;
    
    // インデックスの初期値
	NSDate *date = [NSDate date];                                                     
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = @"MM"; //　フォーマット指定
	dateFormatter.locale     = [[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"] autorelease]; // 日本語指定
	dateFormatter.calendar   = [[[NSCalendar alloc] initWithCalendarIdentifier: NSJapaneseCalendar] autorelease]; // 日本の暦指定
	_index = [[dateFormatter stringFromDate:date] intValue] - 1;
    //_index = -1;
	NSLog(@"%d", _index);

	[dateFormatter release];
}

-(void)clickSave:(id)sender
{
	NSString *fileName;
	NSString *path;
	UIImage *image;
	
	//fileName = [NSString stringWithFormat:@"%02d", _index+1];
    fileName = [self calImgPath:_index+1];
                
	path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
	image = [[UIImage alloc] initWithContentsOfFile:path];
    //画像をフォトアルバムに保存する
    UIImageWriteToSavedPhotosAlbum(
		image, self, @selector(targetImage:didFinishSavingWithError:contextInfo:),
		NULL);
	
	[image release];
}

/*
-(void)clickAbout:(id)sender
{
	About *aboutViewController = [[About alloc] init];
	//[aboutViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
	//[self presentModalViewController:aboutViewController animated:YES];
	
	[self.navigationController pushViewController:aboutViewController animated:YES];
	[aboutViewController release];
	
	// Navigation Bar, Status Bar, ToolBarを非表示に
	//[UIApplication sharedApplication].statusBarHidden = YES;
	//self.navigationController.navigationBar.hidden = YES;
}
*/

-(void)clickTitle:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

//画像の保存完了時に呼ばれるメソッド
-(void)targetImage:(UIImage*)image
didFinishSavingWithError:(NSError*)error contextInfo:(void*)context{
	
	if(error){
		// 保存失敗時
		NSLog(@"Save Error");
	}else{
		// 保存成功時
		NSLog(@"Save Success");
		
		UIAlertView* alert1 = [[[UIAlertView alloc] init] autorelease];
		alert1.delegate = self;
		alert1.title = @"カメラロールに保存しました";
		alert1.message = @"「写真」アプリを使って、ロック中の画面に設定してください";
		alert1.tag = 1;
		[alert1 addButtonWithTitle:@"OK"];
		[alert1 show];
	}
}

- (void)viewWillAppear:(BOOL)animated
{
    // 親クラスの呼び出し
    [super viewWillAppear:animated];
    	
    // 画像の更新
    [self _renewImages];
}

//--------------------------------------------------------------//
#pragma mark -- Image --
//--------------------------------------------------------------//

- (void)_renewImages
{
    CGRect      rect;
    NSString*   fileName;
    NSString*   path;
    UIImage*    image;
    
    // 現在のインデックスを保存
    int oldIndex = _index;
    
    // コンテントオフセットを取得
    CGPoint offset;
    offset = _mainScrollView.contentOffset;
    if (offset.x == 0) {
        // 前の画像へ移動
        _index--;
    }
    if (offset.x >= _mainScrollView.contentSize.width - CGRectGetWidth(_mainScrollView.frame)) {
        // 次の画像へ移動
        _index++;
    }
    
    // インデックスの値をチェック
    if (_index < 0) {
        _index = 0;
    }
    if (_index > _maxPage - 1) {
        _index = _maxPage - 1;
    }
    
    if (_index == oldIndex) {
        //return;
    }
    
    //
    // 左側のimage viewを更新
    //
    
    // 最初の画像のとき
    if (_index == 0) {
        // 左側のimage viewは表示しない
        rect = CGRectZero;
		//_imageView0.frame = CGRectZero;
        
        image = nil;
    }
    // 最初の画像以外のとき
    else {
        // 左側のimage viewのframe
        rect.origin = CGPointZero;
        rect.size = self.view.frame.size;
        //rect.size.width = 480;
		//rect.size.height = 320;
		
        // 左側のimage viewの画像の読み込み
        //fileName = [NSString stringWithFormat:@"%02d", _index];
        fileName = [self calImgPath:_index];
        path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
        image = [[UIImage alloc] initWithContentsOfFile:path];
    }
    
    // 左側のimage viewの設定
    _imageView0.frame = rect;
    _imageView0.image = image;
    [image release];
    
    //
    // 中央のimage view、サブスクロールビューを更新
    //
    
    // 中央のimage viewの画像の読み込み
    //fileName = [NSString stringWithFormat:@"%02d", _index + 1];
    fileName = [self calImgPath:_index + 1];
    path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    image = [[UIImage alloc] initWithContentsOfFile:path];
    
    // サブスクロールビューのframe
    rect.origin.x = CGRectGetMaxX(_imageView0.frame) > 0 ?
            CGRectGetMaxX(_imageView0.frame) + 20.0f : 0;
    rect.origin.y = 0;
	rect.size = self.view.frame.size;
    
    // サブスクロールビューの設定
    _subScrollView.frame = rect;
    
    // 中央のimage viewの設定
    rect.origin = CGPointZero;
	rect.size = self.view.frame.size;
	//rect.size.width = 480;
	//rect.size.height = 320;
	_imageView1.frame = rect;
    _imageView1.image = image;
    [image release];
    
    //
    // 右側のimage viewを更新
    //
    
    // 最後の画像のとき
    if (_index >= _maxPage - 1) {
        rect = CGRectZero;
        //_imageView2.frame = CGRectZero;
		
        image = nil;
    }
    // 最後の画像以外のとき
    else {
        // 右側のimage viewのframe
        rect.origin.x = CGRectGetMaxX(_subScrollView.frame) + 20.0f;
        rect.origin.y = 0;
		rect.size = self.view.frame.size;
        //rect.size.width = 480;
		//rect.size.height = 320;

        // 右側のimage viewの画像の読み込み
        //fileName = [NSString stringWithFormat:@"%02d", _index + 2];
        fileName = [self calImgPath:_index + 2];
        path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
        image = [[UIImage alloc] initWithContentsOfFile:path];
    }
    
    // 右側のimage viewの設定
    _imageView2.frame = rect;
    _imageView2.image = image;
    [image release];
    
    //
    // メインスクロールビューの更新
    //
    
    // コンテントサイズとオフセットの設定
    CGSize  size;
    size.width = CGRectGetMaxX(_imageView2.frame) > 0 ? 
            CGRectGetMaxX(_imageView2.frame) + 20.0f : 
            CGRectGetMaxX(_subScrollView.frame) + 20.0f;
    size.height = 0;
    _mainScrollView.contentSize = size;
    _mainScrollView.contentOffset = _subScrollView.frame.origin;
}

//--------------------------------------------------------------//
#pragma mark -- UIScrollViewDelegate --
//--------------------------------------------------------------//

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView 
        willDecelerate:(BOOL)decelerate
{
    // メインスクロールビューの場合
    if (scrollView == _mainScrollView) {
        if (!decelerate) {
            // 画像の更新
            [self _renewImages];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    // メインスクロールビューの場合
    if (scrollView == _mainScrollView) {
        // 画像の更新
        [self _renewImages];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	
	/*
	switch(interfaceOrientation)
	{
		case UIInterfaceOrientationPortrait:
		case UIInterfaceOrientationPortraitUpsideDown:
			return NO;
		default:
			return YES;
	}
	 */
}

-(NSString*)calImgPath:(int)index
{
    
    NSString *filename;
    if(is4inch)
    {
        //path = [[NSBundle mainBundle] pathForResource:@"shoukai-568h@2x" ofType:@"png"];
        filename = [NSString stringWithFormat:@"%02d-568h@2x", index];
    }
    else
    {
        //path = [[NSBundle mainBundle] pathForResource:@"shoukai" ofType:@"png"];
        filename = [NSString stringWithFormat:@"%02d", index];
    }
    return filename;
}

/*
-(void)logoButtonClick:(id)sender
{
// 表示/非表示の反転
 BOOL hidden = !self.navigationController.navigationBar.hidden;
 self.navigationController.navigationBar.hidden = hidden;
 [UIApplication sharedApplication].statusBarHidden = hidden;
}
 */

@end
