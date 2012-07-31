//
//  ISImageTableViewController.h
//  Image Search
//
//  Created by Sean Yu on 7/29/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	ISResultsViewControllerDataStateLoading,
	ISResultsViewControllerDataStateNoResults,
	ISResultsViewControllerDataStateHasData
} ISResultsViewControllerDataState;

@interface ISResultsViewController : UITableViewController

- (id)initWithQuery:(NSString *)queryString;

@end
