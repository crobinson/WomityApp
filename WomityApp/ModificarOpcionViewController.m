//
//  ModificarOpcionViewController.m
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/20/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "ModificarOpcionViewController.h"
#import "UIImage+Resize.h"
#import "ComentariosViewController.h"
#import "popViewContainer.h"
#import "urlViewController.h"
#define radians(degrees) (degrees * M_PI/180)

@interface ModificarOpcionViewController ()

@end

@implementation ModificarOpcionViewController
@synthesize stringTitle;
@synthesize reloj;
@synthesize vistareloj;
@synthesize fofoOpcion;
@synthesize nombreLabel;
@synthesize descripcionLabel;
@synthesize imagenLabel;
@synthesize webLabel;
@synthesize tableView;
@synthesize womityname;
@synthesize imagePhoto;
@synthesize otrosLabel, responseData, aSesion, opcion, idWomit, datawomit;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"soloactivos"] isEqualToString:@"true"]){
        [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"soloactivos"];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:NO];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@", opcion);
    if (datawomit == nil){
        womityname.text = stringTitle;
    }else{
        womityname.text = [datawomit objectForKey:@"Titulo"];
    }
    
    if ([opcion objectForKey:@"Nombre"] == nil){
        nombreLabel.text = [opcion objectForKey:@"name"];
    }else{
        nombreLabel.text = [opcion objectForKey:@"Nombre"];
    }
    
    if ([opcion objectForKey:@"Descripcion"] == nil){
        descripcionLabel.text = [opcion objectForKey:@"description"];
    }else{
        descripcionLabel.text = [opcion objectForKey:@"Descripcion"];
    }
    
    if ([opcion objectForKey:@"Web"] == nil){
        webLabel.text = [opcion objectForKey:@"link"];
    }else{
        webLabel.text = [opcion objectForKey:@"Web"];
    }
    if([opcion objectForKey:@"URLImagen"]){
        
        NSString *urlimagencompleta = [NSString stringWithFormat:@"http://www.womity.com/%@", [opcion objectForKey:@"URLImagenThumb"]];
        NSURL *url = [NSURL URLWithString:urlimagencompleta];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *imagen = [UIImage imageWithData:data];
        fofoOpcion.image = imagen;
        imagePhoto.image = imagen;
        
        if([[opcion objectForKey:@"URLImagenThumb"] isEqualToString:@"/uploads/images/blank_img.png"] || [[opcion objectForKey:@"URLImagen"] isEqualToString:@"uploads/images/"] || [[opcion objectForKey:@"URLImagen"] isEqualToString:@""] ){
        urlimagencompleta = [NSString stringWithFormat:@"http://www.womity.com/%@", [opcion objectForKey:@"URLImagenThumb"]];
        }else{
        urlimagencompleta = [NSString stringWithFormat:@"http://www.womity.com/%@", [opcion objectForKey:@"URLImagen"]];
        }
        url = [NSURL URLWithString:urlimagencompleta];
        data = [NSData dataWithContentsOfURL:url];
        imagen = [UIImage imageWithData:data];
        
        image = UIImageJPEGRepresentation(imagen, 0.9);
        
    }else{
         if([opcion objectForKey:@"image"]){
            
             fofoOpcion.image = [opcion objectForKey:@"image"];
             imagePhoto.image = [opcion objectForKey:@"image"];
             
             image = UIImageJPEGRepresentation([opcion objectForKey:@"image"], 0.9);
         }else{
             fofoOpcion.image = [UIImage imageNamed:@"icono1.png"];
             imagePhoto.image = [UIImage imageNamed:@"icono1.png"];
         }
    }
    scrollView.contentSize = CGSizeMake(0, 416);
    tableView.scrollEnabled = NO;
    
    webViewBK.layer.cornerRadius = 10;
    counterLabel.layer.cornerRadius = 10;
    nameView.layer.cornerRadius = 10;
    descriptionView.layer.cornerRadius = 10;
    imagenView.layer.cornerRadius = 10;
    
    tapScroll = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarTeclado)];
    
    
	// Do any additional setup after loading the view.
}

