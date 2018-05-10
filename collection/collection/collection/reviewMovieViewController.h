//
//  JETSViewController.h
//  customTable
//
//  Created by JETS on 5/4/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "movieDetailsViewController.h"


@interface reviewMovieViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property NSString *movieID;

@end
