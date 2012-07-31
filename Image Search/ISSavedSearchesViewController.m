//
//  ISSavedSearchesViewController.m
//  Image Search
//
//  Created by Sean Yu on 7/31/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "ISSavedSearchesViewController.h"
#import "ISSearchResultsViewController.h"

@interface ISSavedSearchesViewController ()
{
	NSArray *searches;
}

@end

@implementation ISSavedSearchesViewController

- (void)dealloc
{
	[searches release];
	
	[super dealloc];
}

- (id)initWithSavedSearches:(NSArray *)theSearches
{
	if (self = [super initWithStyle:UITableViewStylePlain])
	{
		searches = [theSearches retain];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [searches count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
	}
	
	cell.textLabel.text = [searches objectAtIndex:indexPath.row];

    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	ISSearchResultsViewController *resultsTVC = [[ISSearchResultsViewController alloc] initWithQuery:[searches objectAtIndex:indexPath.row]];
	[self.navigationController pushViewController:resultsTVC animated:YES];
	[resultsTVC release];
}

@end
