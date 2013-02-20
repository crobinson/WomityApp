//
//  VotarViewController.m
//  WomityApp
//
//  Created by Carlos Robinson on 11/18/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "VotarViewController.h"
#import "votarCell.h"
#import "popViewContainer.h"
#import "ComentariosViewController.h"

@interface VotarViewController ()

@end

@implementation VotarViewController
@synthesize bocadillo, myscrollView, vistareloj, reloj, aSesion, datawomit, responseData, vistaimagen, botoncerrar;

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
    json = [NSMutableDictionary dictionary];
	// Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated
{
    self.tabBarController.delegate = self;
    for(UIView *subview in [myscrollView subviews]) {
        [subview removeFromSuperview];
    }
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"soloactivos"] isEqualToString:@"true"]){
        [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"soloactivos"];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:NO];
        
    }
    
    [vistareloj setFrame:CGRectMake(0, 44, 320, 440)];
    [reloj startAnimating];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
    NSLog(@"%@",datawomit);
    bocadillo = [UIButton buttonWithType:UIButtonTypeCustom];
    bocadillo.frame = CGRectMake(239, 2, 66, 47);
    bocadillo.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Votar"]];

    UILabel *titulo = [[UILabel alloc] initWithFrame:CGRectMake(11, 5, 217, 25)];
    titulo.text = [[datawomit objectForKey:@"Titulo"] uppercaseString];
    [titulo setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17]];
    titulo.backgroundColor = [UIColor clearColor];
    NSString* yourString = [[datawomit objectForKey:@"Titulo"] uppercaseString];
    float actualSize = 17.0;
    [yourString sizeWithFont:titulo.font
                 minFontSize:17
              actualFontSize:&actualSize
                    forWidth:217
               lineBreakMode:titulo.lineBreakMode];
    
    CGSize size = [yourString sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:actualSize]];
    
    int lines = 0;
    if(size.width > titulo.frame.size.width){
        float myFloat = size.width / titulo.frame.size.width;
        
        lines = (int)ceil(myFloat);
        titulo.numberOfLines = lines;
        titulo.frame = CGRectMake(titulo.frame.origin.x, titulo.frame.origin.y, titulo.frame.size.width, titulo.frame.size.height * lines);
    }
    
    int ancho = 298;
    if(lines<2){
        ancho =  217;
    }
    [myscrollView addSubview:titulo];
    UILabel *descripcion = [[UILabel alloc] initWithFrame:CGRectMake(titulo.frame.origin.x, titulo.frame.origin.y + titulo.frame.size.height, 298, 21)];
    descripcion.text = @"Puntúa de 0 a 5, siendo 5 la máxima puntuación";
    descripcion.backgroundColor = [UIColor clearColor];
    [descripcion setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    descripcion.textColor = [UIColor blackColor];
    
    CGFloat renglon = descripcion.frame.origin.y + descripcion.frame.size.height + 5;
    [myscrollView addSubview:descripcion];
    NSMutableArray *opciones = [datawomit objectForKey:@"Opciones"];
    for (int i=0; i<opciones.count; i++) {
        NSDictionary *opcion = [opciones objectAtIndex:i];
        UIView *vistablanca = [[UIView alloc] initWithFrame:CGRectMake(titulo.frame.origin.x, renglon, 300, 60)];
        vistablanca.backgroundColor = [UIColor clearColor];
        [myscrollView addSubview:vistablanca];
        
        UIImageView *thumbopcion = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 45, 45)];
        NSString *urlimagencompleta = [NSString stringWithFormat:@"http://www.womity.com/%@", [opcion objectForKey:@"URLImagenThumb"]];
        NSURL *url = [NSURL URLWithString:urlimagencompleta];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        thumbopcion.image = image;
        [vistablanca addSubview:thumbopcion];
        
        UIButton *gotoimg = [UIButton buttonWithType:UIButtonTypeCustom];
        gotoimg.frame = CGRectMake(5, 5, 45, 45);
        [gotoimg addTarget:self action:@selector(verimagen:) forControlEvents:UIControlEventTouchUpInside];
        gotoimg.tag = i;
       
        
        UILabel *numeral = [[UILabel alloc] initWithFrame:CGRectMake(7 + thumbopcion.frame.size.width + 5, 10, 20, 12)];
        numeral.text = [NSString stringWithFormat:@"%iº ",i+1];
        numeral.textColor = [UIColor redColor];
        [numeral setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        numeral.backgroundColor = [UIColor clearColor];
        [vistablanca addSubview:numeral];
        
        UILabel *tituloopcion = [[UILabel alloc] initWithFrame:CGRectMake(18 + thumbopcion.frame.size.width + 5 + 8, 10, 200, 15)];
        tituloopcion.text = [NSString stringWithFormat:@" - %@",[opcion objectForKey:@"Nombre"]];
        [tituloopcion setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
        tituloopcion.textColor = [UIColor blackColor];
        tituloopcion.backgroundColor = [UIColor clearColor];
        
        float actualSizeop = 13.0;
        [[opcion objectForKey:@"Nombre"] sizeWithFont:tituloopcion.font
                                          minFontSize:13
                                       actualFontSize:&actualSizeop
                                             forWidth:200
                                        lineBreakMode:tituloopcion.lineBreakMode];
        
        CGSize sizeop = [[opcion objectForKey:@"Nombre"] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:actualSizeop]];
        
        int linesop = 0;
        if(sizeop.width > tituloopcion.frame.size.width){
            float myFloatop = sizeop.width / tituloopcion.frame.size.width;
            
            linesop = (int)ceil(myFloatop);
            NSLog(@"%i",linesop);
            tituloopcion.numberOfLines = linesop;
            tituloopcion.frame = CGRectMake(tituloopcion.frame.origin.x, tituloopcion.frame.origin.y, tituloopcion.frame.size.width, tituloopcion.frame.size.height * linesop);
        }
        
        
        
        
        [vistablanca addSubview:tituloopcion];
        
        UIView *vistacelda = [[UIView alloc] initWithFrame:CGRectMake(thumbopcion.frame.size.width + 5, tituloopcion.frame.origin.y + tituloopcion.frame.size.height, 225, 25)];
        
        votarCell *cell = [[votarCell alloc] initWithFrame:CGRectMake(thumbopcion.frame.size.width + 5, tituloopcion.frame.origin.y + tituloopcion.frame.size.height, 225, 25)];
        [cell.boton0 addTarget:self action:@selector(votocero:) forControlEvents:UIControlEventTouchUpInside];
        [cell.boton1 addTarget:self action:@selector(votouno:) forControlEvents:UIControlEventTouchUpInside];
        [cell.boton2 addTarget:self action:@selector(votodos:) forControlEvents:UIControlEventTouchUpInside];
        [cell.boton3 addTarget:self action:@selector(vototres:) forControlEvents:UIControlEventTouchUpInside];
        [cell.boton4 addTarget:self action:@selector(votocuatro:) forControlEvents:UIControlEventTouchUpInside];
        [cell.boton5 addTarget:self action:@selector(votocinco:) forControlEvents:UIControlEventTouchUpInside];
        cell.boton0.tag = [[opcion objectForKey:@"idOpcion"] intValue];
        cell.boton1.tag = [[opcion objectForKey:@"idOpcion"] intValue];
        cell.boton2.tag = [[opcion objectForKey:@"idOpcion"] intValue];
        cell.boton3.tag = [[opcion objectForKey:@"idOpcion"] intValue];
        cell.boton4.tag = [[opcion objectForKey:@"idOpcion"] intValue];
        cell.boton5.tag = [[opcion objectForKey:@"idOpcion"] intValue];
        
        if ([[opcion objectForKey:@"VotoUsuario"]intValue] == 0) {
            [cell addSubview:cell.radio0];
        }
        if ([[opcion objectForKey:@"VotoUsuario"]intValue] == 1) {
            [cell addSubview:cell.radio1];
        }
        if ([[opcion objectForKey:@"VotoUsuario"]intValue] == 2) {
            [cell addSubview:cell.radio2];
        }
        if ([[opcion objectForKey:@"VotoUsuario"]intValue] == 3) {
            [cell addSubview:cell.radio3];
        }
        if ([[opcion objectForKey:@"VotoUsuario"]intValue] == 4) {
            [cell addSubview:cell.radio4];
        }
        if ([[opcion objectForKey:@"VotoUsuario"]intValue] == 5) {
            [cell addSubview:cell.radio5];
        }
        [vistacelda addSubview:cell];
        [vistablanca addSubview:vistacelda];
         [vistablanca addSubview:gotoimg];
        
        
        vistablanca.frame = CGRectMake(vistablanca.frame.origin.x, vistablanca.frame.origin.y, vistablanca.frame.size.width, tituloopcion.frame.size.height + cell.frame.size.height + 5);
                renglon = renglon + vistablanca.frame.size.height + 10;
    }
    
    bocadillo.frame = CGRectMake(239, renglon, 66, 47);
    [bocadillo addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [myscrollView addSubview:bocadillo];
    
    myscrollView.contentSize = CGSizeMake(0, renglon + 60);
    
    vistareloj.frame = CGRectMake(0, 480, vistareloj.frame.size.width, vistareloj.frame.size.height);
    [reloj stopAnimating];
	// Do any additional setup after loading the view.
}

