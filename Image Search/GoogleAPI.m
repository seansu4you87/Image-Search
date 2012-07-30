//
//  GoogleAPI.m
//  Image Search
//
//  Created by Sean Yu on 7/29/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "GoogleAPI.h"
#import "AFJSONRequestOperation.h"

@implementation GoogleAPI

+ (void)imageSearchWithQuery:(NSString *)query
{
	NSString *urlString = [NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=%@", query];
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request,NSHTTPURLResponse *response, id JSON) {
		NSLog(@"%@", JSON);
		NSDictionary *results = [NSDictionary dictionaryWithDictionary:JSON];
		
	} failure:^(NSURLRequest *request,NSHTTPURLResponse *response, NSError *error, id JSON) 
	{
		NSLog(@"error");
	}];
	[operation start];
}

@end
