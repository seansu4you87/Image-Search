//
//  ISResultCell.m
//  Image Search
//
//  Created by Sean Yu on 7/30/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import "ISResultCell.h"
#import "UIImageView+AFNetworking.h"

@interface ISResultCell ()
{
	UIImageView *imageView1, *imageView2, *imageView3;
	CGFloat xMargin, yMargin;
}

- (void)initializeImageViews;

@end

@implementation ISResultCell

- (void)dealloc
{
	[imageView1 release];
	[imageView2 release];
	[imageView3 release];
	
	[super dealloc];
}

- (id)initWithReuseIdentifier:(NSString *)reuse
{
	if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse])
	{
		xMargin = 10;
		yMargin = 10;
		
		[self initializeImageViews];
		self.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	return self;
}

- (void)setImageUrls:(NSArray *)urls
{
	if ([urls count] >= 1)
		[imageView1 setImageWithURL:[urls objectAtIndex:0] placeholderImage:[UIImage imageNamed:@"loading.png"]];
	
	if ([urls count] >= 2)
		[imageView2 setImageWithURL:[urls objectAtIndex:1] placeholderImage:[UIImage imageNamed:@"loading.png"]];
	
	if ([urls count] >= 3)
		[imageView3 setImageWithURL:[urls objectAtIndex:2] placeholderImage:[UIImage imageNamed:@"loading.png"]];
	
}

- (void)initializeImageViews
{
	[imageView1 release];
	[imageView2 release];
	[imageView3 release];
	
	imageView1 = [[UIImageView alloc] initWithFrame:CGRectZero];
	imageView2 = [[UIImageView alloc] initWithFrame:CGRectZero];
	imageView3 = [[UIImageView alloc] initWithFrame:CGRectZero];
	
	[self.contentView addSubview:imageView1];
	[self.contentView addSubview:imageView2];
	[self.contentView addSubview:imageView3];	
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGFloat width = (self.frame.size.width - 4 * xMargin) / 3.0;
	CGFloat height = self.frame.size.height - 2 * yMargin;
	imageView1.frame = CGRectMake(xMargin, yMargin, width, height);
	imageView2.frame = CGRectMake(CGRectGetMaxX(imageView1.frame) + xMargin, yMargin, width, height);
	imageView3.frame = CGRectMake(CGRectGetMaxX(imageView2.frame) + xMargin, yMargin, width, height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
