//
//  urlViewController.m
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 12/17/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "urlViewController.h"

@interface urlViewController ()

@end

@implementation urlViewController
@synthesize mytextfield, mywebview,reloj;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [reloj startAnimating];
    [reloj setHidden:NO];
    [textField resignFirstResponder];
    
    NSString *urlString = [NSString stringWithFormat:@"http://%@",mytextfield.text];
    
    
    NSURL *url2 = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url2];
    [mywebview loadRequest:request];
    
    return YES;
}

-(IBAction)done:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [reloj stopAnimating];
    [reloj setHidden:YES];
    
}

- (void)viewDidUnload {
    [self setMywebview:nil];
    [self setMytextfield:nil];
    [self setReloj:nil];
    [super viewDidUnload];
}

-(IBAction)seleccionar:(id)sender{
    [self.delegate urlAgregar:mytextfield.text];
}
@end
