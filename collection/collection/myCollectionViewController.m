//
//  myCollectionViewController.m
//  collection
//
//  Created by JETS on 5/5/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import "myCollectionViewController.h"


@interface myCollectionViewController (){

    
    NSMutableDictionary *row;
    NSMutableArray *results;
    NSURLSessionConfiguration *configuration ;
    AFURLSessionManager *manager;
}

@end

@implementation myCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

   configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=457995803c8fb9ffacfe06327c23e535"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
           NSLog(@" %@", responseObject);
            row = (NSMutableDictionary *) responseObject;
            results=[row objectForKey:@"results"];
        }
    }];
    [dataTask resume];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerCount) userInfo:nil
                                    repeats:NO];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)timerCount{
    [self.collectionView reloadData ];
    printf("tim 1 \n");
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView  *img=[cell viewWithTag:1];
    
    NSMutableDictionary *dict=[results objectAtIndex:indexPath.row];;
    NSString * name=[dict valueForKey:@"poster_path"];
    NSString *path=[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w185/%@",name];
    [img sd_setImageWithURL:[NSURL URLWithString:path ]  placeholderImage:[UIImage imageNamed:@"face.png" ]];
   // NSLog(@"name :%@ path:%@",name,path);
  
    return cell;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return results.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    movieDetailsViewController *movieDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"movieDetails"];
    
    movie *m=[movie new];
    NSMutableDictionary *dict=[results objectAtIndex:indexPath.row];;
    NSString * name=[dict valueForKey:@"poster_path"];
    m.posterPath=name;
    NSString *vote_average=[NSString stringWithFormat:@"%1@", [dict valueForKey:@"vote_average"]];
    
    NSString *ID=[NSString stringWithFormat:@"%@", [dict valueForKey:@"id"]];
  
    NSString *titleM=[dict valueForKey:@"title"];
    NSString *overviewM=[dict valueForKey:@"overview"];
    m.vote=vote_average;
    m.movieID=ID;
    m.overview=overviewM;
    m.title=titleM;
    [movieDetails setM:m];
    [self.navigationController pushViewController:movieDetails animated:YES];

}
- (IBAction)moreAction:(id)sender {
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Movies" message:@"sort by: " preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *popularityAsc = [UIAlertAction actionWithTitle:@"popularity asc" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSURL *URL = [NSURL URLWithString:@"https://api.themoviedb.org/3/discover/movie?sort_by=popularity.asc&api_key=457995803c8fb9ffacfe06327c23e535"];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSLog(@"%@ %@", response, responseObject);
                row = (NSMutableDictionary *) responseObject;
                results=[row objectForKey:@"results"];
            }
        }];
        [dataTask resume];
        
        printf("popularity Asc is pressed\n");
        
    }];
    //release_date.desc  revenue.asc
    UIAlertAction *release_dateAsc = [UIAlertAction actionWithTitle:@"release date asc" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
       
        NSURL *URL = [NSURL URLWithString:@"https://api.themoviedb.org/3/discover/movie?sort_by=release_date.asc&api_key=457995803c8fb9ffacfe06327c23e535"];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSLog(@"%@ %@", response, responseObject);
                row = (NSMutableDictionary *) responseObject;
                results=[row objectForKey:@"results"];
            }
        }];
        [dataTask resume];
        printf("release_dateAsc is pressed\n");
    }];
    
    UIAlertAction *revenueAsc = [UIAlertAction actionWithTitle:@"revenue asc" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSURL *URL = [NSURL URLWithString:@"https://api.themoviedb.org/3/discover/movie?sort_by=revenue.asc&api_key=457995803c8fb9ffacfe06327c23e535"];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSLog(@"%@ %@", response, responseObject);
                row = (NSMutableDictionary *) responseObject;
                results=[row objectForKey:@"results"];
            }
        }];
        [dataTask resume];
        printf("rrevenueAsc is pressed\n");
    }];
    
    [alert addAction:popularityAsc];
    [alert addAction:release_dateAsc];
    [alert addAction:revenueAsc];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    

}
@end
