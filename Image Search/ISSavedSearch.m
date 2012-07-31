//
//  ISSavedSearch.m
//  Image Search
//
//  Created by Sean Yu on 7/31/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "ISSavedSearch.h"

@interface ISSavedSearch ()

+ (NSString *)plistPath;

@end

@implementation ISSavedSearch

+ (NSString *)plistPath
{
	NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *plistPath = [rootPath stringByAppendingPathComponent:@"savedSearches.plist"];
	return plistPath;
}

+ (NSArray *)savedSearches
{	
	return [NSArray arrayWithContentsOfFile:[ISSavedSearch plistPath]];
}

+ (void)saveSearchQuery:(NSString *)query
{
	NSMutableArray *savedSearches = [NSMutableArray arrayWithArray:[ISSavedSearch savedSearches]];
	[savedSearches addObject:query];
	
	[savedSearches writeToFile:[ISSavedSearch plistPath] atomically:YES];
}

@end
