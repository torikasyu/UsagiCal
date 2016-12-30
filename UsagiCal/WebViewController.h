//
//  WebViewController.h
//  UsagiCal
//
//  Created by hiroki on 2013/07/21.
//
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController{
    NSString *strUrl;
}
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,retain)NSString *strUrl;

@end
