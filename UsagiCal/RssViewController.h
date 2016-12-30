//
//  RssViewController.h
//  UsagiCal
//
//  Created by hiroki on 2013/07/21.
//
//

#import <UIKit/UIKit.h>

@interface RssViewController : UITableViewController{
    NSMutableArray	*m_read_dat;		//!< 読み取りデータ
	NSString		*nowElement;	//!< 解析用、要素名
	BOOL			m_readable;			//!< 解析用、読み取りフラグ
    NSMutableDictionary *eachData;      //１投稿分のデータ
}

// メソッド（手続き、操作）
//! XMLパース解析
-(void) parseXml:(NSString*)urlString title:(NSString*)titleText;

@end
