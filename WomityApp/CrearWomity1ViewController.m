//
//  CrearWomity1ViewController.m
//  WomityApp
//
//  Created by Eduardo Rodriguez Macmini on 11/16/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "CrearWomity1ViewController.h"
#import "CrearWomity2ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "popViewContainer.h"
#import "ComentariosViewController.h"


@interface CrearWomity1ViewController ()

@end

@implementation CrearWomity1ViewController


@synthesize name;
@synthesize descripcion;
@synthesize day;
@synthesize hour;
@synthesize minutes;
@synthesize switch1;
@synthesize save;
@synthesize picker;
@synthesize picker2;
@synthesize picker3;
@synthesize vistaPicker;
@synthesize vistaPicker2;
@synthesize vistaPicker3, placeholder1, placeholder2, vistappal, vistareloj, reloj, pickerView;

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
}*/

-(IBAction)ShowSettings:(id)sender{
    
    
    
    if (ishide){
        [self unHideWindow];
        ishide = NO;
    }else{
        [self hideWindow];
        ishide = YES;
    }
}


-(void)hideWindow{
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [vistappal removeGestureRecognizer:Taptable];

    [vistappal setFrame:CGRectMake(0,45,320,368)];
    
    [UIView commitAnimations];
    
}

-(void)unHideWindow{
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [vistappal addGestureRecognizer:Taptable];

    //self.navigationController.view
    [vistappal setFrame:CGRectMake(238,45,320,368)];
    
    [UIView commitAnimations];
}

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

-(void) viewWillAppear:(BOOL)animated{
    ishide = YES;
    
    self.tabBarController.delegate = self;
    [vistaPicker setFrame:CGRectMake(0,480,320,260)];
    [vistaPicker2 setFrame:CGRectMake(0,480,320,260)];
    [vistaPicker3 setFrame:CGRectMake(0,480,320,260)];
    [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"soloactivos"];
      if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"accioncrear"] isEqualToString:@"modificar"])
      {
          name.text = @"";
          descripcion.text = @"";
          [day setTitle:@"1" forState:0];
          [hour setTitle:@"0" forState:0];
          [minutes setTitle:@"0" forState:0];
      }
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"accionnavegar"] isEqualToString:@"nuevo"]){
        
        [[NSUserDefaults standardUserDefaults] setValue:@"viejo" forKey:@"accionnavegar"];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
        [[NSUserDefaults standardUserDefaults] setValue:@"ppal" forKey:@"accionppal"];
        //UITabBarController *tabBarController = self.tabBarController;
        //tabBarController.selectedIndex = 1;
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    datawomit = [[NSMutableDictionary alloc] init];
    Taptable = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideWindow)];
    
    UIImage *img = [UIImage imageNamed:@"iconTABcrear.png"];
    UIImageView * activeOverlay = [[UIImageView alloc] initWithImage:img];
    activeOverlay.frame = CGRectMake(3.0f+34.0f*(1),5.0f,34.0f,28.0f);
    [self.tabBarController.tabBar addSubview:activeOverlay];
    [self.tabBarController.tabBar bringSubviewToFront:activeOverlay];
    
    UIImage *img1 = [UIImage imageNamed:@"iconTABamigos.png"];
    UIImageView * activeOverlay1 = [[UIImageView alloc] initWithImage:img1];
    activeOverlay1.frame = CGRectMake(11.0f+34.0f*(7),5.0f,34.0f,28.0f);
    [self.tabBarController.tabBar addSubview:activeOverlay1];
    [self.tabBarController.tabBar bringSubviewToFront:activeOverlay1];
    
    pickerView.showsSelectionIndicator = YES;
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarPicker)];
    
    [pickerView addGestureRecognizer:doubleTap];
    
    [vistareloj setHidden:YES];
    [reloj stopAnimating];
    name.layer.cornerRadius = 10;
    descripcion.layer.cornerRadius = 10;
    
    vistagris1.layer.cornerRadius = 10;
    vistagris2.layer.cornerRadius = 10;
    
    name.clearButtonMode = UITextFieldViewModeWhileEditing;
    picker.showsSelectionIndicator = YES;
    
    UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapGestureRecognized:)];
    gestureRecognizer.cancelsTouchesInView = NO;

    UITapGestureRecognizer* gestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapGestureRecognized:)];
    gestureRecognizer2.cancelsTouchesInView = NO;

    UITapGestureRecognizer* gestureRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapGestureRecognized:)];
    gestureRecognizer3.cancelsTouchesInView = NO;
    
    //[picker addGestureRecognizer:gestureRecognizer];
    
    //UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarPicker)];
    
    [picker addGestureRecognizer:gestureRecognizer];
    
    picker2.showsSelectionIndicator = YES;
    
    UITapGestureRecognizer *doubleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarPicker)];
    
    [picker2 addGestureRecognizer:gestureRecognizer2];
    
    picker3.showsSelectionIndicator = YES;
    UITapGestureRecognizer *doubleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarPicker)];
    
    [picker3 addGestureRecognizer:gestureRecognizer3];
    
    arrayColors = [[NSMutableArray alloc] init];
    //[arrayColors addObject:@"Dias"];
    for(int i=1;i< 32; i++){
    	NSString *day1 = [NSString stringWithFormat:@"%d",i];
        [arrayColors addObject:day1];
    }
    
    arrayHoras = [[NSMutableArray alloc] init];
    //[arrayHoras addObject:@"Horas"];
    for(int i=0;i< 24; i++){
    	NSString *hora = [NSString stringWithFormat:@"%d",i];
        [arrayHoras addObject:hora];
    }
    
    arrayMinutos = [[NSMutableArray alloc] init];
   //[arrayMinutos addObject:@"Minutos"];
    for(int i=0;i< 11; i++){
    	NSString *minutos = [NSString stringWithFormat:@"%d",i * 5];
        [arrayMinutos addObject:minutos];
    }
    
    [picker selectedRowInComponent:0];
    [picker2 selectedRowInComponent:0];
    [picker3 selectedRowInComponent:0];
    
}

