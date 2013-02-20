//
//  invitar2ViewController.m
//  WomityApp
//
//  Created by Eduardo Rodriguez Macmini on 12/11/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "invitar2ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AmigosCrearViewController.h"
#import "popViewContainer.h"
#import "ComentariosViewController.h"

@interface invitar2ViewController ()

@end

@implementation invitar2ViewController

@synthesize reloj;
@synthesize vistareloj;
@synthesize correosLabel;
@synthesize stringTitle;
@synthesize mensajeLabel, aSesion, idWomit, delegate, myscroll, idsamigos, notscroll, mywebview, mensaje1, mensaje2, mensaje3, boton1, boton2, espasotres;

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
-(void)viewWillAppear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"soloactivos"];
    
    self.tabBarController.delegate = self;
    [[NSUserDefaults standardUserDefaults] setValue:@"agregar" forKey:@"invitar"];
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"accioncrear"] isEqualToString:@"crear"] && ![[[NSUserDefaults standardUserDefaults] valueForKey:@"descripcion"] isEqualToString:@"invitar"])
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"crear" forKey:@"accioncrear"];
      //  [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:NO];
    }else{
        [[NSUserDefaults standardUserDefaults] setValue:@"modificar" forKey:@"accioncrear"];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ishide = YES;
    Taptable = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideWindow)];
    
    vistagris1.layer.cornerRadius = 8;
    vistagris2.layer.cornerRadius = 8;
    vistagris3.layer.cornerRadius = 8;
    vistagris4.layer.cornerRadius = 8;
    idsamigos = [[NSMutableArray alloc] init];
    otrosamigos = [[NSMutableString alloc] init];
    arrayContacts = [[NSMutableArray alloc] init];
    //womityName.text = [stringTitle uppercaseString];
    
    mywebview.delegate = self;
    
    [mywebview loadHTMLString:[NSString stringWithFormat:@"<html><body style=\"font-family:Helvetica; font-size:14px; background-color: transparent; color:black;\"><strong>Envía womit <span style=\"color:red;\"><i>%@</i></span> a tus contactos</strong></body></html>", [stringTitle uppercaseString]] baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    
    
    aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
    
    myscroll.frame = CGRectMake(0, 45, myscroll.frame.size.width, myscroll.frame.size.height);
    
    if(notscroll)
        myscroll.contentSize = CGSizeMake(320, 416);
    else
        myscroll.contentSize = CGSizeMake(320, 570);
    UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarteclado:)];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    [myscroll addGestureRecognizer:gestureRecognizer];
    // [myscroll addGestureRecognizer:Taptable];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGRect rect = mywebview.frame;
    UIScrollView *scrollHeight = (UIScrollView *)[mywebview.subviews objectAtIndex:0];
    scrollHeight.scrollEnabled = NO;
    scrollHeight.pagingEnabled = NO;
    rect.size.height = scrollHeight.contentSize.height;
    mywebview.frame = rect;
    NSLog(@"%f",scrollHeight.contentSize.height);
    if (mywebview.frame.size.height > 39) {
        
        CGRect rect = vistagris1.frame;
        
        rect.origin.y = vistagris1.frame.origin.y + mywebview.frame.size.height - 49;
        vistagris1.frame = rect;
        
        rect = vistagris2.frame;
        
        rect.origin.y = vistagris2.frame.origin.y + mywebview.frame.size.height - 49;
        vistagris2.frame = rect;
        
        rect = vistagris3.frame;
        
        rect.origin.y = vistagris3.frame.origin.y + mywebview.frame.size.height - 49;
        vistagris3.frame = rect;
        
        rect = vistagris4.frame;
        
        rect.origin.y = vistagris4.frame.origin.y + mywebview.frame.size.height - 49;
        vistagris4.frame = rect;
        
        rect = mensaje1.frame;
        
        rect.origin.y = mensaje1.frame.origin.y + mywebview.frame.size.height - 49;
        mensaje1.frame = rect;
        
        rect = mensaje2.frame;
        
        rect.origin.y = mensaje2.frame.origin.y + mywebview.frame.size.height - 49;
        mensaje2.frame = rect;
        
        rect = mensaje3.frame;
        
        rect.origin.y = mensaje3.frame.origin.y + mywebview.frame.size.height - 49;
        mensaje3.frame = rect;
        
        rect = boton2.frame;
        
        rect.origin.y = boton2.frame.origin.y + mywebview.frame.size.height - 49;
        boton2.frame = rect;
        
        rect = boton1.frame;
        
        rect.origin.y = boton1.frame.origin.y + mywebview.frame.size.height - 49;
        boton1.frame = rect;
        
        
        
        
    }
    
    mywebview.opaque = NO;
    mywebview.backgroundColor = [UIColor clearColor];
}

