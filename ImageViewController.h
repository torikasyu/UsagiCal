// ImageViewController.h

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController<UIScrollViewDelegate,UIAlertViewDelegate>
{
    int _index;
    BOOL is4inch;
    
    IBOutlet UIScrollView*  _mainScrollView;
    
    IBOutlet UIView*        _innerView;
    IBOutlet UIScrollView*  _subScrollView;
    IBOutlet UIImageView*   _imageView0;
    IBOutlet UIImageView*   _imageView1;
    IBOutlet UIImageView*   _imageView2;
}
//-(IBAction)clickAbout:(id)sender;
-(IBAction)clickSave:(id)sender;
-(IBAction)clickTitle:(id)sender;


//-(IBAction)logoButtonClick:(id)sender;

@end

