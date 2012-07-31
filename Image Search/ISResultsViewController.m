//
//  ISImageTableViewController.m
//  Image Search
//
//  Created by Sean Yu on 7/29/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "ISResultsViewController.h"
#import "ISResultCell.h"
#import "ISServer.h"

@interface ISResultsViewController ()
{
	NSString *query;
	NSArray *results;
}

@property(readonly) ISResultsViewControllerDataState dataState;

- (void)getData;
- (void)gotData;

@end

@implementation ISResultsViewController

- (void)dealloc
{
	[query release];
	[results release];
	
	[super dealloc];
}

- (id)initWithQuery:(NSString *)queryString
{
    if (self = [super initWithStyle:UITableViewStylePlain])
	{
		query = [queryString retain];
		
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
	if (results == nil)
		return ISResultsViewControllerDataStateLoading;
	else if ([results count] > 0)
		return ISResultsViewControllerDataStateHasData;
	else {
		return ISResultsViewControllerDataStateNoResults;
	}
}

- (void)getData
{
	[ISServer imageSearchWithQuery:query success:^(id data){
		
		[results release];
		results = [data retain];
		[self gotData];
		
	} failure:^(NSError *error){
		
		[results release];
		results = [NSArray array];
		[self gotData];
		
	}];
}

- (void)gotData
{
	NSLog(@"results: %@", results);
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
		return ceil([results count] / 3.0);
	}
	else
		return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (self.dataState == ISResultsViewControllerDataStateLoading)
	{
		UITableViewCell *loadingCell = [[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:@"i"];
		loadingCell.textLabel.text = @"Loading";
		return [loadingCell autorelease];
	}
	else if (self.dataState == ISResultsViewControllerDataStateNoResults)
	{
		UITableViewCell *noResultsCell = [[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:@"i"];
		noResultsCell.textLabel.text = @"No Results";
		return [noResultsCell autorelease];
	}
	else
	{
		ISResultCell *resultCell = [[ISResultCell alloc] initWithReuseIdentifier:@"i"];
		
		
		
		[resultCell setImageUrls:urls];
		return [resultCell autorelease];
	}
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 100;
}

@end
