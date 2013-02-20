//
//  RegistrateViewController.m
//  Womity
//
//  Created by Carlos Andres Robinson Lara on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RegistrateViewController.h"

@implementation RegistrateViewController

@synthesize delegate;
@synthesize nombreLabel;
@synthesize apellidoLabel;
@synthesize emailLabel;
@synthesize email2Label;
@synthesize contrasenaLabel;
@synthesize vistaPicker;
@synthesize pickerView;
@synthesize vistaPicker2;
@synthesize pickerView2;
@synthesize sexoLabel;
@synthesize fecnacLabel;
@synthesize oickerView2;
@synthesize pickerFecha;
@synthesize responseData;

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
    
    //Looks like IB setting for default date no longer works here. Set programatically, as you suggested. Thanks!: 
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
    [myFormatter setDateFormat:@"dd/MM/yyyy"]; 
    NSDate *minDate = [myFormatter dateFromString:@"01/01/1912"]; 
    [pickerFecha setMinimumDate:minDate]; 
    //NSDate *maxDate = [myFormatter dateFromString:@"January/01/2000"]; [pickerFecha setMaximumDate:maxDate]; 
    //NSDate *initialDate = [myFormatter dateFromString:@"January/01/1950"]; [pickerFecha setDate:initialDate animated:YES];
    
    nombreLabel.clearButtonMode = UITextFieldViewModeWhileEditing;
    apellidoLabel.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailLabel.clearButtonMode = UITextFieldViewModeWhileEditing;
    email2Label.clearButtonMode = UITextFieldViewModeWhileEditing;
    contrasenaLabel.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    pickerView.showsSelectionIndicator = YES;
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarPicker)];
    
    [pickerView addGestureRecognizer:doubleTap];
    
    pickerView2.showsSelectionIndicator = YES;
    UITapGestureRecognizer *doubleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarPicker)];
    
    [pickerView2 addGestureRecognizer:doubleTap2];
    
    UITapGestureRecognizer *doubleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarPicker2)];
    [pickerFecha addGestureRecognizer:doubleTap3];
    
    arraySexo = [[NSMutableArray alloc] init];
    [arraySexo addObject:@"Seleccione"];
    [arraySexo addObject:@"Masculino"];
    [arraySexo addObject:@"Femenino"];
        
    arrayFecha = [[NSMutableArray alloc] init];
    [arrayFecha addObject:@"Seleccione"];
    for(int i=0;i< 24; i++){
    	NSString *hora = [NSString stringWithFormat:@"%d",i];
        [arrayFecha addObject:hora];
    }

    
}


