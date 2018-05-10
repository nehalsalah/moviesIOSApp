//
//  movieFavProtocol.h
//  collection
//
//  Created by ahme on 5/9/18.
//  Copyright © 2018 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "movie.h"

@protocol movieFavProtocol <NSObject>

-(void) save:(movie*) m;
-(void)remove:(movie*) m1;


@end