- (void)viewDidUnload
{
    [self setMensajeLabel:nil];
    [self setVistareloj:nil];
    [self setReloj:nil];
    vistareloj = nil;
    reloj = nil;
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

- (IBAction)siguiente:(id)sender{
    //invitarsegue
    
    /*selcontactosViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"seleccionarView"];
     controller.aSesion = aSesion;
     controller.idWomit = idWomit;
     controller.mensajeText.text = mensajeLabel.text;
     controller.otros = correosLabel.text;
     controller.mensaje = mensajeLabel.text;
     [self.navigationController pushViewController:controller animated:YES];*/
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)quitarteclado:(id)sender
{
    [mensajeLabel resignFirstResponder];
    [correosLabel resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mensajeLabel resignFirstResponder];
    [correosLabel resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
}

-(void)AmigosCrearViewControllerDidCancel:(AmigosCrearViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)AmigosViewControllerAgregar:(NSMutableArray *)idamigo deAmigos:(NSMutableArray *)mailamigos;
{
    
    for (int i=0; i<idamigo.count; i++) {
        [idsamigos addObject:[idamigo objectAtIndex:i]];
    }
    
    for (int i=0; i<mailamigos.count; i++) {
        
        NSMutableString *otrosamigos2 = [[NSMutableString alloc] initWithString:@""];
        [otrosamigos2 appendString:[NSString stringWithFormat:@"%@", correosLabel.text]];
        
        if([otrosamigos2 isEqualToString:@""]){
            [otrosamigos2 appendString:[NSString stringWithFormat:@"%@", [mailamigos objectAtIndex:i]]];
        }else {
            [otrosamigos2 appendString:[NSString stringWithFormat:@", %@", [mailamigos objectAtIndex:i]]];
        }
        correosLabel.text = otrosamigos2;
        
        float actualSize2 = 14.0;
        
        [correosLabel.text sizeWithFont:correosLabel.font
                            minFontSize:14
                         actualFontSize:&actualSize2
                               forWidth:305
                          lineBreakMode:UILineBreakModeWordWrap];
        
        CGSize size2 = [correosLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:actualSize2]];
        
        
        int lines2 = 0;
        if(size2.width > correosLabel.frame.size.width){
            float myFloat = size2.width / correosLabel.frame.size.width;
            
            lines2 = (int)ceil(myFloat);
            NSLog(@"%i", lines2);
            // correosLabel.numberOfLines = lines2;
            vistagris4.frame = CGRectMake(vistagris4.frame.origin.x, vistagris4.frame.origin.y, correosLabel.frame.size.width, 32 * lines2);
            correosLabel.frame = CGRectMake(correosLabel.frame.origin.x, correosLabel.frame.origin.y, correosLabel.frame.size.width, 32 * lines2);
            boton1.frame = CGRectMake(boton1.frame.origin.x, vistagris4.frame.origin.y + vistagris4.frame.size.height + 5, boton1.frame.size.width, boton1.frame.size.height);
            
            boton2.frame = CGRectMake(boton2.frame.origin.x, boton1.frame.origin.y + boton1.frame.size.height + 5, boton2.frame.size.width, boton2.frame.size.height);
            //vistagris4.frame = correosLabel.frame;
            
            myscroll.contentSize = CGSizeMake(320, boton2.frame.origin.y + boton2.frame.size.height + 100);
        }
        myscroll.contentSize = CGSizeMake(320, boton2.frame.origin.y + boton2.frame.size.height + 100);
        NSLog(@"%f",boton2.frame.origin.y + boton2.frame.size.height + 100);
        //[idsamigos addObject:[idamigo objectAtIndex:i]];
    }
    
    
    NSLog(@"%@",idsamigos);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)ContactsAgregar:(NSMutableArray *)idamigo deAmigos:(NSMutableArray *)mailamigos;
{
    
    
    
    
    
    NSMutableString *otrosamigos2 = [[NSMutableString alloc] initWithString:@""];
    [otrosamigos2 appendString:[NSString stringWithFormat:@"%@", correosLabel.text]];
    
    if([otrosamigos2 isEqualToString:@""]){
        [otrosamigos2 appendString:[NSString stringWithFormat:@"%@", mailamigos]];
    }else {
        [otrosamigos2 appendString:[NSString stringWithFormat:@", %@", mailamigos]];
    }
    correosLabel.text = otrosamigos2;
    
    float actualSize2 = 14.0;
    
    [correosLabel.text sizeWithFont:correosLabel.font
                        minFontSize:14
                     actualFontSize:&actualSize2
                           forWidth:305
                      lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize size2 = [correosLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:actualSize2]];
    
    
    int lines2 = 0;
    if(size2.width > correosLabel.frame.size.width){
        float myFloat = size2.width / correosLabel.frame.size.width;
        
        lines2 = (int)ceil(myFloat);
        NSLog(@"%i", lines2);
        // correosLabel.numberOfLines = lines2;
        vistagris4.frame = CGRectMake(vistagris4.frame.origin.x, vistagris4.frame.origin.y, correosLabel.frame.size.width, 32 * lines2);
        correosLabel.frame = CGRectMake(correosLabel.frame.origin.x, correosLabel.frame.origin.y, correosLabel.frame.size.width, 32 * lines2);
        boton1.frame = CGRectMake(boton1.frame.origin.x, vistagris4.frame.origin.y + vistagris4.frame.size.height + 5, boton1.frame.size.width, boton1.frame.size.height);
        
        boton2.frame = CGRectMake(boton2.frame.origin.x, boton1.frame.origin.y + boton1.frame.size.height + 5, boton2.frame.size.width, boton2.frame.size.height);
        //vistagris4.frame = correosLabel.frame;
        
        myscroll.contentSize = CGSizeMake(320, boton2.frame.origin.y + boton2.frame.size.height + 100);
    }
    myscroll.contentSize = CGSizeMake(320, boton2.frame.origin.y + boton2.frame.size.height + 100);
    NSLog(@"%f",boton2.frame.origin.y + boton2.frame.size.height + 100);
    //[idsamigos addObject:[idamigo objectAtIndex:i]];
    
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"listamigos"])
	{
		AmigosCrearViewController  *AmigosCrearViewController =  [segue destinationViewController];
		AmigosCrearViewController.delegate = self;
	}
    
    if ([segue.identifier isEqualToString:@"vercomentarios"]){
        ComentariosViewController *controller = [segue destinationViewController];
        controller.datawomit = datawomit;
        controller.aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
        controller.comentar = YES;
        controller.idWomity = [datawomit objectForKey:@"idWomity"];
        
    }
    
    if ([segue.identifier isEqualToString:@"listcontactos"])
	{
		ContactsViewController  *AmigosCrearViewController =  [segue destinationViewController];
        AmigosCrearViewController.bandera = YES;
		AmigosCrearViewController.delegate = self;
	}
}

