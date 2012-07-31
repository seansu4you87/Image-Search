//
//  ISSearchResult.m
//  Image Search
//
//  Created by Sean Yu on 7/29/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "ISSearchResult.h"

@implementation ISSearchResult

@synthesize imageId, title, url, thumbnailUrl, originalUrl;

- (void)dealloc
{
	[imageId release];
	[title release];
	[url release];
	[thumbnailUrl release];
	[originalUrl release];
	
	[super dealloc];
}

- (id)initWithContentsOfDictionary:(NSDictionary *)dictionary
{
	if (self = [super init])
	{
		self.imageId = [dictionary objectForKey:@"imageId"];
		self.title = [dictionary objectForKey:@"titleNoFormatting"];
		self.url = [NSURL URLWithString:[dictionary objectForKey:@"url"]];
		self.thumbnailUrl = [NSURL URLWithString:[dictionary objectForKey:@"tbUrl"]];
		self.originalUrl = [NSURL URLWithString:[dictionary objectForKey:@"originalContextUrl"]];
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@: %@, %@", [super description], self.title, [self.url absoluteString]];
}

@end
