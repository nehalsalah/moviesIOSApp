//
//  movieDetailsViewController.m
//  collection
//
//  Created by ahme on 5/7/18.
//  Copyright © 2018 JETS. All rights reserved.
//

#import "movieDetailsViewController.h"

@interface movieDetailsViewController ()
{
    
    NSMutableDictionary *row;
    NSMutableDictionary *videos;
    NSMutableArray *results;
    NSString *videoURL;
    DBManager *db;
    NSArray *fav1;
    NSMutableArray *list;
    
}


@end

@implementation movieDetailsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    list=[NSMutableArray new];
       [db createTable];
    list = db.displayData;
    
    db=[DBManager sharedInstance];
    fav1=[NSArray new];
    NSString *path=[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w185/%@",_m.posterPath];
    [_movieImage sd_setImageWithURL:[NSURL URLWithString:path ]  placeholderImage:[UIImage imageNamed:@"face.png" ]];
    _overviewTxt.text=_m.overview;
    _titleTxt.text=_m.title;
   _rate.text=_m.vote;
    
    [_tableTrailer setDataSource:self];
    [_tableTrailer setDelegate:self];
    
    
    
   // _saveProtocol = fav;
    
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
      NSString *path2=[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=457995803c8fb9ffacfe06327c23e535&append_to_response=videos",_m.movieID];
//    NSString *path=[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=457995803c8fb9ffacfe06327c23e535&append_to_response=videos",_m.movieID];
    NSURL *URL2 = [NSURL URLWithString:path2];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:URL2];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request2 completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            //  NSLog(@"%@ %@", response, responseObject);
            row = (NSMutableDictionary *) responseObject;
            videos =[row objectForKey:@"videos"];
            results =[videos objectForKey:@"results"];
        }
    }];
    [dataTask resume];
    
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerCount) userInfo:nil
                                    repeats:NO ];
    

   
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    printf("hereee agaain \n ");
  //seslect from db chack favorite or not 

}

-(void)viewWillAppear:(BOOL)animated{
    [list removeAllObjects];
    list = db.displayData;
   
    for (movie *mo in list) {
        if([mo.movieID isEqual:_m.movieID])
        {
            [_markProp setSelectedSegmentIndex:1];
        }
    }
    
}

-(void)timerCount{
    [_tableTrailer reloadData ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)reviewAction:(id)sender {
    
     reviewMovieViewController *review=[self.storyboard instantiateViewControllerWithIdentifier:@"review"];
    
    [review setMovieID:_m.movieID];
    
    [self.navigationController pushViewController:review animated:YES];
 
    
}

- (IBAction)markAction:(UISegmentedControl *)sender {
    
    NSString *check=[sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    NSLog(@"\n check: %@",check);
    if ([check isEqualToString:@"yes"]) {
       
               [db addMovie:_m];
        
        [_saveProtocol save:_m];
        
        
    }
    else if ([check isEqualToString:@"no"]){
        [db removeMovie:_m];
       // [_saveProtocol remove:_m];
    
    }
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrailerCell" forIndexPath:indexPath];
    
    UILabel *txt=[cell viewWithTag:1];
    
    NSMutableDictionary *dict=[results objectAtIndex:indexPath.row];
    NSString * name=[dict valueForKey:@"type"];
  
    [txt setText:name];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 35;
}
/*
 
 
 id : "5794fffbc3a36829ab00056f"
 iso_639_1 : "en"
 iso_3166_1 : "US"
 key : "2LqzF5WauAw"
 name : "Interstellar Movie - Official Trailer"
 site : "YouTube"
 size : 1080
 type : "Trailer"
 
 */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *dict=[results objectAtIndex:indexPath.row];
    NSString *key=[dict valueForKey:@"key"];
    NSString *site=[dict valueForKey:@"site"];
    videoURL =[NSString stringWithFormat:@"https://www.%@.com/watch?v=%@",site,key];
    
  
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:videoURL]];

}
//

@end
