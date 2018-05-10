//
//  DBManager.m
//  friendTable
//
//  Created by JETS on 5/5/18.
//  Copyright (c) 2018 JETS. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

+(DBManager *)sharedInstance{
    static DBManager* sharedInstance =nil;
    static dispatch_once_t oncePredicate;
    dispatch_once( &oncePredicate , ^{
        sharedInstance =[[DBManager alloc]init];
    });
    return sharedInstance;
}

-(void)createTable{
    NSString *docsDir;
    NSArray *dirPaths;
    _list=[NSMutableArray new];
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"contacts.db"]];
    
    
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt =
        "CREATE TABLE IF NOT EXISTS CONTACT (NAME TEXT, OVERVIEW TEXT, MOVIEID TEXT)";
        NSLog(@"creation");
        if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            NSLog(@"Failed to create table");
        }
        sqlite3_close(_contactDB);
    } else {
        NSLog(@"Failed to open/create database");
    }
    
}
-(NSMutableArray *) displayData{
    
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSLog(@"selection");
        NSString *querySQL =@"SELECT name, overview, movieid FROM contact";
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            NSLog(@"selection ok");
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *nameField = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *overviewField = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *movieIdField = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                 printf("name: %s overview:%s  id: %s \n",[nameField UTF8String],[overviewField UTF8String],[movieIdField UTF8String]);
                movie *m=[movie new];
                m.title=nameField;
                m.overview=overviewField;
                m.movieID=movieIdField;
                
                [_list addObject:m];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    
    
    return _list;

}

-(void)removeMovie:(movie*)u{
    
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    NSLog(@"delete %@",u);
            if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK) {
                NSLog(@"delete open");
                NSString *sql = [NSString stringWithFormat:@"delete from CONTACT where  movieid=\"%@\" ",u.movieID];
                
                const char *del_stmt = [sql UTF8String];
                
                sqlite3_prepare_v2(_contactDB, del_stmt, -1, & statement, NULL);
                if (sqlite3_step(statement) == SQLITE_DONE)
                    
                {
                    NSLog(@"delete done");
                    [_list removeObject:u];
                } else {
                    NSLog(@"delete failed");
                }
                sqlite3_finalize(statement);
                sqlite3_close(_contactDB);
                
                
            }
    
}

-(void)addMovie:(movie *)m{
   
    NSLog(@"save movie");
    
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSLog(@"open db");
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO CONTACT(name, overview, movieid) VALUES (\"%@\", \"%@\", \"%@\")",
                               m.title , m.overview, m.movieID];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt,
                           -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"movie add");
            
            //[_list addObject:u];
            //[self.tableView reloadData];
            
        } else {
            NSLog(@"Failed to add movie");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    
}


@end

