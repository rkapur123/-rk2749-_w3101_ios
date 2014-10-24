//
//  MainViewController.m
//  NotifyMe
//
//  Created by Rahul Kapur on 10/24/14.
//  Copyright (c) 2014 Rahul Kapur. All rights reserved.
//

#import "MainViewController.h"
#import "NoteViewController.h"
#import "CustomTableViewCell.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize dataArray, tableView;

-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.102 green:0.839 blue:0.992 alpha:1];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.tableView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.494 alpha:1] ;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *objectContext = [delegate managedObjectContext];
    NSFetchRequest *fetch = [[NSFetchRequest alloc] initWithEntityName:@"Note"];
    self.dataArray = [[objectContext executeFetchRequest:fetch error:nil] mutableCopy];
    [self.tableView reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    CustomTableViewCell *cell = (CustomTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
      }

    
    NSManagedObject *object = [self.dataArray objectAtIndex:indexPath.row];
    cell.title.text = [object valueForKey:@"title"];
    cell.date.text = [object valueForKey:@"date"];
    NSData *imageData = [object valueForKey:@"imageArray"];
    UIImage *image = [UIImage imageWithData:imageData];
    [cell.image setImage:image];
    cell.backgroundColor = [UIColor colorWithRed:0.529 green:0.988 blue:0.439 alpha:1];

    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSManagedObject *object = [self.dataArray objectAtIndex:indexPath.row];
    [context deleteObject:object];
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"openCell" sender:[self.tableView cellForRowAtIndexPath:indexPath]];

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"openCell"]) {
        NSIndexPath *indexPath= [self.tableView indexPathForSelectedRow];
        NSInteger objectNumber = [indexPath row];
        NSManagedObject *object = [self.dataArray objectAtIndex:objectNumber];
        NoteViewController *destViewController = segue.destinationViewController;
        destViewController.dataBase = object;
    } else {
        NoteViewController *destViewController = segue.destinationViewController;
    }
}

@end