-(void)votocero:(id) sender
{
    UIButton *temporal = (UIButton *) sender;
    idOpcion = [NSString stringWithFormat:@"%i",temporal.tag];
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject: idOpcion  forKey: @"idOpcion"];
    [data setObject: @"0"  forKey: @"Voto"];
    NSArray *llaves = [data allKeys];
    for (int i=0; i<llaves.count; i++) {
        if([idOpcion isEqualToString:[llaves objectAtIndex:i]]){
            [data removeObserver:data forKeyPath:@"idOpcion"];
        }
    }
    [json setObject: data  forKey: idOpcion];
    
}

-(void)votouno:(id) sender
{
    UIButton *temporal = (UIButton *) sender;
    idOpcion = [NSString stringWithFormat:@"%i",temporal.tag];
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject: idOpcion  forKey: @"idOpcion"];
    [data setObject: @"1"  forKey: @"Voto"];
    NSArray *llaves = [data allKeys];
    for (int i=0; i<llaves.count; i++) {
        if([idOpcion isEqualToString:[llaves objectAtIndex:i]]){
            [data removeObserver:data forKeyPath:@"idOpcion"];
        }
    }
    [json setObject: data  forKey: idOpcion];
    
}
-(void)votodos:(id) sender
{
    UIButton *temporal = (UIButton *) sender;
    idOpcion = [NSString stringWithFormat:@"%i",temporal.tag];
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject: idOpcion  forKey: @"idOpcion"];
    [data setObject: @"2"  forKey: @"Voto"];
    NSArray *llaves = [data allKeys];
    for (int i=0; i<llaves.count; i++) {
        if([idOpcion isEqualToString:[llaves objectAtIndex:i]]){
            [data removeObserver:data forKeyPath:@"idOpcion"];
        }
    }
    [json setObject: data  forKey: idOpcion];
    
}
-(void)vototres:(id) sender
{
    UIButton *temporal = (UIButton *) sender;
    idOpcion = [NSString stringWithFormat:@"%i",temporal.tag];
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject: idOpcion  forKey: @"idOpcion"];
    [data setObject: @"3"  forKey: @"Voto"];
    NSArray *llaves = [data allKeys];
    for (int i=0; i<llaves.count; i++) {
        if([idOpcion isEqualToString:[llaves objectAtIndex:i]]){
            [data removeObserver:data forKeyPath:@"idOpcion"];
        }
    }
    [json setObject: data  forKey: idOpcion];
    
}
-(void)votocuatro:(id) sender
{
    UIButton *temporal = (UIButton *) sender;
    idOpcion = [NSString stringWithFormat:@"%i",temporal.tag];
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject: idOpcion  forKey: @"idOpcion"];
    [data setObject: @"4"  forKey: @"Voto"];
    NSArray *llaves = [data allKeys];
    for (int i=0; i<llaves.count; i++) {
        if([idOpcion isEqualToString:[llaves objectAtIndex:i]]){
            [data removeObserver:data forKeyPath:@"idOpcion"];
        }
    }
    [json setObject: data  forKey: idOpcion];
    NSLog(@"%@", json);
}
-(void)votocinco:(id) sender
{
    UIButton *temporal = (UIButton *) sender;
    idOpcion = [NSString stringWithFormat:@"%i",temporal.tag];
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject: idOpcion  forKey: @"idOpcion"];
    [data setObject: @"5"  forKey: @"Voto"];
    NSArray *llaves = [data allKeys];
    for (int i=0; i<llaves.count; i++) {
        if([idOpcion isEqualToString:[llaves objectAtIndex:i]]){
            [data removeObserver:data forKeyPath:@"idOpcion"];
        }
    }
    NSLog(@"%@", data);
    [json setObject: data  forKey: idOpcion];
    NSLog(@"%@", json);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)done:(id)sender
{
    responseData = [NSMutableData data];
    
    [vistareloj setFrame:CGRectMake(0, 44, 320, 440)];
    [reloj startAnimating];
    NSLog(@"%@",json);
    
    NSArray *llaves = [json allKeys];
    NSMutableString *jsonstring = [[NSMutableString alloc] initWithString:@"{"];
    for (int i=0; i<llaves.count; i++) {
        // NSLog(@"%@",[[json objectForKey:[llaves objectAtIndex:i]] objectForKey:@"idOpcion"]);
        [jsonstring appendString:[NSString stringWithFormat:@"\"%i\":{\"Voto\":\"%@\", \"idOpcion\":\"%@\"}",i, [[json objectForKey:[llaves objectAtIndex:i]] objectForKey:@"Voto"], [[json objectForKey:[llaves objectAtIndex:i]] objectForKey:@"idOpcion"]]];
        if(i<llaves.count - 1)
        {
            [jsonstring appendString:[NSString stringWithFormat:@", "]];
        }
        //[jsonstring stringByAppendingString:[NSString stringWithFormat:@"%i ",i]];
    }
    [jsonstring appendString:[NSString stringWithFormat:@"}"]];
    NSLog(@"%@", jsonstring);
    NSString *idWomity = [datawomit objectForKey:@"idWomity"];
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&idWomity=%@&Votos=%@",aSesion, idWomity, jsonstring];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/Votar"]]];
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
    vistareloj.frame = CGRectMake(0, 480, vistareloj.frame.size.width, vistareloj.frame.size.height);
    [reloj stopAnimating];
    //[self performSegueWithIdentifier:@"loguearse" sender:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    
    NSDictionary* jsonresp = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSLog(@"%@",jsonresp);
    
    if ([[jsonresp objectForKey:@"boolVotoWomity"] isEqualToString:@"true"])
	{
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Tus votos se han guardado correctamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }
    
    
    vistareloj.frame = CGRectMake(0, 480, vistareloj.frame.size.width, vistareloj.frame.size.height);
    [reloj stopAnimating];
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