-(IBAction)enviar:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistareloj setFrame:CGRectMake(0,44,self.view.frame.size.width,417)];
    [UIView commitAnimations];
    [reloj startAnimating];
    
    //NSArray *llaves = [json allKeys];
    NSMutableString *jsonstring = [[NSMutableString alloc] initWithString:@""];
    /*NSMutableString *jsonstring = [[NSMutableString alloc] initWithString:@"{"];
     for (int i=0; i<idsamigos.count; i++) {
     // NSLog(@"%@",[[json objectForKey:[llaves objectAtIndex:i]] objectForKey:@"idOpcion"]);
     [jsonstring appendString:[NSString stringWithFormat:@"\"%i\":%@",i, [idsamigos objectAtIndex:i]]];
     if(i<idsamigos.count - 1)
     {
     [jsonstring appendString:[NSString stringWithFormat:@", "]];
     }
     //[jsonstring stringByAppendingString:[NSString stringWithFormat:@"%i ",i]];
     }
     [jsonstring appendString:[NSString stringWithFormat:@"}"]];
     NSLog(@"%@", jsonstring);
     */
    
    //NSArray *myWords = [correosLabel.text componentsSeparatedByString:@", "];
    
    NSString * string = [correosLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSArray *myWords2 = [string componentsSeparatedByString:@","];
    
    
    
    NSMutableString *jsonstring2 = [[NSMutableString alloc] initWithString:@"{"];
    /* for (int i=0; i<myWords.count; i++) {
     // NSLog(@"%@",[[json objectForKey:[llaves objectAtIndex:i]] objectForKey:@"idOpcion"]);
     [jsonstring2 appendString:[NSString stringWithFormat:@"\"%i\":\"%@\"",i, [myWords objectAtIndex:i]]];
     if(i<myWords.count - 1)
     {
     [jsonstring2 appendString:[NSString stringWithFormat:@", "]];
     }
     //[jsonstring stringByAppendingString:[NSString stringWithFormat:@"%i ",i]];
     }*/
    
    for (int i=0; i<myWords2.count; i++) {
        // NSLog(@"%@",[[json objectForKey:[llaves objectAtIndex:i]] objectForKey:@"idOpcion"]);
        [jsonstring2 appendString:[NSString stringWithFormat:@"\"%i\":\"%@\"",i, [myWords2 objectAtIndex:i]]];
        if(i<myWords2.count - 1)
        {
            [jsonstring2 appendString:[NSString stringWithFormat:@", "]];
        }
        //[jsonstring stringByAppendingString:[NSString stringWithFormat:@"%i ",i]];
    }
    [jsonstring2 appendString:[NSString stringWithFormat:@"}"]];
    NSLog(@"%@", jsonstring2);
    
    
    responseData = [NSMutableData data];
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&idWomity=%@&Contactos=%@&OtrosContactos=%@&MensajeInvitacion=%@",aSesion, idWomit, jsonstring, jsonstring2, mensajeLabel.text];
    NSLog(@"%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    if(espasotres)
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/InvitarWomityYEnviar"]]];
    else
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/invitarWomit"]]];
    
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
    [vistareloj setFrame:CGRectMake(0,416,320,417)];
    [reloj stopAnimating];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSLog(@"%@",json);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistareloj setFrame:CGRectMake(0,1000,self.view.frame.size.width,417)];
    
    [reloj stopAnimating];
    [UIView commitAnimations];
    
    
    /*if([[json objectForKey:@"boolInvitarWomityYEnviar"] isEqualToString:@"true"] && ![[[NSUserDefaults standardUserDefaults] valueForKey:@"descripcion"] isEqualToString:@"invitar"]){
        
        
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Tu womit ha sido enviado a tus contactos con éxito" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"crear" forKey:@"accioncrear"];
        [[NSUserDefaults standardUserDefaults] setValue:@"nuevo" forKey:@"accionnavegar"];
        
        //[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
        [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
        
        UITabBarController *tabBarController = self.tabBarController;
        tabBarController.selectedIndex = 1;
    }else*/ if([[json objectForKey:@"boolInvitarWomityYEnviar"] isEqualToString:@"true"] || [[json objectForKey:@"boolInvitarWomit"] isEqualToString:@"true"]){
        
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Tu womit ha sido enviado a tus contactos con éxito" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        if([[json objectForKey:@"boolInvitarWomityYEnviar"] isEqualToString:@"false"]  || [[json objectForKey:@"boolInvitarWomit"] isEqualToString:@"false"] )
            alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Por favor, revisa los e-mails introducidos. No se pudo enviar la invitación a tus amigos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alerta show];
        
        [self dismissModalViewControllerAnimated:YES];
        
    } else{
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Por favor, revisa los e-mails introducidos. No se pudo enviar la invitación a tus amigos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }
    
    
}


