//
//  ISImageTableViewController.m
//  Image Search
//
//  Created by Sean Yu on 7/29/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "ISSearchResultsViewController.h"
#import "ISResultCell.h"
#import "ISSearchResult.h"
#import "ISServer.h"

@interface ISSearchResultsViewController ()
{
	NSString *query;
	NSMutableArray *results;
	NSMutableArray *formattedResults;
	
	int count;
}

@property(readonly) ISResultsViewControllerDataState dataState;

- (void)getData;
- (void)gotData;

@end

@implementation ISSearchResultsViewController

- (void)dealloc
{
	[query release];
	[results release];
	[formattedResults release];
	
	[super dealloc];
}

- (id)initWithQuery:(NSString *)queryString
{
    if (self = [super initWithStyle:UITableViewStylePlain])
	{
		query = [queryString retain];
		results = [[NSMutableArray alloc] init];
		formattedResults = [[NSMutableArray alloc] init];
		
		self.title = [NSString stringWithFormat:@"\"%@\"", query];
		[self getData];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (ISResultsViewControllerDataState)dataState
{
	if (formattedResults == nil)
		return ISResultsViewControllerDataStateNoResults;
	else if ([formattedResults count] > 0)
		return ISResultsViewControllerDataStateHasData;
	else
		return ISResultsViewControllerDataStateLoading;
}

- (void)getData
{
	[ISServer imageSearchWithQuery:query start:count success:^(id data){
		
		[results addObjectsFromArray:data];
		[self gotData];
		
	} failure:^(NSError *error){
		
	}];
}

- (void)gotData
{
	NSLog(@"results: %@", results);
	int oldCount = count;
	count = [results count];
	
	for (int i = oldCount; i < count; i++)
	{
		ISSearchResult *result = [results objectAtIndex:i];
		
		int index = floor(i / 3.0);
		if ([formattedResults count] <= index)
			[formattedResults addObject:[NSMutableArray array]];
		NSMutableArray *resultRow = [formattedResults objectAtIndex:index];
		[resultRow addObject:result];
	}
	
	[self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (self.dataState == ISResultsViewControllerDataStateHasData)
	{
		return [formattedResults count] + 1;
	}
	else
		return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (self.dataState == ISResultsViewControllerDataStateLoading)
	{
		NSString *reuse = @"loading";
		UITableViewCell *loadingCell = [tableView dequeueReusableCellWithIdentifier:reuse];
		if (loadingCell == nil)
			loadingCell = [[[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:@"loading"] autorelease];
		loadingCell.textLabel.text = @"Loading";
		return loadingCell;
	}
	else if (self.dataState == ISResultsViewControllerDataStateNoResults)
	{
		NSString *reuse = @"no results";
		UITableViewCell *noResultsCell = [tableView dequeueReusableCellWithIdentifier:reuse];
		if (noResultsCell == nil)
			noResultsCell = [[[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:@"no results"] autorelease];
		noResultsCell.textLabel.text = @"No Results";
		return noResultsCell;
	}
	else
	{
		if (indexPath.row < [formattedResults count])
		{
			NSString *reuse = @"result";
			ISResultCell *resultCell = [tableView dequeueReusableCellWithIdentifier:reuse];
			if (resultCell == nil)
				resultCell = [[[ISResultCell alloc] initWithReuseIdentifier:reuse] autorelease];
			
			NSMutableArray *urls = [NSMutableArray array];
			for (ISSearchResult *result in [formattedResults objectAtIndex:indexPath.row])
			{
				[urls addObject:result.url];
			}
			
			[resultCell setImageUrls:urls];
			return resultCell;
		}
		else
		{
			NSString *reuse = @"load more";
			UITableViewCell *loadMoreCell = [tableView dequeueReusableCellWithIdentifier:reuse];
			if (loadMoreCell == nil)
				loadMoreCell = [[[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:reuse] autorelease];
			loadMoreCell.textLabel.text = @"Load More Results...";
			return loadMoreCell;
		}
	}
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == [formattedResults count] && self.dataState == ISResultsViewControllerDataStateHasData)
	{
		[self getData];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 100;
}

@end