- (IBAction)verimagen:(id)sender
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    
    //[vistareloj setFrame:CGRectMake(0, 44, 320, 440)];
    //[reloj startAnimating];
    
    for(UIView *subview in [vistaimagen subviews]) {
        [subview removeFromSuperview];
    }
    [vistaimagen addSubview:relojimagen];
    [relojimagen startAnimating];
    [vistaimagen addSubview:botoncerrar];
    vistaimagen.frame = CGRectMake(vistaimagen.frame.origin.x, 0, vistaimagen.frame.size.width, vistaimagen.frame.size.height);
    UIButton *temporal = (UIButton *) sender;
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(insertarImage:) userInfo:temporal repeats:NO];
    
}

-(void)insertarImage:(NSTimer *)timer{
    
    UIButton *temporal = [timer userInfo];
    NSMutableArray *opciones = [datawomit objectForKey:@"Opciones"];
    NSDictionary *dictionary2 = [opciones objectAtIndex:temporal.tag];
    NSString *urlimagencompleta = [NSString stringWithFormat:@"http://www.womity.com/%@", [dictionary2 objectForKey:@"URLImagen"]];
    
    if([[dictionary2 objectForKey:@"URLImagenThumb"] isEqualToString:@"/uploads/images/blank_img.png"] || [[dictionary2 objectForKey:@"URLImagen"] isEqualToString:@"uploads/images/"] || [[dictionary2 objectForKey:@"URLImagen"] isEqualToString:@""] )
        urlimagencompleta = [NSString stringWithFormat:@"http://www.womity.com/%@", [dictionary2 objectForKey:@"URLImagenThumb"]];
    
    NSURL *url = [NSURL URLWithString:urlimagencompleta];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *imagenthumb = [UIImage imageWithData:data];
    
    UIImageView *temporalimg = [[UIImageView alloc] initWithImage:imagenthumb];
    
    float alto=0;
    float ancho=0;
    if(temporalimg.frame.size.width > 320){
        alto = temporalimg.frame.size.height*320/temporalimg.frame.size.width;
        ancho = 320;
        
        if(alto > 430){
            ancho = temporalimg.frame.size.width*480/temporalimg.frame.size.height;
            alto = 430;
        }
        
    }else{
        if(temporalimg.frame.size.height > 430){
            ancho = temporalimg.frame.size.width*430/temporalimg.frame.size.height;
            alto = 430;
        }else{
            alto = temporalimg.frame.size.height;
            ancho = temporalimg.frame.size.width;
        }
    }
    UIImageView *vistaimg = [[UIImageView alloc] initWithFrame:CGRectMake((320-ancho)/2, (430-alto)/2, ancho, alto)];
    NSLog(@"%f, %f, %f, %f",vistaimg.frame.origin.x, vistaimg.frame.origin.y, vistaimg.frame.size.width, vistaimg.frame.size.height);
    vistaimg.image = imagenthumb;
    [vistaimagen addSubview:vistaimg];
    [vistaimagen bringSubviewToFront:botoncerrar];
    //[imagengrande setImage:[UIImage imageWithData:datapic]];
    
    //[vistareloj setFrame:CGRectMake(0, 480, 320, 440)];
    [relojimagen stopAnimating];
    
    [UIView commitAnimations];
    
}


