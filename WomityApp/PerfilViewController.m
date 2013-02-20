//
//  PerfilViewController.m
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/19/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "PerfilViewController.h"
#import "UIImage+Resize.h"
#import <QuartzCore/QuartzCore.h>
#import "popViewContainer.h"
#import "ComentariosViewController.h"
#define radians(degrees) (degrees * M_PI/180)

@interface PerfilViewController ()

@end

@implementation PerfilViewController
@synthesize foto, fotoview, botonfoto, nombre, apellido, email, vistaPicker, vistaPicker2, pickerView, pickerFecha, sexoLabel, fecnacLabel, myScrollView, responseData, sexoCampo, fechaCampo, vistareloj, reloj, celda1, celda2, celda3, celda4, celda5, celda6;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
    [[NSUserDefaults standardUserDefaults] setValue:@"ppal" forKey:@"accionppal"];
    [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"soloactivos"];
    [viewController.navigationController popToViewController:[viewController.navigationController.viewControllers objectAtIndex:0] animated:YES];
    return YES;
}

- (void)viewDidLoad
{
    [vistareloj setHidden:NO];
    [reloj startAnimating];
    
    [super viewDidLoad];
    self.tabBarController.delegate = self;

    fotoview.layer.cornerRadius = 8;
    celda1.layer.cornerRadius = 8;
    celda2.layer.cornerRadius = 8;
    celda3.layer.cornerRadius = 8;
    celda4.layer.cornerRadius = 8;
    celda5.layer.cornerRadius = 8;
    celda6.layer.cornerRadius = 8;
    
    [reloj startAnimating];
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
    [myFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *minDate = [myFormatter dateFromString:@"01/01/1912"];
    [pickerFecha setMinimumDate:minDate];
    pickerView.showsSelectionIndicator = YES;
    UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapGestureRecognized:)];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    [pickerView addGestureRecognizer:gestureRecognizer];
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarTeclado)];
    
    [myScrollView addGestureRecognizer:tapScroll];
    
    
    
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
    
    aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
    responseData = [NSMutableData data];
    NSString *post = [NSString stringWithFormat:@"&idSession=%@",aSesion];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/Perfil"]]];
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

	// Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Dismiss the keyboard when the view outside the text field is touched.
    [nombre resignFirstResponder];
    [apellido resignFirstResponder];
    [email resignFirstResponder];
    // Revert the text field to the previous value.
    //palabra.text = self.string;
    [super touchesBegan:touches withEvent:event];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)mostrarPicker:(id)sender{
    
    scrollview.frame = CGRectMake(0,-150,self.view.frame.size.width,self.view.frame.size.height);
    
    [nombre resignFirstResponder];
    [email resignFirstResponder];
    [apellido resignFirstResponder];
    //NSLog(@"mostrar picker");
    //pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    //[self.view addSubview:pickerView];
    //[self.view bringSubviewToFront:vistaPicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistaPicker setFrame:CGRectMake(0, 205,self.view.frame.size.width,257)];
    
    [UIView commitAnimations];
    
}
- (IBAction)mostrarPicker2:(id)sender{
    
    scrollview.frame = CGRectMake(0,-150,self.view.frame.size.width,self.view.frame.size.height);
    
    [nombre resignFirstResponder];
    [email resignFirstResponder];
    [apellido resignFirstResponder];
    //NSLog(@"mostrar picker");
    //pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    //[self.view addSubview:pickerView];
    //[self.view bringSubviewToFront:vistaPicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistaPicker2 setFrame:CGRectMake(0,205,self.view.frame.size.width,257)];
    
    [UIView commitAnimations];
    
}

- (void)quitarPicker{
    
    scrollview.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [vistaPicker setFrame:CGRectMake(0,1000,self.view.frame.size.width,257)];
    [vistaPicker2 setFrame:CGRectMake(0,1000,self.view.frame.size.width,257)];
    [UIView commitAnimations];
}

- (IBAction)quitarPickerDone:(id)sender
{
    
    [self quitarPicker];
}

- (void)quitarPicker2{
    
    scrollview.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [vistaPicker setFrame:CGRectMake(0,1000,self.view.frame.size.width,257)];
    [vistaPicker2 setFrame:CGRectMake(0,1000,self.view.frame.size.width,257)];
    [UIView commitAnimations];
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
    [myFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *date = [myFormatter stringFromDate:[pickerFecha date]];
    
    fechaCampo.text = date;
}

- (IBAction)quitarPickerDone2:(id)sender
{
    [self quitarPicker2];
}

- (IBAction)cancel:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)cerrarsesion:(id)sender
{
	[[NSUserDefaults standardUserDefaults] setValue:NULL forKey:@"id"];
    //[self dismissModalViewControllerAnimated:YES];
    [self performSegueWithIdentifier:@"cerrarsesion" sender:self];
}


