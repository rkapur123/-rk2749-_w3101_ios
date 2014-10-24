//
//  CustomTableViewCell.h
//  NotifyMe
//
//  Created by Rahul Kapur on 10/24/14.
//  Copyright (c) 2014 Rahul Kapur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UIImageView *image;

@end
