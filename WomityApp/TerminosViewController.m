//
//  TerminosViewController.m
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/29/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "TerminosViewController.h"

@interface TerminosViewController ()

@end

@implementation TerminosViewController
@synthesize comentariosview, vistareloj, reloj, url;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [vistareloj setHidden:NO];
    [reloj startAnimating];
    NSString *urlString = [NSString stringWithFormat:@"http://www.womity.com/womity/privacityfp"];
    if(url!=NULL)
        urlString = url;
    NSURL *url2 = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url2];
    [comentariosview loadRequest:request];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [vistareloj setHidden:YES];
    [reloj stopAnimating];
}

- (IBAction)cancel:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

@end
