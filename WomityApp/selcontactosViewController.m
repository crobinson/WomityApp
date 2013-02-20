//
//  selcontactosViewController.m
//  Womity
//
//  Created by Carlos Andres Robinson Lara on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "selcontactosViewController.h"
#import "popViewContainer.h"

@implementation selcontactosViewController
@synthesize mensajeText, idWomit, aSesion, contactos, otros, mensaje;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",mensaje);
    NSLog(@"%@", aSesion);
    NSLog(@"%@",otros);
    NSLog(@"%@",idWomit);
}


- (void)viewDidUnload
{
    [self setMensajeText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

-(IBAction)enviar:(id)sender
{
    responseData = [NSMutableData data];
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&idWomity=%@&Contactos=%@&OtrosContactos=%@",aSesion, idWomit, otros, otros];
    NSLog(@"%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/InvitarWomityYEnviar"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if(conn)
    {
        NSLog(@"Connection Successful");
    }
    else
    {
        NSLog(@"Connection could not be made");
    }

}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {  
    [responseData setLength:0];  
}  

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {  
    [responseData appendData:data];  
}  

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {  
    //label.text = [NSString stringWithFormat:@"Connection failed: %@", [error description]];
    NSLog(@"Connection failed: %@", [error description]);
    
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"No hemos logrado conectarnos con el servidor. Revisa tu conexión" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alerta show];
    
    //[self performSegueWithIdentifier:@"loguearse" sender:self];
}  

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {   
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions 
                          error:&error];
    
    NSLog(@"%@",json);
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:[json objectForKey:@"strMensaje"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alerta show];
   // [self performSegueWithIdentifier:@"actualizado" sender:self];
}

- (IBAction)onButtonClick:(UIButton *)button {
	
    if (popoverController == nil){
        popoverController = [[popViewContainer alloc] initWithFrame:CGRectMake(90, 30, 239, 390)];
        [self.view addSubview:popoverController];
    }else{
        [popoverController fadeOFFEmergency];
        [popoverController removeFromSuperview];
        popoverController = nil;
    }
    
}

@end