- (void)quitarTeclado
{
    // Dismiss the keyboard when the view outside the text field is touched.
    [nombreLabel resignFirstResponder];
    [descripcionLabel resignFirstResponder];
    [webLabel resignFirstResponder];
    // Revert the text field to the previous value.
    //palabra.text = self.string;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)agregar:(id)sender{
    
    responseData = [NSMutableData data];
    
    //NSString *post = [NSString stringWithFormat:@"&idSession=%@&idWomity=%@&Nombre=%@&Descripcion=%@&Imagen=%@&Web=%@&Otros=%@",aSesion, [opcion objectForKey:@"idWomity"], nombreLabel.text, descripcionLabel.text, imagenLabel.text, webLabel.text, otrosLabel.text];
    
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistareloj setFrame:CGRectMake(0,44,320,416)];
    [UIView commitAnimations];
    [reloj startAnimating];
    
    [nombreLabel resignFirstResponder];
    [descripcionLabel resignFirstResponder];
    [webLabel resignFirstResponder];
    [otrosLabel resignFirstResponder];
    if(image == NULL){
        UIImage *img = [UIImage imageNamed:@"icono1.png"];
        image = UIImagePNGRepresentation(img);
        
    }
    NSString *urlString = @"http://www.womity.com/ws/modificarOpcionWomity";
    
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
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"idWomity\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[idWomit dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"idOpcion\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[opcion objectForKey:@"idOpcion"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Nombre\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[nombreLabel.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Descripcion\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[descripcionLabel.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Web\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[webLabel.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Otros\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[otrosLabel.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    if(image == NULL){
        UIImage *img = [UIImage imageNamed:@"icono1.png"];
        image = UIImagePNGRepresentation(img);
      //  NSLog(@"%@",image);
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

        
    }else{
        UIImage *imagentemp = [UIImage imageWithData:image];
        
        UIImage *scaledImage = [imagentemp resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(imagentemp.size.width, imagentemp.size.height) interpolationQuality:kCGInterpolationHigh];
        image = UIImageJPEGRepresentation(scaledImage, 0.9);
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"Imagen\"; filename=\".png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        //NSLog(@"%@",image);
        
        
        
        [body appendData:[NSData dataWithData:image]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
   
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
    [vistareloj setFrame:CGRectMake(0,480,320,416)];
    [reloj stopAnimating];
    //[self performSegueWithIdentifier:@"loguearse" sender:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    NSLog(@"%@",json);
    //self.navigationController.view
    [vistareloj setFrame:CGRectMake(0,480,320,416)];
    [UIView commitAnimations];
    [reloj stopAnimating];
    
    
    
    nombreLabel.text = @"";
    descripcionLabel.text = @"";
    otrosLabel.text = @"";
    webLabel.text = @"";
    fofoOpcion.image = [UIImage imageNamed:@"icono2.png"];
    
    if([[json objectForKey:@"boolOpcion"] isEqualToString:@"true"] || [[json objectForKey:@"boolWomity"] isEqualToString:@"true"]){
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"La opción fue modificada correctamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        
    }else{
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:[json objectForKey:@"strMensaje"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        
        
        [alerta show];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if( textField== nombreLabel)
    {
        //[descripcionLabel becomeFirstResponder];
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Dismiss the keyboard when the view outside the text field is touched.
    [nombreLabel resignFirstResponder];
    [descripcionLabel resignFirstResponder];
    [imagenLabel resignFirstResponder];
    [otrosLabel resignFirstResponder];
    [webLabel resignFirstResponder];
    // Revert the text field to the previous value.
    //palabra.text = self.string;
    [super touchesBegan:touches withEvent:event];
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
    
    image = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.1);
    UIImage *imageTmp = [UIImage imageWithData:image];
    imagePhoto.image = imageTmp;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    [scrollView addGestureRecognizer:tapScroll];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    scrollView.contentOffset = CGPointMake(0, 125);
    [UIView commitAnimations];
}



-(void)textViewDidEndEditing:(UITextView *)textView{
    [scrollView removeGestureRecognizer:tapScroll];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    scrollView.contentOffset = CGPointMake(0, 0);
    [UIView commitAnimations];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [scrollView addGestureRecognizer:tapScroll];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    if(textField == webLabel)
    scrollView.contentOffset = CGPointMake(0, 170);
    else
    scrollView.contentOffset = CGPointMake(0, 85);
    [UIView commitAnimations];
}



- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [scrollView removeGestureRecognizer:tapScroll];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    
    scrollView.contentOffset = CGPointMake(0, 0);
    [UIView commitAnimations];
}

- (void)urlAgregar:(NSString *)idamigo{
    webLabel.text = idamigo;
    [self dismissModalViewControllerAnimated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gotourlmod"]){
        urlViewController *controller = [segue destinationViewController];
        controller.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"vercomentarios"]){
        ComentariosViewController *controller = [segue destinationViewController];
        controller.datawomit = datawomitnew;
        controller.aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
        controller.comentar = YES;
        controller.idWomity = [datawomitnew objectForKey:@"idWomity"];
        
    }
}

- (void)popNavegar:(NSMutableDictionary *)womit{
    datawomitnew = womit;
    [self performSegueWithIdentifier:@"vercomentarios" sender:self];
    
    
}


- (IBAction)cancel:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
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

@end