- (void)pickerViewTapGestureRecognized:(UITapGestureRecognizer*)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:gestureRecognizer.view.superview];
    
    CGRect frame = picker.frame;
    CGRect selectorFrame = CGRectInset( frame, 0.0, picker.bounds.size.height* 0.85 / 2.0 );
    
    if( CGRectContainsPoint( selectorFrame, touchPoint) )
    {
        [self quitarPicker];
    }
}
- (void)pickerViewTapGestureRecognized2:(UITapGestureRecognizer*)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:gestureRecognizer.view.superview];
    
    CGRect frame = picker2.frame;
    CGRect selectorFrame = CGRectInset( frame, 0.0, picker2.bounds.size.height* 0.85 / 2.0 );
    
    if( CGRectContainsPoint( selectorFrame, touchPoint) )
    {
        [self quitarPicker];
    }
}
- (void)pickerViewTapGestureRecognized3:(UITapGestureRecognizer*)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:gestureRecognizer.view.superview];
    
    CGRect frame = picker3.frame;
    CGRect selectorFrame = CGRectInset( frame, 0.0, picker3.bounds.size.height* 0.85 / 2.0);
    
    if( CGRectContainsPoint( selectorFrame, touchPoint) )
    {
        [self quitarPicker];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        //[self mostrarPickernext];
        
        return NO;
    }
    
    return YES;
}


