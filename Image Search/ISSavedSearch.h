//
//  ISSavedSearch.h
//  Image Search
//
//  Created by Sean Yu on 7/31/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISSavedSearch : NSObject

+ (NSArray *)savedSearches;
+ (void)saveSearchQuery:(NSString *)query;

@end
