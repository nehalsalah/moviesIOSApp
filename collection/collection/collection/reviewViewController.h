//
//  reviewViewController.h
//  collection
//
//  Created by ahme on 5/7/18.
//  Copyright © 2018 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFHTTPSessionManager.h>


@interface reviewViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *reviewTable;


@property NSString *movieID;


@end
