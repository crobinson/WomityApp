//
//  RegistrateViewController.m
//  Womity
//
//  Created by Carlos Andres Robinson Lara on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RegistrateViewController.h"
#import <QuartzCore/QuartzCore.h>

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
@synthesize responseData, myScrollView, fotoopcion,sexoCampo, fechacampo;

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
    [reloj setHidden:YES];
    vista1.layer.cornerRadius = 10;
    vista2.layer.cornerRadius = 10;
    vista3.layer.cornerRadius = 10;
    vista4.layer.cornerRadius = 10;
    vista5.layer.cornerRadius = 10;
    vista6.layer.cornerRadius = 10;
    vista7.layer.cornerRadius = 10;
    
    myScrollView.contentSize = CGSizeMake(0, 600);
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
    UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapGestureRecognized:)];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    [pickerView addGestureRecognizer:gestureRecognizer];
    
    /*UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarPicker)];
     
     [pickerView addGestureRecognizer:doubleTap];*/
    
    
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarTeclado)];
    
    [myScrollView addGestureRecognizer:tapScroll];
    
    pickerView2.showsSelectionIndicator = YES;
    UITapGestureRecognizer *doubleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarPicker)];
    
    [pickerView2 addGestureRecognizer:doubleTap2];
    
    UITapGestureRecognizer *doubleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarPicker2)];
    [pickerFecha addGestureRecognizer:doubleTap3];
    
    arraySexo = [[NSMutableArray alloc] init];
    [arraySexo addObject:@"Seleccione"];
    [arraySexo addObject:@"Hombre"];
    [arraySexo addObject:@"Mujer"];
    
    arrayFecha = [[NSMutableArray alloc] init];
    [arrayFecha addObject:@"Seleccione"];
    for(int i=0;i< 24; i++){
    	NSString *hora = [NSString stringWithFormat:@"%d",i];
        [arrayFecha addObject:hora];
    }
    
    
}

