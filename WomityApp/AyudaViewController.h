//
//  AyudaViewController.h
//  WomityApp
//
//  Created by Carlos Robinson on 11/25/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popViewContainer.h"
@class popViewContainer;


@interface AyudaViewController : UIViewController<popViewControllerDelegate, UIWebViewDelegate>
{
    NSMutableDictionary *datawomitnew;
    IBOutlet UIWebView *mywebview;
    popViewContainer *popoverController;
    IBOutlet UIView *vistareloj;
    IBOutlet UIActivityIndicatorView *reloj;
}
@property(nonatomic, assign) BOOL bandera;
- (IBAction)cancel:(id)sender;
-(IBAction)gotoweb:(id)sender;
@end
