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
@synthesize paswordTextField, emailTextField, responseData, reloj, vistareloj,emailTextBackgroung,passwordBackground;

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
    [reloj stopAnimating];
    [reloj setHidden:YES];
	// Do any additional setup after loading the view.
    emailTextBackgroung.layer.cornerRadius = 8;
    passwordBackground.layer.cornerRadius = 8;
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
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Usuario o contraseña inválidos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }else{
    
        [reloj startAnimating];
        [reloj setHidden:NO];
    
    
    responseData = [NSMutableData data];
    
    NSString *post = [NSString stringWithFormat:@"&email=%@&contrasena=%@&deviceToken=%@",self.emailTextField.text, self.paswordTextField.text,[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"]];
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
    
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"No hemos logrado conectarnos con el servidor. Revisa tu conexión" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alerta show];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    //{"boolLogin":"true","strMensaje":"loginOk","idSession":"2136418ad3534c6dae8e6dc6a9b59732"}
    
    [[NSUserDefaults standardUserDefaults] setValue:[json objectForKey:@"idSession"] forKey:@"id"];

    NSLog(@"%@",json);
  
    [reloj stopAnimating];
    [reloj setHidden:YES];
        if ([[json objectForKey:@"boolLogin"] isEqualToString:@"true"])
	{
        //[self dismissModalViewControllerAnimated:YES];
        [self performSegueWithIdentifier:@"logueado" sender:self];
        [[NSUserDefaults standardUserDefaults] setValue:[json objectForKey:@"Nombre"] forKey:@"NombreUsuario"];
    }else{
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"E-mail  o contraseña incorrecto" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if([textField.placeholder isEqualToString:@"Contraseña"] && ![emailTextField.text isEqualToString:@""])
    {
        
        [reloj startAnimating];
        [reloj setHidden:NO];
        
        responseData = [NSMutableData data];
        
        NSString *post = [NSString stringWithFormat:@"&email=%@&contrasena=%@&deviceToken=%@",self.emailTextField.text, self.paswordTextField.text,[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"]];
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
    
    if([emailTextField.text isEqualToString:@""])
    {
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Debes colocar tu email." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }
    
    if([paswordTextField.text isEqualToString:@""] && textField == paswordTextField){
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Debes colocar tu contraseña." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }
    
    if(textField == emailTextField){
        [paswordTextField becomeFirstResponder];
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
    
    if(textField == paswordTextField){
        textField.secureTextEntry = YES;
    }
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


- (IBAction)verayudas:(id)sender
{
    NSURL *url = [ [ NSURL alloc ] initWithString: [NSString stringWithFormat:@"http://www.womity.com/womity/help"]];
    NSLog(@"%@",url);
    [[UIApplication sharedApplication] openURL:url];
}



@end
