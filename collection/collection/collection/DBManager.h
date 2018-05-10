//
//  DBManager.h
//  friendTable
//
//  Created by JETS on 5/5/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "movie.h"

@interface DBManager : NSObject

+(DBManager*) sharedInstance;
-(void)createTable;
-(NSMutableArray *)displayData;

-(void)addMovie:(movie*)m;
-(void)removeMovie:(movie*)u;

@property (strong , nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;
@property NSMutableArray *list;

@end
