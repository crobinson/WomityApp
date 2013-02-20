//
//  TerminosViewController.h
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/29/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TerminosViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *comentariosview;
@property (strong, nonatomic) IBOutlet UIView *vistareloj;
@property (weak, nonatomic) IBOutlet UILabel *titulolabel;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *reloj;
- (IBAction)cancel:(id)sender;

@end
