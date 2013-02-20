//
//  urlViewController.h
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 12/17/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class urlViewController;

@protocol urlViewControllerDelegate <NSObject>
- (void)urlAgregar:(NSString *)idamigo;
@end
@interface urlViewController : UIViewController<UITextFieldDelegate,UIWebViewDelegate>
@property (nonatomic, weak) id <urlViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *mytextfield;
@property (strong, nonatomic) IBOutlet UIWebView *mywebview;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *reloj;
-(IBAction)done:(id)sender;
-(IBAction)seleccionar:(id)sender;
@end
