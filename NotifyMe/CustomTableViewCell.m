
//
//  CustomTableViewCell.m
//  NotifyMe
//
//  Created by Rahul Kapur on 10/24/14.
//  Copyright (c) 2014 Rahul Kapur. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell
@synthesize title, date, image;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) layoutSubviews {
    
    UIView* horizontalLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    UIView* horizontalLineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 70, 320, 1)];
    
    
    horizontalLineView.backgroundColor = [UIColor whiteColor];
    horizontalLineView2.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:horizontalLineView];
    [self.contentView addSubview:horizontalLineView2];

    
}


@end