/*
- (IBAction)verimagen:(id)sender
{
    [vistareloj setFrame:CGRectMake(0, 44, 320, 440)];
    [reloj startAnimating];
    
    for(UIView *subview in [vistaimagen subviews]) {
        [subview removeFromSuperview];
    }
    [vistaimagen addSubview:botoncerrar];
    vistaimagen.frame = CGRectMake(vistaimagen.frame.origin.x, 0, vistaimagen.frame.size.width, vistaimagen.frame.size.height);
    UIButton *temporal = (UIButton *) sender;
    NSMutableArray *opciones = [datawomit objectForKey:@"Opciones"];
    NSDictionary *dictionary2 = [opciones objectAtIndex:temporal.tag];
    NSLog(@"%@",dictionary2);
    NSString *urlimagencompleta = [NSString stringWithFormat:@"http://www.womity.com/%@", [dictionary2 objectForKey:@"URLImagen"]];
    NSURL *url = [NSURL URLWithString:urlimagencompleta];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *imagenthumb = [UIImage imageWithData:data];
    
    // UIImage *imagenthumb = [dictionary2 objectForKey:@"image"];
    
    UIImageView *temporalimg = [[UIImageView alloc] initWithImage:imagenthumb];
    
    float alto=0;
    float ancho=0;
    if(temporalimg.frame.size.width > 320){
        alto = temporalimg.frame.size.height*320/temporalimg.frame.size.width;
        ancho = 320;
        
        if(alto > 430){
            ancho = temporalimg.frame.size.width*480/temporalimg.frame.size.height;
            alto = 430;
        }
        
    }else{
        if(temporalimg.frame.size.height > 430){
            ancho = temporalimg.frame.size.width*430/temporalimg.frame.size.height;
            alto = 430;
        }else{
            
            ancho = 320;
            alto = temporalimg.frame.size.height*320/temporalimg.frame.size.width;
            if(alto > 430){
                ancho = temporalimg.frame.size.width*480/temporalimg.frame.size.height;
                alto = 430;
            }
        }
    }
    
    UIImageView *vistaimg = [[UIImageView alloc] initWithFrame:CGRectMake((320-ancho)/2, (430-alto)/2, ancho, alto)];
    NSLog(@"%f, %f, %f, %f",vistaimg.frame.origin.x, vistaimg.frame.origin.y, vistaimg.frame.size.width, vistaimg.frame.size.height);
    vistaimg.image = imagenthumb;
    [vistaimagen addSubview:vistaimg];
    [vistaimagen bringSubviewToFront:botoncerrar];
    //[imagengrande setImage:[UIImage imageWithData:datapic]];
    
    [vistareloj setFrame:CGRectMake(0, 480, 320, 440)];
    [reloj stopAnimating];
    
}
*/
- (IBAction)cerrarimagen:(id)sender
{
    vistaimagen.frame = CGRectMake(vistaimagen.frame.origin.x, vistaimagen.frame.origin.y + 480, vistaimagen.frame.size.width, vistaimagen.frame.size.height);
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    
    
    [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"soloactivos"];
    [viewController.navigationController popToViewController:[viewController.navigationController.viewControllers objectAtIndex:0] animated:YES];
    
    if([viewController isEqual:self.navigationController]){
        
        [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
        [[NSUserDefaults standardUserDefaults] setValue:@"ppal" forKey:@"accionppal"];
        
        //UITabBarController *tabBarController = self.tabBarController;
        //tabBarController.selectedIndex = 1;
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:NO];

        
    }
    
    return YES;
}


- (void)viewDidUnload {
    relojimagen = nil;
    [super viewDidUnload];
}
@end
