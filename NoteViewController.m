//
//  NoteViewController.m
//  NotifyMe
//
//  Created by Rahul Kapur on 10/24/14.
//  Copyright (c) 2014 Rahul Kapur. All rights reserved.
//

#import "NoteViewController.h"


@interface NoteViewController () {
    UIImagePickerController *imagePicker;
    NSMutableArray *images;
}

@end

@implementation NoteViewController
@synthesize textView, messageTitle, containerView, done, barButton, blueButton, greeButton, redButton, purpleButton,orangeButton, pencilBar, pencilButton, mailBar, mailButton, mouseBar, mouseButton, imageList, dataBase;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    images = [[NSMutableArray alloc] initWithObjects: nil];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(onClickSave:)];
    self.navigationItem.rightBarButtonItem = button;
    
    if (self.dataBase != nil) {
        self.messageTitle.text = [self.dataBase valueForKey:@"title"];
        self.textView.text =[self.dataBase valueForKey:@"body"];
        NSData *imageData = [self.dataBase valueForKey:@"imageArray"];
        UIImage *image = [UIImage imageWithData:imageData];
        if(image!= nil) {
            [images addObject:image];
        }
        
        [self.imageList reloadData];

        //[self.imageList reloadData];
        /*NSData *data = [self.dataBase valueForKey:@"imageArray"];
        NSArray* array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        images = [[NSMutableArray alloc] initWithArray:array];
        [self.imageList reloadData]; */
    }
    
        
    imageList.vertical = NO;
    imageList.type = iCarouselTypeLinear;
    [imageList.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [imageList.layer setBorderWidth: 1.0];
    [imageList.layer setCornerRadius:8.0f];
    [imageList.layer setMasksToBounds:YES];
    
    [self.containerView.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [self.containerView.layer setBorderWidth: 1.0];
    [self.containerView.layer setCornerRadius:8.0f];
    [self.containerView.layer setMasksToBounds:YES];
    
    [self.messageTitle.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.messageTitle.layer setBorderWidth: 1.0];
    [self.messageTitle.layer setCornerRadius:8.0f];
    [self.messageTitle.layer setMasksToBounds:YES];
    
    
    self.done.hidden = YES;
    [self.done setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.done setBackgroundColor:[UIColor colorWithRed:0.529 green:0.988 blue:0.439 alpha:1]];
    

    
    self.orangeButton.backgroundColor =[UIColor orangeColor];
    self.redButton.backgroundColor =[UIColor redColor];
    self.purpleButton.backgroundColor =[UIColor purpleColor];
    self.greeButton.backgroundColor =[UIColor greenColor];
    self.blueButton.backgroundColor =[UIColor blueColor];
    
    
    self.mailBar.hidden = YES;
    self.mouseBar.hidden = YES;
    
    
    
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    
    [UIView transitionWithView:self.done
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    self.done.hidden = NO;
    
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    
    [UIView transitionWithView:self.done
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    self.done.hidden = YES;
    
    
}


- (IBAction)onClickDone:(id)sender {
    
    [self.textView resignFirstResponder];
}
- (IBAction)colorButtonClicked:(id)sender {
    
    
    
    
}
- (IBAction)optionButtonClicked:(id)sender {
    switch ([sender tag]) {
        case 1:
            self.pencilBar.hidden = NO;
            self.mailBar.hidden = YES;
            self.mouseBar.hidden = YES;
            
            break;
            
        case 2:
            self.pencilBar.hidden = YES;
            self.mailBar.hidden = NO;
            self.mouseBar.hidden = YES;
            if ([messageTitle.text isEqualToString:@""] || [textView.text  isEqualToString: @""]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Problem"
                                                                message:@"Either title or body is empty"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            } else {
                MFMailComposeViewController *mail = [[MFMailComposeViewController alloc]init];
                mail.mailComposeDelegate = self;
                [mail setSubject:messageTitle.text];
                [mail setMessageBody:textView.text isHTML:NO];
                if([images count] > 0) {
                    NSData *data = UIImageJPEGRepresentation([images objectAtIndex:0],1);
                    [mail addAttachmentData:data  mimeType:@"image/jpeg" fileName:@"Photograph.jpg"];
                }
                
                [self presentViewController:mail animated:YES completion:nil];

            }
        
            break;
            
        case 4:
            self.pencilBar.hidden = YES;
            self.mailBar.hidden = YES;
            self.mouseBar.hidden = NO;
            imagePicker  = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:NULL];
            
            
            
            break;
            
            
        default:
            
            break;
    }
    
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    self.pencilBar.hidden = NO;
    self.mailBar.hidden = YES;
    self.mouseBar.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [images addObject:image];
    [self.imageList reloadData];
    self.mailBar.hidden = YES;
    self.mouseBar.hidden = YES;
    self.pencilBar.hidden = NO;
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return [images count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    ((UIImageView *)view).image = [images objectAtIndex:index];
    view.contentMode = UIViewContentModeCenter;

    return view;
    
}


- (IBAction)onClickSave:(id)sender {
    
    NSData *imageData = [[NSData alloc] init];
    if([images count] != 0) {
        imageData = [NSData dataWithData:UIImagePNGRepresentation([images objectAtIndex:0])];
    }
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateStyle:NSDateFormatterMediumStyle];
    [format setTimeStyle:NSDateFormatterMediumStyle];
    NSString *date = [format stringFromDate:[NSDate date]];
    

    if (self.dataBase != nil) {
        [self.dataBase setValue:self.messageTitle.text forKey:@"title"];
        [self.dataBase setValue:self.textView.text forKey:@"body"];
        [self.dataBase setValue:date forKey:@"date"];
        if([images count] != 0) {
            [self.dataBase setValue:imageData forKey:@"imageArray"];
         }
        
    } else {
        id delegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *objectContext = [delegate managedObjectContext];
        NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:objectContext];
        [object setValue:self.messageTitle.text forKey:@"title"];
        [object setValue:self.textView.text forKey:@"body"];
        [object setValue:date forKey:@"date"];
        if([images count] != 0) {
           [object setValue:imageData forKey:@"imageArray"];
        }
        

    }
    
    [[self navigationController] popViewControllerAnimated:YES];

    
    
}




@end
