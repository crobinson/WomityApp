//
//  emailComposerViewController.h
//  WomityApp
//
//  Created by Eduardo Rodriguez Macmini on 11/27/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "popViewContainer.h"

@class popViewContainer;

@interface emailComposerViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate, UITabBarControllerDelegate, popViewControllerDelegate>{
    
    NSMutableData *responseData;
    IBOutlet UIView *commentView;
    IBOutlet UIView *emailView;
    IBOutlet UITextView *commnetTextView;
    IBOutlet UITextView *emailTextView;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIButton *btn;
    IBOutlet UIView *vistareloj;
    popViewContainer *popoverController;
    IBOutlet UIActivityIndicatorView *reloj;
    NSMutableDictionary *datawomitnew;
    UITapGestureRecognizer *tapScroll;
    
}
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *reloj;
@property (strong, nonatomic) IBOutlet UIView *vistareloj;
@property (strong, nonatomic) NSString *aSesion;
@property (strong, nonatomic) NSString *otrosamigos;
- (IBAction)Done:(id)sender;
- (IBAction)onButtonClick:(UIButton *)button;
-(IBAction)enviar:(id)sender;

@end