- (void)pickerViewTapGestureRecognized:(UITapGestureRecognizer*)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:gestureRecognizer.view.superview];
    
    CGRect frame = pickerView.frame;
    CGRect selectorFrame = CGRectInset( frame, 0.0, pickerView.bounds.size.height * 0.85 / 2.0 );
    
    if( CGRectContainsPoint( selectorFrame, touchPoint) )
    {
        [self quitarPicker];
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
    reloj = nil;
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

- (IBAction)mostrarPickernext{
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
    
    fechacampo.text = date;
}

- (IBAction)quitarPickerDone2:(id)sender
{
    [self quitarPicker2];
}



- (IBAction)cancel:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
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
    
    [reloj startAnimating];
    [reloj setHidden:NO];
    NSString *sexoletra = @"M";
    responseData = [NSMutableData data];
    if([sexoCampo.text isEqualToString:@""]){
        sexoletra = @"M";
    }else{
        sexoletra = [sexoCampo.text substringToIndex:1];
        
        if([sexoletra isEqualToString:@"H"]){
            sexoletra = @"M";
        }else{
            sexoletra = @"F";
        }
    }
    
    NSDate *date = [NSDate date];
    int secondsNow =(int)[date timeIntervalSince1970];
    
    // Convierto el string hasta
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSDate *hastaDate = [dateFormat dateFromString:fechacampo.text];
    
    int secondsTarget=(int)[hastaDate timeIntervalSince1970];
    int differenceSeconds=secondsTarget-secondsNow;
    int anios=(int)((double)differenceSeconds/(3600.0*24.00*365));
    int days=(int)((double)differenceSeconds/(3600.0*24.00));
    int diffDay=differenceSeconds-(days*3600*24);
    int hours=(int)((double)diffDay/3600.00);
    int diffMin=diffDay-(hours*3600);
    int minutes=(int)(diffMin/60.0);
    
    NSLog(@"%i",anios);
    
    
    if(anios < -16){
        if(![email2Label.text isEqualToString:emailLabel.text]){
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"Los 2 e-mails deben ser iguales" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alerta show];
        }else{
            NSString *post = [NSString stringWithFormat:@"&nombre=%@&apellido=%@&email=%@&contrasena=%@&sexo=%@&fecnac=%@",nombreLabel.text, apellidoLabel.text, emailLabel.text, contrasenaLabel.text, sexoletra, fechacampo.text];
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
    }else{
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Lo sentimos, debes ser mayor de 16 años para acceder a womity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
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
    NSString *urlconexion = [NSString stringWithFormat:@"%@",connection.currentRequest.URL];
    
    if([urlconexion isEqualToString:@"http://www.womity.com/ws/registrar"])
    {
        if(![email2Label.text isEqualToString:emailLabel.text]){
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"Los 2 e-mails deben ser iguales" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alerta show];
        }else if ([[json objectForKey:@"boolRegistro"] isEqualToString:@"true"])
        {
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Womity" message:@"Tu registro se ha realizado con éxito" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alerta show];
            
            NSString *post = [NSString stringWithFormat:@"&email=%@&contrasena=%@&deviceToken=%@",emailLabel.text, contrasenaLabel.text,[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"]];
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
            
            
        }else{
            if([nombreLabel.text isEqualToString:@""] || [apellidoLabel.text isEqualToString:@""] || [emailLabel.text isEqualToString:@""] || [contrasenaLabel.text isEqualToString:@""] || [fechacampo.text isEqualToString:@""] || [sexoCampo.text isEqualToString:@""]){
                UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"Debes rellenar todos los campos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alerta show];
            }
            
            if(![email2Label.text isEqualToString:emailLabel.text]){
                UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"Los 2 e-mails deben ser iguales" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alerta show];
            }
            
            if([[json objectForKey:@"strMensaje"] isEqualToString:@"EmailYaExiste"]){
                UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"Este e-mail ya se encuentra registrado" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alerta show];
            }
        }
        
    }
    
    
    if([urlconexion isEqualToString:@"http://www.womity.com/ws/login"])
    {
        
        if ([[json objectForKey:@"boolLogin"] isEqualToString:@"true"])
        {
            //[self dismissModalViewControllerAnimated:YES];
            [[NSUserDefaults standardUserDefaults] setValue:[json objectForKey:@"idSession"] forKey:@"id"];
            [self performSegueWithIdentifier:@"logueado2" sender:self];
        }
        
    }
    
    
    [reloj stopAnimating];
    [reloj setHidden:YES];
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return [arraySexo count];
    
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [arraySexo objectAtIndex:row];
    
    
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if(thePickerView == pickerView){
        sexoCampo.text = [arraySexo objectAtIndex:row];
    }else{
        NSLog(@"%@",thePickerView);
    }
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    if(textField == nombreLabel){
        [apellidoLabel becomeFirstResponder];
    }
    if(textField == apellidoLabel){
        [emailLabel becomeFirstResponder];
    }
    if(textField == emailLabel){
        [email2Label becomeFirstResponder];
    }
    if(textField == email2Label){
        [contrasenaLabel becomeFirstResponder];
    }
    if(textField == contrasenaLabel){
        [self mostrarPickernext];
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

- (void)quitarTeclado
{
    // Dismiss the keyboard when the view outside the text field is touched.
    [nombreLabel resignFirstResponder];
    [emailLabel resignFirstResponder];
    [apellidoLabel resignFirstResponder];
    [email2Label resignFirstResponder];
    [contrasenaLabel resignFirstResponder];
    // Revert the text field to the previous value.
    //palabra.text = self.string;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.view.frame.size.width == 320){
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame = CGRectMake(0,-100,self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(self.view.frame.size.width == 320){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame = CGRectMake(0,20,self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
    }
    
}


- (IBAction)uploadPhoto:(id)sender {
    UIActionSheet *photoSourcePicker = [[UIActionSheet alloc] initWithTitle:nil
                                                                   delegate:self cancelButtonTitle:@"Cancel"
                                                     destructiveButtonTitle:nil
                                                          otherButtonTitles:	@"Take Photo",
                                        @"Choose from Library",
                                        nil,
                                        nil];
    
    [photoSourcePicker showInView:self.tabBarController.view];
}

- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex)
	{
		case 0:
		{
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
                imagePicker.delegate = self;
                imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
                imagePicker.allowsEditing = NO;
                [self presentModalViewController:imagePicker animated:YES];
            }
            else {
                UIAlertView *alert;
                alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                   message:@"This device doesn't have a camera."
                                                  delegate:self cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil];
                [alert show];
            }
			break;
		}
		case 1:
		{
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.delegate = self;
                imagePicker.allowsEditing = NO;
                [self presentModalViewController:imagePicker animated:YES];
            }
            else {
                UIAlertView *alert;
                alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                   message:@"This device doesn't support photo libraries."
                                                  delegate:self cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil];
                [alert show];
            }
			break;
		}
	}
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissModalViewControllerAnimated:YES];
    NSLog(@"%@",nombreLabel.text);
    image = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.1);
    UIImage *imagen = [UIImage imageWithData:image];
    fotoopcion.image = imagen;
    
}

