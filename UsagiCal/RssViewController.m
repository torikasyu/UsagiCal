//
//  RssViewController.m
//  UsagiCal
//
//  Created by hiroki on 2013/07/21.
//
//

#import "RssViewController.h"
#import "WebViewController.h"

@interface RssViewController ()

@end

@implementation RssViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.navigationController.navigationBarHidden = NO;

    [self parseXml:@"http://rss.exblog.jp/rss/exblog/usalog/atom.xml" title:@"usa*log　晴れ。ときどき、うさぎ王国"];
	[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    //return 0;
    
    //return [m_table_dat count];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // return 0;
    
    //NSDictionary	*dic = [m_table_dat objectAtIndex:section];
	//NSArray			*ary = [dic objectForKey:@"name_ary"];
    
	//return [ary count];
    return [m_read_dat count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    //NSDictionary	*dic = [m_table_dat objectAtIndex:indexPath.section];
	//NSArray			*ary = [dic objectForKey:@"name_ary"];
	//NSDictionary	*name_dic = [ary objectAtIndex:indexPath.row];
	
	//cell.textLabel.text = [name_dic objectForKey:@"title"];
    
    
    NSDictionary *tmp = [m_read_dat objectAtIndex:indexPath.row];
    cell.textLabel.text = [tmp objectForKey:@"title"];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    /*
    NSDictionary	*dic = [m_table_dat objectAtIndex:indexPath.section];
	NSArray			*ary = [dic objectForKey:@"name_ary"];
	NSDictionary	*dic2 = [ary objectAtIndex:indexPath.row];
	*/
    
    WebViewController *webView = [[[WebViewController alloc] init] autorelease];
    
    NSDictionary *tmp = [m_read_dat objectAtIndex:indexPath.row];
    webView.strUrl = [tmp objectForKey:@"blog_url"];
    
    [self.navigationController pushViewController:webView animated:YES];
    
	// Safariを開いて、サイトに飛ぶ
	// UIApplication *app = [UIApplication sharedApplication];
	// [app openURL:[NSURL URLWithString:[dic2 objectForKey:@"blog_url"]]];
}


//************************************************
// メソッド名：parseXml
//! XMLパース解析
//================================================
/*! @param		urlString	URL文字列
 @param		titleText	タイトルテキスト
 @return		なし*/
//************************************************

-(void) parseXml:(NSString*)urlString title:(NSString*)titleText{
	// 再読み込み時の解放処理
	NSURL		*url = [NSURL URLWithString:urlString];
	NSXMLParser *ps = [[NSXMLParser alloc] initWithContentsOfURL:url];
    //パーサー設定
	[ps setDelegate:(id)self];
	[ps setShouldProcessNamespaces:FALSE];
	[ps setShouldReportNamespacePrefixes:FALSE];
	[ps setShouldResolveExternalEntities:FALSE];
	
	// パース解析する
	m_read_dat = [[NSMutableArray alloc] init];
	m_readable = FALSE;
	[ps parse];
	// パーサーの解放
	[ps release];
	    
	// タイトル
    self.title = titleText;
}

//************************************************
// メソッド名：parser
//! 構文解析、タグ終了
//================================================
/*! @param		parser			XMLパーサー
 @param		elementName		XML要素名
 @param		namespaceURI	XML名前空間のURI
 @param		qName			ref属性が参照する名前
 @param		attributeDict	attribute属性のデータ
 @return		void型はなし*/
//************************************************
- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict
{
	// 要素名を保存（タグの名前）
	nowElement = elementName;
	// <entry>タグ開始、フラグON
	if([elementName isEqualToString:@"entry"]){
		eachData = [[NSMutableDictionary alloc] init];
		m_readable = TRUE;
	}
    
	// <link>タグ
	if(m_readable && [elementName isEqualToString:@"link"]){
		[eachData setObject:[attributeDict valueForKey:@"href"] forKey:@"blog_url"];
	}
}

//************************************************
// メソッド名：parser
//! 構文解析、タグ終了
//================================================
/*! @param		parser			XMLパーサー
 @param		elementName		XML要素名
 @param		namespaceURI	XML名前空間のURI
 @param		qName			ref属性が参照する名前
 @return		void型はなし*/
//************************************************
- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
	// <entry>タグ終了、フラグOFF
	if([elementName isEqualToString:@"entry"]){
		m_readable = FALSE;
        
        if(![[[eachData objectForKey:@"title"] substringToIndex:2] isEqualToString:@"PR"])
        {
            [m_read_dat addObject:eachData];
        }
	}
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	// <title>、<published>タグならば辞書に追加
	if([nowElement isEqual:@"title"] || [nowElement isEqual:@"published"]){
		[eachData setObject:string forKey:nowElement];
	}
	// 要素名を空にする
	nowElement = @"";
}


@end