-(IBAction)volver:(id)sender{
    [[NSUserDefaults standardUserDefaults] setValue:@"modificar2" forKey:@"accioncrear"];
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)cancel:(id)sender
{
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Guardado" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alerta show];
    [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
    
    UITabBarController *tabBarController = self.tabBarController;
    tabBarController.selectedIndex = 1;
	//[self performSegueWithIdentifier:@"terminado" sender:self];
}

- (IBAction)cancelado:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setValue:@"crear" forKey:@"accioncrear"];
    [[NSUserDefaults standardUserDefaults] setValue:@"nuevo" forKey:@"accionnavegar"];
    
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Guardado en womits borrador" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alerta show];
    [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
    // [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:NO];
    UITabBarController *tabBarController = self.tabBarController;
    tabBarController.selectedIndex = 1;
	//[self performSegueWithIdentifier:@"terminado" sender:self];
}

#pragma mark ABPeoplePickerNavigationControllerDelegate methods
// Displays the information of a selected person
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
	return YES;
}


// Does not allow users to perform default actions such as dialing a phone number, when they select a person property.
/*- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
 property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
 {
 ABMultiValueRef phoneProperty = ABRecordCopyValue(person,property);
 int idx = ABMultiValueGetIndexForIdentifier (phoneProperty, identifier);
 NSString *phone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phoneProperty,idx);
 NSString* jsString = [[NSString alloc] initWithFormat:@"Contactos.prototype._didFinishWithResult('%@');",phone];
 NSLog(@"%@",phone);
 
 otrosamigos = [[NSMutableString alloc] initWithString:@""];
 [otrosamigos appendString:[NSString stringWithFormat:@"%@", correosLabel.text]];
 
 if([otrosamigos isEqualToString:@""]){
 [otrosamigos appendString:[NSString stringWithFormat:@"%@", phone]];
 }else {
 [otrosamigos appendString:[NSString stringWithFormat:@", %@", phone]];
 }
 
 [arrayContacts addObject:phone];
 
 UIAlertView  * alert = [[UIAlertView alloc] initWithTitle:@"WOMITY" message:[NSString stringWithFormat:@"El correo %@",phone] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
 [alert show];
 
 //correosLabel.text = [NSString stringWithFormat:@"%i Contactos",[arrayContacts count]];
 
 return NO;
 }
 
 */
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    ABMultiValueRef phoneProperty = ABRecordCopyValue(person,property);
    int idx = ABMultiValueGetIndexForIdentifier (phoneProperty, identifier);
    NSString *phone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phoneProperty,idx);
    NSString* jsString = [[NSString alloc] initWithFormat:@"Contactos.prototype._didFinishWithResult('%@');",phone];
    NSLog(@"%@",phone);
    
    otrosamigos = [[NSMutableString alloc] initWithString:@""];
    [otrosamigos appendString:[NSString stringWithFormat:@"%@", correosLabel.text]];
    
    if([otrosamigos isEqualToString:@""]){
        [otrosamigos appendString:[NSString stringWithFormat:@"%@", phone]];
    }else {
        [otrosamigos appendString:[NSString stringWithFormat:@", %@", phone]];
    }
    correosLabel.text = otrosamigos;
    [self dismissModalViewControllerAnimated:YES];
    return NO;
}
// Dismisses the people picker and shows the application when users tap Cancel.
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker;
{
	[self dismissModalViewControllerAnimated:YES];
}
- (IBAction)showPeoplePickerController:(id)sender
{
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
	// Display only a person's phone, email, and birthdate
	NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],
                               [NSNumber numberWithInt:kABPersonEmailProperty],
                               [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
	
	
	picker.displayedProperties = displayedItems;
	// Show the picker
	[self presentModalViewController:picker animated:YES];
}