- (void)viewDidUnload
{
       [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (IBAction)mostrarPicker:(id)sender{
    //NSLog(@"mostrar picker");
    //picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    //[self.view addSubview:picker];
    //[self.view bringSubviewToFront:vistaPicker];
   
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    vistappal.frame = CGRectMake(vistappal.frame.origin.x,  - 75, vistappal.frame.size.width, vistappal.frame.size.height);
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistaPicker setFrame:CGRectMake(0,165,320,260)];
    
    [UIView commitAnimations];
    
}

- (IBAction)mostrarPicker2:(id)sender{
    [self quitarPicker];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    vistappal.frame = CGRectMake(vistappal.frame.origin.x,  - 75, vistappal.frame.size.width, vistappal.frame.size.height);
    [UIView commitAnimations];
    //NSLog(@"mostrar picker");
    //picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    //[self.view addSubview:picker];
    //[self.view bringSubviewToFront:vistaPicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistaPicker2 setFrame:CGRectMake(0,165,320,260)];
    
    [UIView commitAnimations];
    
}

- (IBAction)mostrarPicker3:(id)sender{
    [self quitarPicker];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    vistappal.frame = CGRectMake(vistappal.frame.origin.x,  - 75, vistappal.frame.size.width, vistappal.frame.size.height);
    [UIView commitAnimations];
    //NSLog(@"mostrar picker");
    //picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    //[self.view addSubview:picker];
    //[self.view bringSubviewToFront:vistaPicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistaPicker3 setFrame:CGRectMake(0,165,320,260)];
    
    [UIView commitAnimations];
    
}


- (void)mostrarPickernext{
    //NSLog(@"mostrar picker");
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    vistappal.frame = CGRectMake(vistappal.frame.origin.x,  - 75, vistappal.frame.size.width, vistappal.frame.size.height);
    [UIView commitAnimations];
    //picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    //[self.view addSubview:picker];
    //[self.view bringSubviewToFront:vistaPicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistaPicker setFrame:CGRectMake(0,165,320,260)];
    
    [UIView commitAnimations];
    
}

- (void)mostrarPicker2next{
    [self quitarPicker];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    vistappal.frame = CGRectMake(vistappal.frame.origin.x,  - 75, vistappal.frame.size.width, vistappal.frame.size.height);
    [UIView commitAnimations];
    //NSLog(@"mostrar picker");
    //picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    //[self.view addSubview:picker];
    //[self.view bringSubviewToFront:vistaPicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistaPicker2 setFrame:CGRectMake(0,165,320,260)];
    
    [UIView commitAnimations];
    
}

- (void)mostrarPicker3next{
    [self quitarPicker];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    vistappal.frame = CGRectMake(vistappal.frame.origin.x,  - 75, vistappal.frame.size.width, vistappal.frame.size.height);
    [UIView commitAnimations];
    //NSLog(@"mostrar picker");
    //picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    //[self.view addSubview:picker];
    //[self.view bringSubviewToFront:vistaPicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistaPicker3 setFrame:CGRectMake(0,165,320,260)];
    
    [UIView commitAnimations];
    
}



- (IBAction)quitarPicker{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    vistappal.frame = CGRectMake(vistappal.frame.origin.x, 44, vistappal.frame.size.width, vistappal.frame.size.height);
    [UIView commitAnimations];
    
    //NSLog(@"mostrar picker");
    //picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    //[self.view addSubview:picker];
    //[self.view sendSubviewToBack:vistaPicker];
    //[self.view bringSubviewToFront:vistaPicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistaPicker setFrame:CGRectMake(0,480,320,260)];
    [vistaPicker2 setFrame:CGRectMake(0,480,320,260)];
    [vistaPicker3 setFrame:CGRectMake(0,480,320,260)];
    [UIView commitAnimations];
}

- (IBAction)siguiente:(id)sender{
    
    responseData = [NSMutableData data];
    [vistareloj setHidden:NO];
    [reloj startAnimating];
    if([name.text isEqualToString:@""]){
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"Debes rellenar el nombre del womit" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        [vistareloj setHidden:YES];
        [reloj stopAnimating];
        
    }else{
        
        
        NSString *permiso = @"1";
        
        if(switch1.on){
            permiso=@"1";
        }else{
            permiso=@"0";
        }
        
        NSString *diasval = day.currentTitle;
        NSString *horasval = hour.currentTitle;
        NSString *minval = minutes.currentTitle;
        
        if([diasval isEqualToString:@"Dias"] || [diasval isEqualToString:@"Días"])
            diasval = @"1";
        
        if([horasval isEqualToString:@"Horas"])
            horasval = @"0";
        
        if([minval isEqualToString:@"Minutos"])
            minval = @"0";
        
        NSString *post = [NSString stringWithFormat:@"&idSession=%@&Titulo=%@&Descripcion=%@&Dias=%@&Horas=%@&Minutos=%@&PermisoOpciones=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"id"], name.text, descripcion.text, diasval, horasval, minval, permiso];
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"accioncrear"] isEqualToString:@"modificar"])
            post = [NSString stringWithFormat:@"&idSession=%@&idWomity=%@&Titulo=%@&Descripcion=%@&Dias=%@&Horas=%@&Minutos=%@&PermisoOpciones=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"id"],[json objectForKey:@"idWomity"], name.text, descripcion.text, diasval, horasval, minval, permiso];
        
        
        NSLog(@"%@",post);
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/crearWomity"]]];
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"accioncrear"] isEqualToString:@"modificar"]){
            [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/modificarWomity"]]];
        }
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
    [vistareloj setHidden:YES];
    [reloj stopAnimating];
    
}

