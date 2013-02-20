//
//  FormsubirViewController.m
//  pillado
//
//  Created by Carlos Andres Robinson Lara on 10/23/12.
//  Copyright (c) 2012 Juan Camilo Pereira. All rights reserved.
//

#import "FormsubirViewController.h"
#import "UIImage+Resize.h"
#define radians(degrees) (degrees * M_PI/180)
@interface FormsubirViewController ()

@end

@implementation FormsubirViewController
@synthesize latitud, longitud,datapic, vistaPicker, pickerView;

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
    
    dictionary = [[NSMutableDictionary alloc] init];
    
    pickerView.showsSelectionIndicator = YES;
    UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapGestureRecognized:)];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    [pickerView addGestureRecognizer:gestureRecognizer];
    scrollView.delegate =self;
    arraySexo = [[NSMutableArray alloc] init];
    [arraySexo addObject:@"Seleccione"];
    [arraySexo addObject:@"Mal Parqueado"];
    [arraySexo addObject:@"Cruce prohibido"];
    [arraySexo addObject:@"No hacer Pare"];
    [arraySexo addObject:@"Pasar semaforo en Rojo"];
    [arraySexo addObject:@"Transitar en contra via"];
    [arraySexo addObject:@"Bloquear una calzada o intersección"];
    [arraySexo addObject:@"Dejar o recoger pasajeros en sitios distintos de los demarcados"];
    [arraySexo addObject:@"Giro en U"];
    [arraySexo addObject:@"Hacer doble fila"];
    [arraySexo addObject:@"Para en la zebra"];
    [arraySexo addObject:@"Parquear en zona prohibida"];
    [arraySexo addObject:@"Sobre cupo"];
    
    [_foto setImage:[UIImage imageWithData:datapic]];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager setDelegate:self];
    [locationManager startUpdatingLocation];
    [loading setHidden:YES];
    
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setFoto:nil];
    [super viewDidUnload];
}


-(IBAction) subirinfo
{
    
    /*action = pillado
    IDRegistro
    IDFacebook
    Fecha
    Placa
    Latitud
    Longitud
    imagen
    Nombre
    Comentar*/
    
    if([comment.text isEqualToString:@""] || [placa.text isEqualToString:@""] || [comment.text isEqualToString:@"Seleccione"]){
        
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Debes colocar la placa y escoger un tipo de infracción" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        
    }else{
    
    scrollView.contentSize = CGSizeMake(0, 600);
    scrollView.userInteractionEnabled = NO;
    
    [dictionary setValue:@"pillado" forKey:@"action"];
    [dictionary setValue:[self getStringFromDate:[NSDate date]] forKey:@"Fecha"];
    [dictionary setValue:placa.text forKey:@"Placa"];
    [dictionary setValue:comment.text forKey:@"Comentario"];
    [dictionary setValue:comment.text forKey:@"Nombre"];
    [dictionary setValue:[NSString stringWithFormat:@"%i",[[NSUserDefaults standardUserDefaults] integerForKey:@"idPillado"]] forKey:@"IDRegistro"];

    
    //if ([[NSUserDefaults standardUserDefaults] integerForKey:@"idPillado"] == 0){
      //  [self performSegueWithIdentifier:@"login" sender:nil];
    //}else{
        [loading setHidden:NO];
        [loading startAnimating];
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loadingPreview) userInfo:nil repeats:NO];
   // }
    }
    
}

-(void)loadingPreview{
    [self sendingDataSyncronicImage:datapic andjsonURL:[NSURL URLWithString:@"http://www.estaspillado.com/?page_id=57"] otherString:[NSDictionary dictionaryWithDictionary:dictionary]];
    
}



