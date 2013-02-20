//
//  AyudaViewController.m
//  WomityApp
//
//  Created by Carlos Robinson on 11/25/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "AyudaViewController.h"
#import "ComentariosViewController.h"

@interface AyudaViewController ()

@end

@implementation AyudaViewController
@synthesize bandera;
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
    NSString *urlString = [NSString stringWithFormat:@"http://clientesim.com/ipad2/Womity/ayuda.html"];
    
    if(bandera)
        urlString = [NSString stringWithFormat:@"http://clientesim.com/ipad2/Womity/funcion.html"];
    NSURL *url2 = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url2];
    [mywebview loadRequest:request];

	// Do any additional setup after loading the view.
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [vistareloj setHidden:YES];
    [reloj stopAnimating];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)gotoweb:(id)sender
{
    
    NSURL *url = [ [ NSURL alloc ] initWithString: [NSString stringWithFormat:@"http://www.womity.com"]];
    NSLog(@"%@",url);
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)onButtonClick:(UIButton *)button {
	
    if (popoverController == nil){
        popoverController = [[popViewContainer alloc] initWithFrame:CGRectMake(90, 30, 239, 390)];
        popoverController.delegate = self;
        [self.view addSubview:popoverController];
    }else{
        [popoverController fadeOFFEmergency];
        [popoverController removeFromSuperview];
        popoverController = nil;
    }
    
}

- (void)popNavegar:(NSMutableDictionary *)womit{
    datawomitnew = womit;
    [self performSegueWithIdentifier:@"vercomentarios" sender:self];
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"vercomentarios"]){
        ComentariosViewController *controller = [segue destinationViewController];
        controller.datawomit = datawomitnew;
        controller.aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
        controller.comentar = YES;
        controller.idWomity = [datawomitnew objectForKey:@"idWomity"];
        
    }
}


- (void)viewDidUnload {
    mywebview = nil;
    vistareloj = nil;
    reloj = nil;
    [super viewDidUnload];
}
@end
