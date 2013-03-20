//
//  LoginViewController.h
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/13/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistrateViewController.h"
#import "recordarpswrdViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface LoginViewController : UIViewController <RegistrateViewControllerDelegate, recordarpswrdViewControllerDelegate, UITextFieldDelegate>{
    NSMutableData *responseData;
    NSString *databaseName;
	NSString *databasePath;
    NSString *aSesion;
    IBOutlet UIView *lineaolvidar;
    IBOutlet UIButton *olvidarbutton;
    IBOutlet UIImageView *imageview;
}
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *reloj;
@property (strong, nonatomic) IBOutlet UIView *vistareloj;
@property (nonatomic, retain) NSMutableData *responseData;
@property (weak, nonatomic) IBOutlet UITextField *paswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
- (IBAction)login:(id)sender;
- (IBAction)logout:(id)sender;
- (IBAction)verayudas:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *emailTextBackgroung;
@property (strong, nonatomic) IBOutlet UIView *passwordBackground;


@end
