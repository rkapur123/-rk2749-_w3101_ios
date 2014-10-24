//
//  NoteViewController.h
//  NotifyMe
//
//  Created by Rahul Kapur on 10/24/14.
//  Copyright (c) 2014 Rahul Kapur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import <MessageUI/MessageUI.h>

@interface NoteViewController : UIViewController <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, iCarouselDataSource, iCarouselDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *messageTitle;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UIButton *done;
- (IBAction)onClickDone:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (strong, nonatomic) IBOutlet UIButton *blueButton;
@property (strong, nonatomic) IBOutlet UIButton *greeButton;
@property (strong, nonatomic) IBOutlet UIButton *redButton;
@property (strong, nonatomic) IBOutlet UIButton *orangeButton;
@property (strong, nonatomic) IBOutlet UIButton *purpleButton;
- (IBAction)colorButtonClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *pencilButton;
@property (strong, nonatomic) IBOutlet UIButton *mailButton;
@property (strong, nonatomic) IBOutlet UIButton *pencilBar;
@property (strong, nonatomic) IBOutlet UIButton *mailBar;
- (IBAction)optionButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *mouseBar;

@property (strong, nonatomic) IBOutlet UIButton *mouseButton;
@property (strong, nonatomic) IBOutlet iCarousel *imageList;
- (IBAction)onClickSave:(id)sender;
@property (strong) NSManagedObject *dataBase;


@end