- (IBAction)verayudas:(id)sender
{
    NSURL *url = [ [ NSURL alloc ] initWithString: [NSString stringWithFormat:@"http://www.womity.com/womity/privacityfp"]];
    NSLog(@"%@",url);
    [[UIApplication sharedApplication] openURL:url];
}

- (NSUInteger)supportedInterfaceOrientations {
    
    if([[UIApplication sharedApplication] statusBarOrientation] == 1|| [[UIApplication sharedApplication] statusBarOrientation] == 2){
        
        imageview.image = [UIImage imageNamed:@"Reg_screen_port.jpg"];
        nombreLabel.frame = CGRectMake(231, 257, 389, 30);
        apellidoLabel.frame = CGRectMake(nombreLabel.frame.origin.x, nombreLabel.frame.origin.y + 57, 389, 30);
        emailLabel.frame = CGRectMake(nombreLabel.frame.origin.x, apellidoLabel.frame.origin.y + 57, 389, 30);
        email2Label.frame = CGRectMake(nombreLabel.frame.origin.x + 67, emailLabel.frame.origin.y + 55, 317, 30);
        contrasenaLabel.frame = CGRectMake(nombreLabel.frame.origin.x + 29, email2Label.frame.origin.y + 54, 360, 30);
        sexoCampo.frame = CGRectMake(contrasenaLabel.frame.origin.x - 48, contrasenaLabel.frame.origin.y + 54, 98, 32);
        butonsexo.frame = CGRectMake(contrasenaLabel.frame.origin.x - 58, contrasenaLabel.frame.origin.y + 54, 98, 32);
        fechasexo.frame = CGRectMake(butonsexo.frame.origin.x + 81, butonsexo.frame.origin.y + 10, 16, 9);
        fechacampo.frame = CGRectMake(sexoCampo.frame.origin.x + 283, contrasenaLabel.frame.origin.y + 54, 129, 30);
        butonfecha.frame = CGRectMake(sexoCampo.frame.origin.x + 115, butonsexo.frame.origin.y , 303, 37);
        fechafecha.frame = CGRectMake(fechacampo.frame.origin.x + 108, fechacampo.frame.origin.y + 10, 16, 9);
        privacidad.frame = CGRectMake(150, 602, 470, 46);
        
    }else{
        imageview.image = [UIImage imageNamed:@"Reg_screen.jpg"];
        nombreLabel.frame = CGRectMake(361, 172, 389, 30);
        apellidoLabel.frame = CGRectMake(nombreLabel.frame.origin.x, nombreLabel.frame.origin.y + 57, 389, 30);
        emailLabel.frame = CGRectMake(nombreLabel.frame.origin.x, apellidoLabel.frame.origin.y + 57, 389, 30);
        email2Label.frame = CGRectMake(nombreLabel.frame.origin.x + 67, emailLabel.frame.origin.y + 55, 317, 30);
        contrasenaLabel.frame = CGRectMake(nombreLabel.frame.origin.x + 29, email2Label.frame.origin.y + 54, 360, 30);
        sexoCampo.frame = CGRectMake(contrasenaLabel.frame.origin.x - 48, contrasenaLabel.frame.origin.y + 54, 98, 32);
        butonsexo.frame = CGRectMake(contrasenaLabel.frame.origin.x - 58, contrasenaLabel.frame.origin.y + 54, 98, 32);
        fechasexo.frame = CGRectMake(butonsexo.frame.origin.x + 81, butonsexo.frame.origin.y + 10, 16, 9);
        fechacampo.frame = CGRectMake(sexoCampo.frame.origin.x + 283, contrasenaLabel.frame.origin.y + 54, 129, 30);
        butonfecha.frame = CGRectMake(sexoCampo.frame.origin.x + 115, butonsexo.frame.origin.y , 303, 37);
        fechafecha.frame = CGRectMake(fechacampo.frame.origin.x + 108, fechacampo.frame.origin.y + 10, 16, 9);
        privacidad.frame = CGRectMake(privacidad.frame.origin.x, privacidad.frame.origin.y + 40, 470, 46);
    }
    
    return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscape  | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight);
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if([[UIApplication sharedApplication] statusBarOrientation] == 3|| [[UIApplication sharedApplication] statusBarOrientation] == 4){
        
        imageview.image = [UIImage imageNamed:@"Reg_screen_port.jpg"];
        nombreLabel.frame = CGRectMake(231, 257, 389, 30);
        apellidoLabel.frame = CGRectMake(nombreLabel.frame.origin.x, nombreLabel.frame.origin.y + 57, 389, 30);
        emailLabel.frame = CGRectMake(nombreLabel.frame.origin.x, apellidoLabel.frame.origin.y + 57, 389, 30);
        email2Label.frame = CGRectMake(nombreLabel.frame.origin.x + 67, emailLabel.frame.origin.y + 55, 317, 30);
        contrasenaLabel.frame = CGRectMake(nombreLabel.frame.origin.x + 29, email2Label.frame.origin.y + 54, 360, 30);
        sexoCampo.frame = CGRectMake(contrasenaLabel.frame.origin.x - 48, contrasenaLabel.frame.origin.y + 54, 98, 32);
        butonsexo.frame = CGRectMake(contrasenaLabel.frame.origin.x - 58, contrasenaLabel.frame.origin.y + 54, 98, 32);
        fechasexo.frame = CGRectMake(butonsexo.frame.origin.x + 81, butonsexo.frame.origin.y + 10, 16, 9);
        fechacampo.frame = CGRectMake(sexoCampo.frame.origin.x + 283, contrasenaLabel.frame.origin.y + 54, 129, 30);
        butonfecha.frame = CGRectMake(sexoCampo.frame.origin.x + 115, butonsexo.frame.origin.y , 303, 37);
        fechafecha.frame = CGRectMake(fechacampo.frame.origin.x + 108, fechacampo.frame.origin.y + 10, 16, 9);
        privacidad.frame = CGRectMake(150, 602, 470, 46);
        
    }else{
        imageview.image = [UIImage imageNamed:@"Reg_screen.jpg"];
        nombreLabel.frame = CGRectMake(361, 172, 389, 30);
        apellidoLabel.frame = CGRectMake(nombreLabel.frame.origin.x, nombreLabel.frame.origin.y + 57, 389, 30);
        emailLabel.frame = CGRectMake(nombreLabel.frame.origin.x, apellidoLabel.frame.origin.y + 57, 389, 30);
        email2Label.frame = CGRectMake(nombreLabel.frame.origin.x + 67, emailLabel.frame.origin.y + 55, 317, 30);
        contrasenaLabel.frame = CGRectMake(nombreLabel.frame.origin.x + 29, email2Label.frame.origin.y + 54, 360, 30);
        sexoCampo.frame = CGRectMake(contrasenaLabel.frame.origin.x - 48, contrasenaLabel.frame.origin.y + 54, 98, 32);
        butonsexo.frame = CGRectMake(contrasenaLabel.frame.origin.x - 58, contrasenaLabel.frame.origin.y + 54, 98, 32);
        fechasexo.frame = CGRectMake(butonsexo.frame.origin.x + 81, butonsexo.frame.origin.y + 10, 16, 9);
        fechacampo.frame = CGRectMake(sexoCampo.frame.origin.x + 283, contrasenaLabel.frame.origin.y + 54, 129, 30);
        butonfecha.frame = CGRectMake(sexoCampo.frame.origin.x + 115, butonsexo.frame.origin.y , 303, 37);
        fechafecha.frame = CGRectMake(fechacampo.frame.origin.x + 108, fechacampo.frame.origin.y + 10, 16, 9);
        privacidad.frame = CGRectMake(privacidad.frame.origin.x, privacidad.frame.origin.y + 40, 470, 46);
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    orientacion = interfaceOrientation;
    if([[UIApplication sharedApplication] statusBarOrientation] == 1 || [[UIApplication sharedApplication] statusBarOrientation] == 2){
        imageview.image = [UIImage imageNamed:@"Reg_screen_port.jpg"];
        nombreLabel.frame = CGRectMake(231, 257, 389, 30);
        apellidoLabel.frame = CGRectMake(nombreLabel.frame.origin.x, nombreLabel.frame.origin.y + 57, 389, 30);
        emailLabel.frame = CGRectMake(nombreLabel.frame.origin.x, apellidoLabel.frame.origin.y + 57, 389, 30);
        email2Label.frame = CGRectMake(nombreLabel.frame.origin.x + 67, emailLabel.frame.origin.y + 55, 317, 30);
        contrasenaLabel.frame = CGRectMake(nombreLabel.frame.origin.x + 29, email2Label.frame.origin.y + 54, 360, 30);
        sexoCampo.frame = CGRectMake(contrasenaLabel.frame.origin.x - 48, contrasenaLabel.frame.origin.y + 54, 98, 32);
        butonsexo.frame = CGRectMake(contrasenaLabel.frame.origin.x - 58, contrasenaLabel.frame.origin.y + 54, 98, 32);
        fechasexo.frame = CGRectMake(butonsexo.frame.origin.x + 81, butonsexo.frame.origin.y + 10, 16, 9);
        fechacampo.frame = CGRectMake(sexoCampo.frame.origin.x + 283, contrasenaLabel.frame.origin.y + 54, 129, 30);
        butonfecha.frame = CGRectMake(sexoCampo.frame.origin.x + 115, butonsexo.frame.origin.y , 303, 37);
        fechafecha.frame = CGRectMake(fechacampo.frame.origin.x + 108, fechacampo.frame.origin.y + 10, 16, 9);
        privacidad.frame = CGRectMake(150, 602, 470, 46);
        
    }else{
        imageview.image = [UIImage imageNamed:@"Reg_screen.jpg"];
        nombreLabel.frame = CGRectMake(361, 172, 389, 30);
        apellidoLabel.frame = CGRectMake(nombreLabel.frame.origin.x, nombreLabel.frame.origin.y + 57, 389, 30);
        emailLabel.frame = CGRectMake(nombreLabel.frame.origin.x, apellidoLabel.frame.origin.y + 57, 389, 30);
        email2Label.frame = CGRectMake(nombreLabel.frame.origin.x + 67, emailLabel.frame.origin.y + 55, 317, 30);
        contrasenaLabel.frame = CGRectMake(nombreLabel.frame.origin.x + 29, email2Label.frame.origin.y + 54, 360, 30);
        sexoCampo.frame = CGRectMake(contrasenaLabel.frame.origin.x - 48, contrasenaLabel.frame.origin.y + 54, 98, 32);
        butonsexo.frame = CGRectMake(contrasenaLabel.frame.origin.x - 58, contrasenaLabel.frame.origin.y + 54, 98, 32);
        fechasexo.frame = CGRectMake(butonsexo.frame.origin.x + 81, butonsexo.frame.origin.y + 10, 16, 9);
        fechacampo.frame = CGRectMake(sexoCampo.frame.origin.x + 283, contrasenaLabel.frame.origin.y + 54, 129, 30);
        butonfecha.frame = CGRectMake(sexoCampo.frame.origin.x + 115, butonsexo.frame.origin.y , 303, 37);
        fechafecha.frame = CGRectMake(fechacampo.frame.origin.x + 108, fechacampo.frame.origin.y + 10, 16, 9);
        privacidad.frame = CGRectMake(privacidad.frame.origin.x, privacidad.frame.origin.y + 40, 470, 46);

    }
    
    return YES;
}



@end