-(void)sendingDataSyncronicImage:(NSData *)dataImage andjsonURL:(NSURL *)url otherString:(NSDictionary *)jsonRequest
{
    
    mutableData = [NSMutableData data];
    UIImage *imagen = [UIImage imageWithData:datapic];
    UIImage* sourceImage = imagen;
	CGFloat targetWidth = 320;
	CGFloat targetHeight = 480;
    /*
	CGImageRef imageRef = [sourceImage CGImage];
	CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
	CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    
	if (bitmapInfo == kCGImageAlphaNone) {
		bitmapInfo = kCGImageAlphaNoneSkipLast;
	}
    
	CGContextRef bitmap;
    
	if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
	} else {
        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
	}    
    
	if (sourceImage.imageOrientation == UIImageOrientationLeft) {
		CGContextRotateCTM (bitmap, radians(90));
		CGContextTranslateCTM (bitmap, 0, -targetHeight);
        
	} else if (sourceImage.imageOrientation == UIImageOrientationRight) {
		CGContextRotateCTM (bitmap, radians(-90));
		CGContextTranslateCTM (bitmap, -targetWidth, 0);
        
	} else if (sourceImage.imageOrientation == UIImageOrientationUp) {
		// NOTHING
	} else if (sourceImage.imageOrientation == UIImageOrientationDown) {
		CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
		CGContextRotateCTM (bitmap, radians(-180.));
	}
    
	CGContextDrawImage(bitmap, CGRectMake(0, 0, targetWidth, targetHeight), imageRef);
	CGImageRef ref = CGBitmapContextCreateImage(bitmap);
	UIImage* newImage = [UIImage imageWithCGImage:ref];
    
	CGContextRelease(bitmap);
	CGImageRelease(ref);
    */
   
        
        UIImageOrientation orientation = imagen.imageOrientation;
        
        UIGraphicsBeginImageContext(imagen.size);
        
        [imagen drawAtPoint:CGPointMake(0, 0)];
        CGContextRef context = UIGraphicsGetCurrentContext();
    
        if (orientation == UIImageOrientationRight) {
            CGContextRotateCTM (context, [self radians:90]);
        } else if (orientation == UIImageOrientationLeft) {
            CGContextRotateCTM (context, [self radians:90]);
        } else if (orientation == UIImageOrientationDown) {
            // NOTHING
        } else if (orientation == UIImageOrientationUp) {
            CGContextRotateCTM (context, [self radians:0]);
        }
        
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    NSLog(@"%f x %f",imagen.size.width, imagen.size.height);
    NSLog(@"%f x %f",newImage.size.width, newImage.size.height);
     
    NSError *error = nil;
    NSURLResponse *response;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    
    NSArray *keys = [jsonRequest allKeys];
    for (NSString *key in keys){
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[jsonRequest valueForKey:key] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    NSMutableString *s = [NSMutableString stringWithCapacity:20];
    for (NSUInteger i = 0U; i < 20; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    
  

	UIImage *scaledImage = [imagen resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(imagen.size.width, imagen.size.height) interpolationQuality:kCGInterpolationHigh];
    // Crop the image to a square (yikes, fancy!)
    //UIImage *croppedImage = [scaledImage croppedImage:CGRectMake()];
    
    dataImage = UIImageJPEGRepresentation(scaledImage, 0.1);
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"imagen\"; filename=\"%@.png\"\r\n",s] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:dataImage];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
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

- (CGFloat) radians:(int)degrees {
    return (degrees/180)*(22/7);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [mutableData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mutableData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    NSLog(@"Connection failed! Error - %@ %@",  [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    UIAlertView *alert = [[UIAlertView alloc ]initWithTitle:@"PILLADOS" message:[NSString stringWithFormat:@"Error de Conexion, por fafor intente mas tarde"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    
    // if (receivedData != nil)receivedData = [[NSMutableData data] init];
    // NSString *s = [[NSString alloc] initWithData:mutableData encoding:NSUTF8StringEncoding];
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:mutableData //1
                          
                          options:kNilOptions
                          error:&error];
    
    //NSLog(@"%@",json);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    NSMutableArray *arraydatos = [json objectForKey:@"Mensaje"];
    NSMutableDictionary *datosdict = [arraydatos objectAtIndex:0];

    
    if([datosdict objectForKey:@"Estado"] == 0){
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"No se pudo sibir la información. LLena los datos e intenta de nuevo." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        [loading setHidden:YES];
        [loading stopAnimating];
    }else{
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"La información se subió satisfactoriamente." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        [self goToListPillados];
    }
    
}


-(IBAction) cancelar
{
    [self goToListPillados];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    //NSLog(@"Location: %@", [newLocation description]);
    latitud = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    longitud = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    [dictionary setValue:latitud forKey:@"Latitud"];
    [dictionary setValue:longitud forKey:@"Longitud"];
}

-(NSString *)getStringFromDate:(NSDate *)date{
    
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    [formate setDateFormat:@"yyyy-MM-dd"];
    NSString *date2 = [formate stringFromDate:date];
    return date2;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self quitarPicker];
    scrollView.contentOffset = CGPointMake(0, 145);

}

-(void)textFieldDidEndEditing:(UITextField *)textField{

        scrollView.contentOffset = CGPointMake(0, 0);
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextField
{
    
        [aTextField resignFirstResponder];
    return YES;
}

-(void)goToListPillados{
    [self performSegueWithIdentifier:@"formaction" sender:self];
}

-(IBAction) gotoCam{
    //[self.navigationController popViewControllerAnimated:YES];
    
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIView* overlay = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
            //overlay.backgroundColor = [UIColor greenColor];
            UIButton *boton1mini = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [boton1mini addTarget:self action:@selector(tomarfoto:) forControlEvents:UIControlEventTouchUpInside];
            //boton1mini.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn-tomarfoto.png"]];
            boton1mini.highlighted = YES;
            boton1mini.tintColor = [UIColor cyanColor];
            boton1mini.frame = CGRectMake(174, 436, 140, 35);
            [boton1mini setTitle:@"Tomar foto" forState:UIControlStateNormal];
            [overlay addSubview:boton1mini];
            
            UIButton *boton2mini = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [boton2mini addTarget:self action:@selector(cancelfoto:) forControlEvents:UIControlEventTouchUpInside];
            //boton2mini.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn-verpillados.png"]];
            boton2mini.highlighted = YES;
            boton2mini.tintColor = [UIColor redColor];
            boton2mini.frame = CGRectMake(10, 436, 140, 35);
            [boton2mini setTitle:@"Ver Pillados" forState:UIControlStateNormal];
            boton2mini.titleLabel.textColor = [UIColor whiteColor];
            [overlay addSubview:boton2mini];
            
            imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = NO;
            imagePicker.showsCameraControls = NO;
            
            
            
            imagePicker.cameraOverlayView = overlay;
            //imagePicker.sho
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
    

    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    
    [self dismissModalViewControllerAnimated:YES];
    
    
    //[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showmispilladas) userInfo:nil repeats:NO];
    
    
}
-(IBAction)tomarfoto:(id)sender
{
    //cameraon = NO;
    [imagePicker takePicture];
}

-(IBAction)cancelfoto:(id)sender
{
    //cameraon = NO;
    [self dismissModalViewControllerAnimated:YES];
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(gotoRank) userInfo:nil repeats:NO];
}

- (void) showmispilladas
{
    [self performSegueWithIdentifier:@"cancelfoto" sender:self];
}



- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [self dismissModalViewControllerAnimated:YES];
    //[self showform];
    //[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(showform) userInfo:nil repeats:NO];
    datapic = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.1);
    [_foto setImage:[UIImage imageWithData:datapic]];
    
}



-(IBAction) gotoRank
{
    [self performSegueWithIdentifier:@"formaction" sender:self];
}

-(IBAction) gotoMis
{
    [self performSegueWithIdentifier:@"formaction" sender:self];
}

-(IBAction) gotoConfig
{
    [self performSegueWithIdentifier:@"formaction" sender:self];
}


- (IBAction)mostrarPicker:(id)sender{
    [placa resignFirstResponder];
    [comment resignFirstResponder];
    scrollView.contentOffset = CGPointMake(0, 145);
    //NSLog(@"mostrar picker");
    //pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    //[self.view addSubview:pickerView];
    //[self.view bringSubviewToFront:vistaPicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistaPicker setFrame:CGRectMake(0,self.view.frame.size.height - 116,self.view.frame.size.width,257)];
    
    [UIView commitAnimations];
    
}


- (void)quitarPickerDone:(id)sender
{
    scrollView.contentOffset = CGPointMake(0, 0);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [vistaPicker setFrame:CGRectMake(0,self.view.frame.size.height,self.view.frame.size.width,257)];
    [UIView commitAnimations];
}

- (void)quitarPicker{
    scrollView.contentOffset = CGPointMake(0, 0);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [vistaPicker setFrame:CGRectMake(0,self.view.frame.size.height,self.view.frame.size.width,257)];
    [UIView commitAnimations];
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return [arraySexo count];
    
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [arraySexo objectAtIndex:row];
    
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1; //give components here
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if(thePickerView == pickerView){
        comment.text = [arraySexo objectAtIndex:row];
    }else{
        NSLog(@"%@",thePickerView);
    }
    
}


@end
