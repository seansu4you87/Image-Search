//
//  ISViewController.m
//  Image Search
//
//  Created by Sean Yu on 7/29/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "ISSearchViewController.h"
#import "ISSearchResultsViewController.h"

@interface ISSearchViewController ()
{
	UITextField *searchTextField;
	UIButton *searchButton;
	
	CGFloat xMargin, yMargin;
}

- (void)pushResultsViewController;

- (UITextField *)makeSearchTextField;
- (UIButton *)makeSearchButton;

- (CGRect)frameForSearchTextField;
- (CGRect)frameForSearchButton;

@end

@implementation ISSearchViewController

- (void)dealloc
{
	[searchTextField release];
	[searchButton release];
	
	[super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder])
	{
		self.title = @"Image Search";
		xMargin = 10;
		yMargin = 10;
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	searchTextField = [[self makeSearchTextField] retain];
	searchButton = [[self makeSearchButton] retain];
	
	[self.view addSubview:searchTextField];
	[self.view addSubview:searchButton];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
	[searchTextField release];
	searchTextField = nil;
	
	[searchButton release];
	searchButton = nil;
}

- (void)pushResultsViewController
{
	ISSearchResultsViewController *resultsTVC = [[ISSearchResultsViewController alloc] initWithQuery:searchTextField.text];
	[self.navigationController pushViewController:resultsTVC animated:YES];
	[resultsTVC release];
}


#pragma mark - View Configuration

- (UITextField *)makeSearchTextField
{
	UITextField *textField = [[UITextField alloc] initWithFrame:[self frameForSearchTextField]];
	textField.borderStyle = UITextBorderStyleRoundedRect;
	textField.delegate = self;
	textField.text = @"panda";
	
	return [textField autorelease];
}

- (UIButton *)makeSearchButton
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	button.frame = [self frameForSearchButton];
	[button setTitle:@"Search" forState:UIControlStateNormal];
	[button addTarget:self action:@selector(pushResultsViewController) forControlEvents:UIControlEventTouchUpInside];
	return button;
}

#pragma mark - Frame Sizing

- (CGRect)frameForSearchTextField
{
	return CGRectMake(xMargin, yMargin, self.view.frame.size.width - 2 * xMargin, 25);
}

- (CGRect)frameForSearchButton
{
	CGRect textFieldFrame = [self frameForSearchTextField];
	return CGRectMake(xMargin, CGRectGetMaxY(textFieldFrame) + yMargin, self.view.frame.size.width - 2 * xMargin, 44);
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self pushResultsViewController];
	return YES;
}

@end