- (IBAction)quitarPickerDone:(id)sender
{
    //NSLog(@"mostrar picker");
    //pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    //[self.view addSubview:pickerView];
    //[self.view sendSubviewToBack:vistaPicker];
    //[self.view bringSubviewToFront:vistaPicker];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    vistappal.frame = CGRectMake(vistappal.frame.origin.x, 44, vistappal.frame.size.width, vistappal.frame.size.height);
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistaPicker setFrame:CGRectMake(0,480,320,260)];
    [vistaPicker2 setFrame:CGRectMake(0,480,320,260)];
    [vistaPicker3 setFrame:CGRectMake(0,480,320,260)];
    [UIView commitAnimations];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"accioncrear"] isEqualToString:@"modificar"]){
     json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
 

    NSLog(@"%@",json);
    
    
    if([[json objectForKey:@"boolCrearWomity"] isEqualToString:@"true"]){
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"El womit fue creado con éxito. Continúa para activarlo" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        [[NSUserDefaults standardUserDefaults] setValue:@"modificar" forKey:@"accioncrear"];
    }
    
    }else{
    //WomitActualizadoCorrectamene
         NSLog(@"%@",json);
        
        if([[json objectForKey:@"boolCrearWomity"] isEqualToString:@"true"]){
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"El womit fue actualizado correctamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alerta show];
            [[NSUserDefaults standardUserDefaults] setValue:@"modificar" forKey:@"accioncrear"];
        }
        
    }
        
    [vistareloj setHidden:YES];
    [reloj stopAnimating];
        [self performSegueWithIdentifier:@"crearwomity2" sender:nil];
       }
   
    
   // [self.navigationController performSegueWithIdentifier:@"crearwomity2" sender:nil];


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"crearwomity2"]){
        CrearWomity2ViewController *segueDestination = (CrearWomity2ViewController *)[segue destinationViewController];
        segueDestination.stringTitle = [name.text uppercaseString];
       // segueDestination.aSesion = aSesion;
        segueDestination.idWomit = [json objectForKey:@"idWomity"];
        segueDestination.descripcionLabel.text = descripcion.text;
        

    }
    //vercomentarios
    if ([segue.identifier isEqualToString:@"vercomentarios"]){
        ComentariosViewController *controller = [segue destinationViewController];
        controller.datawomit = datawomit;
        controller.aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
        controller.comentar = YES;
        controller.idWomity = [datawomit objectForKey:@"idWomity"];
        
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thepicker {
	
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	if(thePickerView == picker){
        return [arrayColors count];
    }
    if(thePickerView == picker2){
        return [arrayHoras count];
    }
    if(thePickerView == picker3){
        return [arrayMinutos count];
    }
    
    if(thePickerView == pickerView){
        return [arrayMinutos count];
    }
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if(thePickerView == picker){
        return [arrayColors objectAtIndex:row];
    }
    if(thePickerView == picker2){
        return [arrayHoras objectAtIndex:row];
    }
    if(thePickerView == picker3){
        return [arrayMinutos objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%i",row);
    
    if(pickerView == picker){
        [day setTitle:[arrayColors objectAtIndex:row] forState:0];
    }
    if(pickerView == picker2){
        [hour setTitle:[arrayHoras objectAtIndex:row] forState:0];
    }
    if(pickerView == picker3){
        [minutes setTitle:[arrayMinutos objectAtIndex:row] forState:0];
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if( textField== name)
    {
        //[descripcion becomeFirstResponder];
    }
    
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Dismiss the keyboard when the view outside the text field is touched.
    [name resignFirstResponder];
    [descripcion resignFirstResponder];
    // Revert the text field to the previous value.
    //palabra.text = self.string; 
    [super touchesBegan:touches withEvent:event];
}


- (void)textViewDidChange:(UITextView *)textView{
    if([textView.text isEqualToString:@"\n"])
        textView.text = @"";
    
    if([textView.text isEqualToString:@""]){
        [placeholder1 setHidden:NO];
        [placeholder2 setHidden:NO];
    }else{
        [placeholder1 setHidden:YES];
        [placeholder2 setHidden:YES];
    }
}



-(void)textViewDidEndEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@""]){
        [placeholder1 setHidden:NO];
        [placeholder2 setHidden:NO];
    }else{
        [placeholder1 setHidden:YES];
        [placeholder2 setHidden:YES];
    }
}

-(IBAction) Loadcrear:(id)sender{
    [self hideWindow];
    ishide = YES;
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
    [self hideWindow];
    ishide = YES;
    
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
        popoverController.tabBarController = self.tabBarController;
        popoverController.delegate = self;
        [self.view addSubview:popoverController];
    }else{
        [popoverController fadeOFFEmergency];
        [popoverController removeFromSuperview];
        popoverController = nil;
    }
    
}

- (IBAction)onButtonClick2:(id)sender {
	
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
     datawomit = womit;
    [self performSegueWithIdentifier:@"vercomentarios" sender:self];
   
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    NSLog(@"%@",viewController);
    [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
    [[NSUserDefaults standardUserDefaults] setValue:@"ppal" forKey:@"accionppal"];
    [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"soloactivos"];
    [viewController.navigationController popToViewController:[viewController.navigationController.viewControllers objectAtIndex:0] animated:YES];
    
    return YES;
}
@end
