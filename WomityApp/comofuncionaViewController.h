//
//  comofuncionaViewController.h
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 12/3/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popViewContainer.h"

@interface comofuncionaViewController : UIViewController<popViewControllerDelegate, UIWebViewDelegate>
{
    NSMutableDictionary *datawomitnew;
    IBOutlet UIWebView *mywebview;
    popViewContainer *popoverController;
    IBOutlet UIView *vistareloj;
    IBOutlet UIActivityIndicatorView *reloj;
}
- (IBAction)cancel:(id)sender;
-(IBAction)gotoweb:(id)sender;


@end
