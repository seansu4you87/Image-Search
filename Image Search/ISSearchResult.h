//
//  ISSearchResult.h
//  Image Search
//
//  Created by Sean Yu on 7/29/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISSearchResult : NSObject
{
	NSString *imageId;
	NSString *title;
	
	NSURL *url;
	NSURL *thumbnailUrl;
	NSURL *originalUrl;
}

@property(nonatomic, retain) NSString *imageId, *title;
@property(nonatomic, retain) NSURL *url, *thumbnailUrl, *originalUrl;

- (id)initWithContentsOfDictionary:(NSDictionary *)dictionary;

@end