-(IBAction)done:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 150, self.view.frame.size.width, self.view.frame.size.height);
    
    
    
    [UIView commitAnimations];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 70, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
}

-(void)textViewDidChange:(UITextView *)textView{
    float actualSize2 = 14.0;
    
    [correosLabel.text sizeWithFont:correosLabel.font
                        minFontSize:14
                     actualFontSize:&actualSize2
                           forWidth:305
                      lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize size2 = [correosLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:actualSize2]];
    
    
    int lines2 = 0;
    if(size2.width > correosLabel.frame.size.width){
        float myFloat = size2.width / correosLabel.frame.size.width;
        
        lines2 = (int)ceil(myFloat);
        NSLog(@"%i", lines2);
        // correosLabel.numberOfLines = lines2;
        vistagris4.frame = CGRectMake(vistagris4.frame.origin.x, vistagris4.frame.origin.y, correosLabel.frame.size.width, 32 * lines2);
        correosLabel.frame = CGRectMake(correosLabel.frame.origin.x, correosLabel.frame.origin.y, correosLabel.frame.size.width, 32 * lines2);
        
        boton1.frame = CGRectMake(boton1.frame.origin.x, vistagris4.frame.origin.y + vistagris4.frame.size.height + 5, boton1.frame.size.width, boton1.frame.size.height);
        
        boton2.frame = CGRectMake(boton2.frame.origin.x, boton1.frame.origin.y + boton1.frame.size.height + 5, boton2.frame.size.width, boton2.frame.size.height);
        //vistagris4.frame = correosLabel.frame;
        
        myscroll.contentSize = CGSizeMake(320, boton2.frame.origin.y + boton2.frame.size.height + 100);
    }
    myscroll.contentSize = CGSizeMake(320, boton2.frame.origin.y + boton2.frame.size.height + 100);
    
}

