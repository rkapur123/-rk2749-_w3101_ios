//
//  MainViewController.h
//  NotifyMe
//
//  Created by Rahul Kapur on 10/24/14.
//  Copyright (c) 2014 Rahul Kapur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong) NSMutableArray *dataArray;
@end
