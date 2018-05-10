//
//  reviewViewController.m
//  collection
//
//  Created by ahme on 5/7/18.
//  Copyright © 2018 JETS. All rights reserved.
//

#import "reviewViewController.h"

@interface reviewViewController ()
{
    
    NSMutableDictionary *row;
    NSMutableDictionary *reviews;
    NSMutableArray *results;
    
    
}

@end

@implementation reviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [_reviewTable setDataSource:self];
   [_reviewTable setDelegate:self];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString *path=[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=457995803c8fb9ffacfe06327c23e535&append_to_response=reviews",_movieID];
    NSURL *URL = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            //  NSLog(@"%@ %@", response, responseObject);
            row = (NSMutableDictionary *) responseObject;
            reviews =[row objectForKey:@"reviews"];
            results =[reviews objectForKey:@"results"];
        }
    }];
    [dataTask resume];
    
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerCount) userInfo:nil
                                    repeats:NO ];

    // Do any additional setup after loading the view.
}

-(void)timerCount{
    [self.reviewTable reloadData ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reviewCell" forIndexPath:indexPath];
  
    UILabel *txt=[cell viewWithTag:1];
     UITextView *txt2=[cell viewWithTag:2];
    NSMutableDictionary *dict=[results objectAtIndex:indexPath.row];
    NSString * name=[dict valueForKey:@"author"];
    
    NSString * content=[dict valueForKey:@"content"];
    
    // NSLog(@"\n mmmmmcmcmcmcmcm name:%@ contect:%@",name,content);
    [txt setText:name];
    [txt2 setText:content];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}


@end
