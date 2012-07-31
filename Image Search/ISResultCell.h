//
//  ISResultCell.h
//  Image Search
//
//  Created by Sean Yu on 7/30/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISResultCell : UITableViewCell

- (id)initWithReuseIdentifier:(NSString *)reuse;
- (void)setImageUrls:(NSArray *)urls;

@end
