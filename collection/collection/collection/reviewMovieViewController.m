//
//  JETSViewController.m
//  customTable
//
//  Created by JETS on 5/4/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import "reviewMovieViewController.h"

@interface reviewMovieViewController ()
{
    
    NSMutableDictionary *row;
    NSMutableDictionary *reviews;
    NSMutableArray *results;
    
    
}


@end

@implementation reviewMovieViewController





- (void)viewDidLoad
{
    [super viewDidLoad];
    [_myTable setDataSource:self];
    [_myTable setDelegate:self];
       //movieDetails
    
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
    
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCount) userInfo:nil
                                    repeats:YES ];

    
	// Do any additional setup after loading the view, typically from a nib.
}


-(void)timerCount{
    [_myTable reloadData ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReview" forIndexPath:indexPath];
   
    UILabel *txt=[cell viewWithTag:1];
    UITextView *txt2=[cell viewWithTag:2];
    NSMutableDictionary *dict=[results objectAtIndex:indexPath.row];
    NSString * name=[dict valueForKey:@"author"];
    
    NSString * content=[dict valueForKey:@"content"];
  
    [txt setText:name];
    [txt2 setText:content];
   
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}

@end
