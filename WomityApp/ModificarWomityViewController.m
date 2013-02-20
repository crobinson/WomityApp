//
//  ModificarWomityViewController.m
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/20/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "ModificarWomityViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "popViewContainer.h"
#import "ComentariosViewController.h"

@interface ModificarWomityViewController ()

@end

@implementation ModificarWomityViewController

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
@synthesize vistaPicker3, datawomit, aSesion, vistappal, vistareloj, reloj, vistablanca;

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
    
    [vistareloj setHidden:YES];
    [reloj stopAnimating];
    
    [vistaPicker setFrame:CGRectMake(0,480,320,260)];
    [vistaPicker2 setFrame:CGRectMake(0,480,320,260)];
    [vistaPicker3 setFrame:CGRectMake(0,480,320,260)];
    
    vistagris1.layer.cornerRadius = 10;
    vistagris2.layer.cornerRadius = 10;
    
    //name.clearButtonMode = UITextFieldViewModeWhileEditing;
    picker.showsSelectionIndicator = YES;
    name.text = [[datawomit objectForKey:@"Titulo"] uppercaseString];
    
    NSString* yourString = [[datawomit objectForKey:@"Titulo"] uppercaseString];
    float actualSize = 18.0;
    [yourString sizeWithFont:name.font
                 minFontSize:18
              actualFontSize:&actualSize
                    forWidth:299
               lineBreakMode:name.lineBreakMode];
    
    CGSize size = [yourString sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:actualSize]];
    
    int lines = 0;
    if(size.width > name.frame.size.width){
        float myFloat = size.width / name.frame.size.width;
        NSLog(@"%f",myFloat);
        lines = (int)ceil(myFloat);
        NSLog(@"%i",lines);
        name.numberOfLines = lines;
        name.frame = CGRectMake(name.frame.origin.x, name.frame.origin.y, name.frame.size.width, name.frame.size.height * lines);
    }
    
    vistablanca.frame = CGRectMake(vistablanca.frame.origin.x, name.frame.size.height + name.frame.origin.y + 20, vistablanca.frame.size.width, vistablanca.frame.size.height);

   // descripcion.text = [datawomit objectForKey:@"Descripcion"];
    
    NSDate *date = [NSDate date];
    int secondsNow =(int)[date timeIntervalSince1970];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *hastaDate = [dateFormat dateFromString:[datawomit objectForKey:@"FechaCaducidad"]];

    int secondsTarget=(int)[hastaDate timeIntervalSince1970];
    int differenceSeconds=secondsTarget-secondsNow;
    int days=(int)((double)differenceSeconds/(3600.0*24.00));
    int diffDay=differenceSeconds-(days*3600*24);
    int hours=(int)((double)diffDay/3600.00);
    int diffMin=diffDay-(hours*3600);
    int minutess=(int)(diffMin/60.0);
    int seconds=diffMin-(minutess*60);
    
    [day setTitle:[NSString stringWithFormat:@"%i",days] forState:0];
    if(days<0)
        [day setTitle:[NSString stringWithFormat:@"%i",1] forState:0];

    
    [hour setTitle:[NSString stringWithFormat:@"%i",hours] forState:0];
    if(hours<0)
        [hour setTitle:[NSString stringWithFormat:@"%i",0] forState:0];

    [minutes setTitle:[NSString stringWithFormat:@"%i",minutess] forState:0];
    if(minutess<0)
        [minutes setTitle:[NSString stringWithFormat:@"%i",0] forState:0];

    
    UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapGestureRecognized:)];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* gestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapGestureRecognized:)];
    gestureRecognizer2.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer* gestureRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapGestureRecognized:)];
    gestureRecognizer3.cancelsTouchesInView = NO;
    
    
    [picker addGestureRecognizer:gestureRecognizer];
    
    /*UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarPicker)];
     
     [picker addGestureRecognizer:doubleTap];
     */
    picker2.showsSelectionIndicator = YES;
    
    UITapGestureRecognizer *doubleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarPicker)];
    
    [picker2 addGestureRecognizer:gestureRecognizer2];
    
    picker3.showsSelectionIndicator = YES;
    UITapGestureRecognizer *doubleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarPicker)];
    
    [picker3 addGestureRecognizer:gestureRecognizer3];
    
    arrayColors = [[NSMutableArray alloc] init];
    [arrayColors addObject:@"Dias"];
    for(int i=1;i< 32; i++){
    	NSString *day1 = [NSString stringWithFormat:@"%d",i];
        [arrayColors addObject:day1];
    }
    
    arrayHoras = [[NSMutableArray alloc] init];
    [arrayHoras addObject:@"Horas"];
    for(int i=0;i< 24; i++){
    	NSString *hora = [NSString stringWithFormat:@"%d",i];
        [arrayHoras addObject:hora];
    }
    
    arrayMinutos = [[NSMutableArray alloc] init];
    [arrayMinutos addObject:@"Minutos"];
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
    CGRect selectorFrame = CGRectInset( frame, 0.0, picker.bounds.size.height * 0.85 / 2.0 );
    
    if( CGRectContainsPoint( selectorFrame, touchPoint) )
    {
        [self quitarPicker];
    }
}
- (void)pickerViewTapGestureRecognized2:(UITapGestureRecognizer*)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:gestureRecognizer.view.superview];
    
    CGRect frame = picker2.frame;
    CGRect selectorFrame = CGRectInset( frame, 0.0, picker2.bounds.size.height * 0.85 / 2.0 );
    
    if( CGRectContainsPoint( selectorFrame, touchPoint) )
    {
        [self quitarPicker];
    }
}
- (void)pickerViewTapGestureRecognized3:(UITapGestureRecognizer*)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:gestureRecognizer.view.superview];
    
    CGRect frame = picker3.frame;
    CGRect selectorFrame = CGRectInset( frame, 0.0, picker3.bounds.size.height * 0.85 / 2.0 );
    
    if( CGRectContainsPoint( selectorFrame, touchPoint) )
    {
        [self quitarPicker];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
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
    vistappal.frame = CGRectMake(vistappal.frame.origin.x,  - 70, vistappal.frame.size.width, vistappal.frame.size.height);
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistaPicker setFrame:CGRectMake(0,205,320,260)];
    
    [UIView commitAnimations];
    
}