- (void)viewDidUnload
{
    [self setNombreLabel:nil];
    [self setApellidoLabel:nil];
    [self setEmailLabel:nil];
    [self setEmail2Label:nil];
    [self setContrasenaLabel:nil];
    [self setVistaPicker:nil];
    [self setPickerView:nil];
    [self setPickerView2:nil];
    [self setSexoLabel:nil];
    [self setFecnacLabel:nil];
    [self setPickerFecha:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)mostrarPicker:(id)sender{
    [nombreLabel resignFirstResponder];
    [emailLabel resignFirstResponder];
    [apellidoLabel resignFirstResponder];
    [email2Label resignFirstResponder];
    [contrasenaLabel resignFirstResponder];
    //NSLog(@"mostrar picker");
    //pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    //[self.view addSubview:pickerView];
    //[self.view bringSubviewToFront:vistaPicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistaPicker setFrame:CGRectMake(0,self.view.frame.size.height - 257,self.view.frame.size.width,257)];
    
    [UIView commitAnimations];
    
}

- (IBAction)mostrarPicker2:(id)sender{
    [nombreLabel resignFirstResponder];
    [emailLabel resignFirstResponder];
    [apellidoLabel resignFirstResponder];
    [email2Label resignFirstResponder];
    [contrasenaLabel resignFirstResponder];
    //NSLog(@"mostrar picker");
    //pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    //[self.view addSubview:pickerView];
    //[self.view bringSubviewToFront:vistaPicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistaPicker2 setFrame:CGRectMake(0,self.view.frame.size.height - 257,self.view.frame.size.width,257)];
    
    [UIView commitAnimations];
    
}


- (void)quitarPicker{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [vistaPicker setFrame:CGRectMake(0,self.view.frame.size.height,self.view.frame.size.width,257)];
    [vistaPicker2 setFrame:CGRectMake(0,self.view.frame.size.height,self.view.frame.size.width,257)];
    [UIView commitAnimations];
}

- (IBAction)quitarPickerDone:(id)sender
{
    [self quitarPicker];
}

- (void)quitarPicker2{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [vistaPicker setFrame:CGRectMake(0,self.view.frame.size.height,self.view.frame.size.width,257)];
    [vistaPicker2 setFrame:CGRectMake(0,self.view.frame.size.height,self.view.frame.size.width,257)];
    [UIView commitAnimations];
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
    [myFormatter setDateFormat:@"dd/MM/yyyy"]; 
    NSString *date = [myFormatter stringFromDate:[pickerFecha date]];
    
    fecnacLabel.text = date;
}

- (IBAction)quitarPickerDone2:(id)sender
{
    [self quitarPicker2];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    orientacion = interfaceOrientation;
    return YES;
}

- (IBAction)cancel:(id)sender
{
	[self.delegate RegistrateViewControllerDidCancel:self];
}
- (IBAction)registrarse:(id)sender
{
	//[self.delegate RegistrateViewControllerRegistrarse:self];
    /*  $nombre = $request->getParameter('nombre');
     $apellidos = $request->getParameter('apellido');
     $email = $request->getParameter('email');
     $passwd = $request->getParameter('contrasena');
     $sexoL = $request->getParameter('sexo');
     $fecnac = $request->getParameter('fecnac');
     $result = '';
*/
    responseData = [NSMutableData data];
    NSString *sexoletra = [fecnacLabel.text substringToIndex:1];
    NSString *post = [NSString stringWithFormat:@"&nombre=%@&apellido=%@&email=%@&contrasena=%@&sexo=%@&fecnac=%@",nombreLabel.text, apellidoLabel.text, emailLabel.text, contrasenaLabel.text, sexoletra, fecnacLabel.text];
    NSLog(@"%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/registrar"]]];
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
    
    NSLog(@"%@",json);
    
    if ([[json objectForKey:@"boolRegistro"] isEqualToString:@"true"])
	{
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atencion" message:@"Registro Exitoso" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }else{
        
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atencion" message:@"No hemos logrado registrarte. Revisa los campos, es posible que el correo ya esté inscrito" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }
    
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
        return [arraySexo count];
    
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
        return [arraySexo objectAtIndex:row];
    
   
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if(thePickerView == pickerView){
        sexoLabel.text = [arraySexo objectAtIndex:row];
    }else{
        NSLog(@"%@",thePickerView);
    }
        
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    if([textField.placeholder isEqualToString:@"contraseña"])
    {
        responseData = [NSMutableData data];
        NSString *sexoletra = [fecnacLabel.text substringToIndex:1];
        NSString *post = [NSString stringWithFormat:@"&nombre=%@&apellido=%@&email=%@&contrasena=%@&sexo=%@&fecnac=%@",nombreLabel.text, apellidoLabel.text, emailLabel.text, contrasenaLabel.text, sexoletra, fecnacLabel.text];
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
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Dismiss the keyboard when the view outside the text field is touched.
    [nombreLabel resignFirstResponder];
    [emailLabel resignFirstResponder];
    [apellidoLabel resignFirstResponder];
    [email2Label resignFirstResponder];
    [contrasenaLabel resignFirstResponder];
    // Revert the text field to the previous value.
    //palabra.text = self.string; 
    [super touchesBegan:touches withEvent:event];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField 
{    
    if([textField.placeholder isEqualToString:@"contraseña"])
    {
        if(self.view.frame.size.width == 320){

            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.25];
            self.view.frame = CGRectMake(0,-200,320,400);
            [UIView commitAnimations];
        }
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
    if(self.view.frame.size.width == 320){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame = CGRectMake(0,0,320,400);
        [UIView commitAnimations];
    }
    if([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame = CGRectMake(self.view.frame.origin.x,0,self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
    }
}





@end
