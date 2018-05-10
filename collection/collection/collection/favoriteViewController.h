//
//  favoriteViewController.h
//  
//
//  Created by ahme on 5/8/18.
//
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
#import "movie.h"
#import "movieFavProtocol.h"
#import "movieDetailsViewController.h"

@interface favoriteViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,movieFavProtocol>


@property (weak, nonatomic) IBOutlet UITableView *favTable;
@property (nonatomic) NSMutableArray *list;

@end
