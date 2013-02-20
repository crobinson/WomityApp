//
//  recordarpswrdViewController.h
//  Womity
//
//  Created by Carlos Andres Robinson Lara on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class recordarpswrdViewController;

@protocol recordarpswrdViewControllerDelegate <NSObject>
- (void)recordarpswrdViewControllerDidCancel:
(recordarpswrdViewController *)controller;
- (void)recordarpswrdViewControllerRecordar:
(recordarpswrdViewController *)controller;
@end

@interface recordarpswrdViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *mailLabel;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, weak) id <recordarpswrdViewControllerDelegate> delegate;
- (IBAction)cancel:(id)sender;
- (IBAction)recordar:(id)sender;

@end
