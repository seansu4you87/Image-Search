//
//  ISImageTableViewController.m
//  Image Search
//
//  Created by Sean Yu on 7/29/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "ISResultsTableViewController.h"
#import "ISServer.h"

@interface ISResultsTableViewController ()
{
	NSArray *results;
}

- (void)getData;
- (void)gotData;

@end

@implementation ISResultsTableViewController

- (void)dealloc
{
	[results release];
	
	[super dealloc];
}

- (id)initWithQuery:(NSString *)query
{
    if (self = [super initWithStyle:UITableViewStylePlain])
	{
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

- (void)getData
{
	[ISServer imageSearchWithQuery:@"panda" success:^(id data){
		
		[results release];
		results = [data retain];
		[self gotData];
		
	} failure:^(NSError *error){
		
		[results release];
		results = nil;
		[self gotData];
		
	}];
}

- (void)gotData
{
	
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [[[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:@"i"] autorelease];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

@end
