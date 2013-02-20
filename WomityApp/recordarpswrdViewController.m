//
//  recordarpswrdViewController.m
//  Womity
//
//  Created by Carlos Andres Robinson Lara on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "recordarpswrdViewController.h"

@implementation recordarpswrdViewController
@synthesize mailLabel, responseData;
@synthesize mailBackground;
@synthesize delegate;

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
     mailBackground.layer.cornerRadius = 8;
}


- (void)viewDidUnload
{
    [self setMailLabel:nil];
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

- (IBAction)cancel:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)recordar:(id)sender
{
    if([self.mailLabel.text isEqualToString:@""]){
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    
    }else{
        
    responseData = [NSMutableData data];  
    
    NSString *post = [NSString stringWithFormat:@"&email=%@", self.mailLabel.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/RecordarContrasena"]]];
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
    
	//[self.delegate recordarpswrdViewControllerRecordar:self];
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
    //  [self performSegueWithIdentifier:@"loguearse" sender:self];
}  

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {   
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions 
                          error:&error];
    
    NSLog(@"%@",json);
    
   /* if ([[json objectForKey:@"boolLogin"] isEqualToString:@"true"])
	{
        [self dismissModalViewControllerAnimated:YES];
    }else{
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"E-mail  o contraseña incorrecto" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }
    */
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Contraseña Enviada" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alerta show];
    [self dismissViewControllerAnimated:YES completion:nil];    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    responseData = [NSMutableData data];
    
    NSString *post = [NSString stringWithFormat:@"&email=%@", self.mailLabel.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/RecordarContrasena"]]];
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
    
    return YES;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Dismiss the keyboard when the view outside the text field is touched.
    [mailLabel resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([textField.placeholder isEqualToString:@"E-mail"])
    {
       
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.25];
            self.view.frame = CGRectMake(self.view.frame.origin.x,-195,self.view.frame.size.width,self.view.frame.size.height);
            [UIView commitAnimations];
   
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
      
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame = CGRectMake(self.view.frame.origin.x,20,self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
    
}


@end