-(void) textViewDidEndEditing:(UITextView *)textView{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 150, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
    float actualSize2 = 14.0;
    
    [correosLabel.text sizeWithFont:correosLabel.font
                        minFontSize:14
                     actualFontSize:&actualSize2
                           forWidth:305
                      lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize size2 = [correosLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:actualSize2]];
    
    
    int lines2 = 0;
    if(size2.width > correosLabel.frame.size.width){
        float myFloat = size2.width / correosLabel.frame.size.width;
        
        lines2 = (int)ceil(myFloat);
        NSLog(@"%i", lines2);
        // correosLabel.numberOfLines = lines2;
        vistagris4.frame = CGRectMake(vistagris4.frame.origin.x, vistagris4.frame.origin.y, correosLabel.frame.size.width, 32 * lines2);
        correosLabel.frame = CGRectMake(correosLabel.frame.origin.x, correosLabel.frame.origin.y, correosLabel.frame.size.width, 32 * lines2);
        
        boton1.frame = CGRectMake(boton1.frame.origin.x, vistagris4.frame.origin.y + vistagris4.frame.size.height + 5, boton1.frame.size.width, boton1.frame.size.height);
        
        boton2.frame = CGRectMake(boton2.frame.origin.x, boton1.frame.origin.y + boton1.frame.size.height + 5, boton2.frame.size.width, boton2.frame.size.height);
        //vistagris4.frame = correosLabel.frame;
        
        myscroll.contentSize = CGSizeMake(320, boton2.frame.origin.y + boton2.frame.size.height + 100);
    }
    myscroll.contentSize = CGSizeMake(320, boton2.frame.origin.y + boton2.frame.size.height + 100);
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 70, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (IBAction)cerrar:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
    
}

