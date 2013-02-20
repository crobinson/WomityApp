//
//  LoginViewController.m
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/13/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize paswordTextField, emailTextField, responseData, reloj, vistareloj;

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

- (void)viewDidUnload
{
    [self setEmailTextField:nil];
    [self setPaswordTextField:nil];
    [self setVistareloj:nil];
    [self setReloj:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)login:(id)sender
{
    
    if([emailTextField.text isEqualToString:@""] || [paswordTextField.text isEqualToString:@""])
    {
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Debes llenar ambos campos." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }else{
    
        [reloj startAnimating];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistareloj setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    [UIView commitAnimations];
    
    
    responseData = [NSMutableData data];
    
    NSString *post = [NSString stringWithFormat:@"&email=%@&contrasena=%@",self.emailTextField.text, self.paswordTextField.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/login"]]];
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
    
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atencion" message:@"No hemos logrado conectarnos con el servidor. Revisa tu conexión" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alerta show];
    [self performSegueWithIdentifier:@"loguearse" sender:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    //{"boolLogin":"true","strMensaje":"loginOk","idSession":"2136418ad3534c6dae8e6dc6a9b59732"}
    
    [[NSUserDefaults standardUserDefaults] setValue:[json objectForKey:@"idSession"] forKey:@"id"];

    
    
    NSLog(@"%@",[json objectForKey:@"boolLogin"]);
    NSLog(@"%@",[json objectForKey:@"idSession"]);
    [reloj stopAnimating];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistareloj setFrame:CGRectMake(0,480,320,416)];
    [UIView commitAnimations];
    if ([[json objectForKey:@"boolLogin"] isEqualToString:@"true"])
	{
        [self dismissModalViewControllerAnimated:YES];
    }else{
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Error de ingreso. Revisa tus datos." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if([textField.placeholder isEqualToString:@"Contraseña"] && ![emailTextField.text isEqualToString:@""])
    {
        
        [reloj startAnimating];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        [UIView setAnimationDelegate:self];
        
        //self.navigationController.view
        [vistareloj setFrame:CGRectMake(0,0,320,416)];
        [UIView commitAnimations];
        
        responseData = [NSMutableData data];
        
        NSString *post = [NSString stringWithFormat:@"&email=%@&contrasena=%@",self.emailTextField.text, self.paswordTextField.text];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/login"]]];
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
    
    if([emailTextField.text isEqualToString:@""] || [paswordTextField.text isEqualToString:@""])
    {
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Debes llenar ambos campos." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Dismiss the keyboard when the view outside the text field is touched.
    [paswordTextField resignFirstResponder];
    [emailTextField resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([textField.placeholder isEqualToString:@"contraseña"])
    {
        if([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.25];
            self.view.frame = CGRectMake(self.view.frame.origin.x,-200,self.view.frame.size.width,self.view.frame.size.height);
            [UIView commitAnimations];
        }
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame = CGRectMake(self.view.frame.origin.x,0,self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
    }
}




@end
