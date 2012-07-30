//
//  GoogleAPI.m
//  Image Search
//
//  Created by Sean Yu on 7/29/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "ISServer.h"
#import "ISSearchResult.h"

#import "AFJSONRequestOperation.h"

@implementation ISServer

+ (void)imageSearchWithQuery:(NSString *)query success:(void (^)(id data))success failure:(void (^)(NSError *error))failure
{
	NSString *urlString = [NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=%@", query];
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request,NSHTTPURLResponse *response, id JSON) {
		NSArray *results = [[JSON objectForKey:@"responseData"] objectForKey:@"results"];
		NSMutableArray *data = [NSMutableArray array];
		for (NSDictionary *dictionary in results)
		{
			ISSearchResult *searchResult = [[ISSearchResult alloc] initWithContentsOfDictionary:dictionary];
			[data addObject:searchResult];
			[searchResult release];
		}
		success(data);
		
	} failure:^(NSURLRequest *request,NSHTTPURLResponse *response, NSError *error, id JSON) 
	{
		failure(error);
	}];
	[operation start];
}

@end