-(IBAction)ShowSettings:(id)sender{
    
    
    
    if (ishide){
        [self unHideWindow];
        ishide = NO;
    }else{
        [self hideWindow];
        ishide = YES;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)hideWindow{
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [myscroll removeGestureRecognizer:Taptable];
    [myscroll setFrame:CGRectMake(0,43,320,368)];
    
    [UIView commitAnimations];
    
}

-(void)unHideWindow{
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [myscroll addGestureRecognizer:Taptable];
    //self.navigationController.view
    [myscroll setFrame:CGRectMake(238,43,320,368)];
    
    [UIView commitAnimations];
}

-(IBAction) Loadcrear:(id)sender{
    [self hideWindow];
    ishide = YES;
    [[NSUserDefaults standardUserDefaults] setValue:@"crear" forKey:@"accioncrear"];
    //[self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    
}

-(IBAction)volvervolver:(id)sender{
    [[NSUserDefaults standardUserDefaults] setValue:@"modificar" forKey:@"accioncrear"];
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}


- (IBAction)loadtipoA:(id)sender
{
    //tipo=@"A";
    [self hideWindow];
    ishide = YES;
    [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
    [[NSUserDefaults standardUserDefaults] setValue:@"ppal" forKey:@"accionppal"];
    
    UITabBarController *tabBarController = self.tabBarController;
    tabBarController.selectedIndex = 1;
    //[self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)loadtipoB:(id)sender
{
    [self hideWindow];
    ishide = YES;
    [[NSUserDefaults standardUserDefaults] setValue:@"B" forKey:@"tipowomit"];
    [[NSUserDefaults standardUserDefaults] setValue:@"ppal" forKey:@"accionppal"];
    UITabBarController *tabBarController = self.tabBarController;
    tabBarController.selectedIndex = 1;
}
- (IBAction)loadtipoF:(id)sender
{
    [self hideWindow];
    ishide = YES;
    [[NSUserDefaults standardUserDefaults] setValue:@"F" forKey:@"tipowomit"];
    [[NSUserDefaults standardUserDefaults] setValue:@"ppal" forKey:@"accionppal"];
    UITabBarController *tabBarController = self.tabBarController;
    tabBarController.selectedIndex = 1;
}
- (IBAction)perfil:(id)sender
{
    [self hideWindow];
    ishide = YES;
    
}
- (IBAction)ayuda:(id)sender
{
    
    
}

- (IBAction)amigos:(id)sender
{
    [self hideWindow];
    ishide = YES;
    UITabBarController *tabBarController = self.tabBarController;
    tabBarController.selectedIndex = 2;
}

- (IBAction)onButtonClick:(UIButton *)button {
	
    if (popoverController == nil){
        popoverController = [[popViewContainer alloc] initWithFrame:CGRectMake(90, 30, 239, 390)];
        popoverController.delegate = self;
        popoverController.tabBarController = self.tabBarController;
        [self.view addSubview:popoverController];
    }else{
        [popoverController fadeOFFEmergency];
        [popoverController removeFromSuperview];
        popoverController = nil;
    }
    
}

- (void)popNavegar:(NSMutableDictionary *)womit{
    datawomit = womit;
    [self performSegueWithIdentifier:@"vercomentarios" sender:self];
    
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    [[NSUserDefaults standardUserDefaults] setValue:@"crear" forKey:@"accioncrear"];
    [[NSUserDefaults standardUserDefaults] setValue:@"nuevo" forKey:@"accionnavegar"];
    [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
    [[NSUserDefaults standardUserDefaults] setValue:@"ppal" forKey:@"accionppal"];
    [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"soloactivos"];
    [viewController.navigationController popToViewController:[viewController.navigationController.viewControllers objectAtIndex:0] animated:YES];
    
    return YES;
}

@end