- (IBAction)mostrarPicker2:(id)sender{
    [self quitarPicker];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    vistappal.frame = CGRectMake(vistappal.frame.origin.x,  - 70, vistappal.frame.size.width, vistappal.frame.size.height);
    [UIView commitAnimations];
    //NSLog(@"mostrar picker");
    //picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    //[self.view addSubview:picker];
    //[self.view bringSubviewToFront:vistaPicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistaPicker2 setFrame:CGRectMake(0,205,320,260)];
    
    [UIView commitAnimations];
    
}

- (IBAction)mostrarPicker3:(id)sender{
    [self quitarPicker];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    vistappal.frame = CGRectMake(vistappal.frame.origin.x,  - 70, vistappal.frame.size.width, vistappal.frame.size.height);
    [UIView commitAnimations];
    //NSLog(@"mostrar picker");
    //picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    //[self.view addSubview:picker];
    //[self.view bringSubviewToFront:vistaPicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistaPicker3 setFrame:CGRectMake(0,205,320,260)];
    
    [UIView commitAnimations];
    
}



- (IBAction)siguiente:(id)sender{
    
    responseData = [NSMutableData data];
    [vistareloj setHidden:NO];
    [reloj startAnimating];
    if([name.text isEqualToString:@""]){
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"Debes colocar el nombre del womit" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }else{
        
        
        NSString *permiso = @"1";
        
        if([[datawomit objectForKey:@"PermisoOpciones"] isEqualToString:@"N"]){
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
        
        NSString *post = [NSString stringWithFormat:@"&idSession=%@&idWomity=%@&Titulo=%@&Descripcion=%@&Dias=%@&Horas=%@&Minutos=%@&PermisoOpciones=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"id"], [datawomit objectForKey:@"idWomity"],name.text, [datawomit objectForKey:@"Descripcion"], diasval, horasval, minval, permiso];
        NSLog(@"%@",post);
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/modificarWomity"]]];
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
    //[self performSegueWithIdentifier:@"loguearse" sender:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    
    json = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
    NSLog(@"%@",json);
    
    
    
    
    
    
    if([[json objectForKey:@"boolWomity"] isEqualToString:@"true"]){
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Womit actualizado correctamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        
    }else{
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:[json objectForKey:@"strMensaje"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        if([[json objectForKey:@"strMensaje"] isEqualToString:@"WomitNoPerteneceAUsuario"])
            alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"No tienes permiso para modificar el womit" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alerta show];
    }
    
    [vistareloj setHidden:YES];
    [reloj stopAnimating];
    
    [self dismissModalViewControllerAnimated:YES];
}


// [self.navigationController performSegueWithIdentifier:@"crearwomity2" sender:nil];




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

- (IBAction)cancel:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
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
