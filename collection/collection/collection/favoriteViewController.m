//
//  favoriteViewController.m
//  
//
//  Created by ahme on 5/8/18.
//
//

#import "favoriteViewController.h"

@interface favoriteViewController (){

    DBManager *db;
  //  movieDetailsViewController *det;
}

@end

@implementation favoriteViewController

@synthesize list=_list;


- (void)viewDidLoad {
    [super viewDidLoad];
    [_favTable setDataSource:self];
    [_favTable setDelegate:self];
    
  //  det=[self.storyboard instantiateViewControllerWithIdentifier:@"movieDetails"];
   // [det setSaveProtocol:self];
    
    _list=[NSMutableArray new];
    db=[DBManager sharedInstance];
    [db createTable];
    _list = db.displayData;
    
    
    //list =[[NSMutableArray alloc]initWithCapacity:10];
  //  [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerCount) userInfo:nil
    //                                repeats:YES ];

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [_list removeAllObjects];
    _list = db.displayData;
    [_favTable reloadData ];

}

/*
-(void)timerCount{
    [_list removeAllObjects];
    _list = db.displayData;
    [_favTable reloadData ];
}
*/
 
-(void)save:(movie*)m{
    
    [_list addObject:m];
    [_favTable reloadData];
}

-(void)remove:(movie*)m1{
   
    [_list removeObject:m1];
    [_favTable reloadData];
    
}


- (void)didReceiveMemoryWarning {
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
    return _list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favCell" forIndexPath:indexPath];
    
    UILabel *txt=[cell viewWithTag:1];
    UITextView *txt2=[cell viewWithTag:2];
   
    
    [txt setText:[[_list objectAtIndex:indexPath.row] title]];
    [txt2 setText:[[_list objectAtIndex:indexPath.row] overview]];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NSLog(@"delete %@",[[_list objectAtIndex:indexPath.row] movieID]);
        switch (indexPath.section) {
            case 0:
                
                [db removeMovie:[_list objectAtIndex:indexPath.row]];
                
                break;
                
            default:
                break;
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
   
}



@end