- (IBAction)registrarse:(id)sender
{
    
    [reloj startAnimating];
    [vistareloj setHidden:NO];
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
    NSString *sexoletra = [sexoCampo.text substringToIndex:1];
    
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

    
    /*NSString *post = [NSString stringWithFormat:@"&nombre=%@&apellido=%@&email=%@&sexo=%@&fecnac=%@",nombre.text, apellido.text, email.text, sexoletra, fecnacLabel.text];
    NSLog(@"%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/registro"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];*/
    if(image == NULL){
        UIImage *img = [UIImage imageNamed:@"icono1.png"];
        image = UIImagePNGRepresentation(img);
        
    }
    NSString *urlString = @"http://www.womity.com/ws/modificarPerfil";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"idSession\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[[NSUserDefaults standardUserDefaults] valueForKey:@"id"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"sexo\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[sexoletra dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"fecnac\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[fechaCampo.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"nombre\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[nombre.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"apellidos\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[apellido.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    if(image == NULL){
        UIImage *img = [UIImage imageNamed:@"icono1.png"];
        image = UIImagePNGRepresentation(img);
        NSLog(@"%@",image);
        
    }
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"foto\"; filename=\".png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@",image);
    
    UIImage *imagentemp = [UIImage imageWithData:image];
    
    UIImage *scaledImage = [imagentemp resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(imagentemp.size.width, imagentemp.size.height) interpolationQuality:kCGInterpolationHigh];
    image = UIImageJPEGRepresentation(scaledImage, 0.9);
    
    [body appendData:[NSData dataWithData:image]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    // now lets make the connection to the web
    //NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if(conn)
    {
        NSLog(@"Connection Successful");
    }
    else
    {
        NSLog(@"Connection could not be made");
    }

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
    [reloj stopAnimating];
    [vistareloj setHidden:YES];
    //[self performSegueWithIdentifier:@"loguearse" sender:self];
    
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          options:kNilOptions
                          error:&error];
    
    NSLog(@"%@",json);
    
    /*if ([[json objectForKey:@"boolRegistro"] isEqualToString:@"true"])
	{
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atencion" message:@"Registro Exitoso" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }else{
        
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atencion" message:@"No hemos logrado registrarte. Revisa los campos, es posible que el correo ya esté inscrito" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }*/
    NSString *urlconexion = [NSString stringWithFormat:@"%@",connection.currentRequest.URL];
    
    
    if([urlconexion isEqualToString:@"http://www.womity.com/ws/Perfil"])
    {
    NSString * sexo = [[json objectForKey:@"Perfil"] objectForKey:@"sex"];
    
    if([sexo isEqualToString:@"0"])
    {
        sexo = @"Hombre";
    }else
    {
        sexo = @"Mujer";
    }
    
    nombre.text = [[json objectForKey:@"Perfil"] objectForKey:@"first_name"];
    apellido.text = [[json objectForKey:@"Perfil"] objectForKey:@"last_name"];
    email.text = [[json objectForKey:@"Perfil"] objectForKey:@"email_address"];
    fechaCampo.text = [[json objectForKey:@"Perfil"] objectForKey:@"birthday"];
    sexoCampo.text = sexo;
    NSString *urlimagencompleta = [[json objectForKey:@"Perfil"] objectForKey:@"profile_image_thumb"];
    NSURL *url = [NSURL URLWithString:urlimagencompleta];
    NSData *data = [NSData dataWithContentsOfURL:url];
   
    UIImage *imagen = [UIImage imageWithData:data];
        image = UIImageJPEGRepresentation(imagen, 0.9);
    foto.image = imagen;
    }else{
        if([[json objectForKey:@"boolModificarPerfil"] isEqualToString:@"true"]){
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Perfil actualizado correctamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alerta show];
        }
    }
    [reloj stopAnimating];
    [vistareloj setHidden:YES];
    //foto.image = [[json objectForKey:@"Perfil"] objectForKey:@"profile_image"];
    
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
    
    if([textField.placeholder isEqualToString:@"contraseña"])
    {
        responseData = [NSMutableData data];
        NSString *sexoletra = [sexoCampo.text substringToIndex:1];
        NSString *post = [NSString stringWithFormat:@"&nombre=%@&apellido=%@&email=%@&contrasena=%@&sexo=%@&fecnac=%@",nombre.text, apellido.text, email.text, sexoletra, fecnacLabel.text];
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



- (void)quitarTeclado
{
    // Dismiss the keyboard when the view outside the text field is touched.
    [nombre resignFirstResponder];
    [email resignFirstResponder];
    [apellido resignFirstResponder];
    // Revert the text field to the previous value.
    //palabra.text = self.string;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.view.frame.size.width == 320){
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame = CGRectMake(0,-80,self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(self.view.frame.size.width == 320){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
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
    image = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.9);
   
    UIImage *imagen = [UIImage imageWithData:image];
    foto.image = imagen;
    
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



@end
