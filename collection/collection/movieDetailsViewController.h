//
//  movieDetailsViewController.h
//  collection
//
//  Created by ahme on 5/7/18.
//  Copyright © 2018 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "reviewMovieViewController.h"
#import "movie.h"
#import "DBManager.h"
#import "movieFavProtocol.h"
#import "favoriteViewController.h"

@interface movieDetailsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property id<movieFavProtocol> saveProtocol;

@property (weak, nonatomic) IBOutlet UILabel *titleTxt;
@property (weak, nonatomic) IBOutlet UISegmentedControl *markProp;
@property (weak, nonatomic) IBOutlet UILabel *rate;
- (IBAction)reviewAction:(id)sender;

- (IBAction)markAction:(UISegmentedControl *)sender;

@property (weak, nonatomic) IBOutlet UITextView *overviewTxt;
@property movie *m;
@property (weak, nonatomic) IBOutlet UITableView *tableTrailer;

@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@end
