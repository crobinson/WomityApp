//
//  CrearWomity2ViewController.m
//  WomityApp
//
//  Created by Eduardo Rodriguez on 17/11/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "CrearWomity2ViewController.h"
#import "OptionCell.h"
#import "invitarViewController.h"
#import "ModificarOpcionViewController.h"
#import "UIImage+Resize.h"
#import "popViewContainer.h"
#import "TerminosViewController.h"
#import "ComentariosViewController.h"
#import "urlViewController.h"

#define radians(degrees) (degrees * M_PI/180)

@interface CrearWomity2ViewController ()

@end


@implementation CrearWomity2ViewController

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
@synthesize otrosLabel, responseData, aSesion, opcion, idWomit, placeholder1, placeholder2, vistaimagen, imagengrande, botoncerrar;
@synthesize scrollView;

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
    [scrollView removeGestureRecognizer:Taptable];

    [scrollView setFrame:CGRectMake(0,45,320,368)];
    
    [UIView commitAnimations];
    
}

-(void)unHideWindow{
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    [scrollView addGestureRecognizer:Taptable];

    //self.navigationController.view
    [scrollView setFrame:CGRectMake(238,45,320,368)];
    
    [UIView commitAnimations];
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

 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.


 - (void)viewDidLoad
 {
 [super viewDidLoad];
     ishide = YES;
     image = NULL;
     reload = YES;
     reloadtable = YES;
     self.tabBarController.delegate = self;
    
     UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarTeclado)];
     
    // [scrollView addGestureRecognizer:tapScroll];
     
     Taptable = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideWindow)];

     
     tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

     womityname.text = stringTitle;
     [womityname setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:15]];
     array = [[NSMutableArray alloc] init];
      fofoOpcion.image = [UIImage imageNamed:@"icono2.png"];
     //scrollView.contentSize = CGSizeMake(0, 500);
     tableView.scrollEnabled = NO;
     
    webViewBK.layer.cornerRadius = 8;
    counterLabel.layer.cornerRadius = 8;
    nameView.layer.cornerRadius = 8;
    descriptionView.layer.cornerRadius = 8;
    imagenView.layer.cornerRadius = 8;
     
     //tamanotable = 0;
     
 }


- (void)viewDidUnload
{
    [self setNombreLabel:nil];
    [self setDescripcionLabel:nil];
    [self setImagenLabel:nil];
    [self setWebLabel:nil];
    [self setOtrosLabel:nil];
    [self setFofoOpcion:nil];
    [self setReloj:nil];
    [self setVistareloj:nil];
    relojimagen = nil;
    botonguardar = nil;
    botonfinalizar = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated{
     [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"soloactivos"];
  
    [vistareloj setFrame:CGRectMake(0,0,320,416)];
    
    
    array = [[NSMutableArray alloc] init];

    [reloj startAnimating];
    image = NULL;
    
    
    //if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"accioncrear"] isEqualToString:@"modificar"] && reload==YES){
        
        //tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, 0);
        
        scrollView.contentSize = CGSizeMake(0, 500);
       
        responseData = [NSMutableData data];
        //idWomity = [datawomit objectForKey:@"idWomity"];
        aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
        NSString *post = [NSString stringWithFormat:@"&idSession=%@&womit_id=%@",aSesion, idWomit];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/getOneWomit"]]];
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
    
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"accioncrear"] isEqualToString:@"crear"])
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"crear" forKey:@"accioncrear"];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (IBAction)login:(id)sender{
    
    
}

-(IBAction)agregarEmergency{
    dictionary = [NSDictionary dictionaryWithObjectsAndKeys:nombreLabel.text,@"name",descripcionLabel.text,@"descripción",webLabel.text,@"link",imagePhoto.image,@"image",nil];
    [array addObject:dictionary];
    
    //NSLog(@"%@",array);
    
    imagePhoto.image =[UIImage imageNamed:@"icono1.png"];
    nombreLabel.text = @"";
    descripcionLabel.text = @"";
    otrosLabel.text = @"";
    webLabel.text = @"";
    fofoOpcion.image = [UIImage imageNamed:@"icono2.png"];
    counter = [array count]+1;
    counterLabel.text = [NSString stringWithFormat:@"%i",counter ];
    [tableView reloadData];
}

-(IBAction)agregar:(id)sender{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistareloj setFrame:CGRectMake(0,0,320,416)];
    [UIView commitAnimations];
    [reloj startAnimating];
    tamanotable = 0;
    siguiente = @"agregar";
    responseData = [NSMutableData data];
    
    //NSString *post = [NSString stringWithFormat:@"&idSession=%@&idWomity=%@&Nombre=%@&Descripcion=%@&Imagen=%@&Web=%@&Otros=%@",aSesion, [opcion objectForKey:@"idWomity"], nombreLabel.text, descripcionLabel.text, imagenLabel.text, webLabel.text, otrosLabel.text];

    
    
    
    
    [nombreLabel resignFirstResponder];
    [descripcionLabel resignFirstResponder];
    [webLabel resignFirstResponder];
    [otrosLabel resignFirstResponder];
    
    NSString *urlString = @"http://www.womity.com/ws/crearOpcionWomity";
    
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
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    }else{
        UIImage *imagentemp = [UIImage imageWithData:image];
        
        UIImage *scaledImage = [imagentemp resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(imagentemp.size.width, imagentemp.size.height) interpolationQuality:kCGInterpolationHigh];
        image = UIImageJPEGRepresentation(scaledImage, 0.1);
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"Imagen\"; filename=\".png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        // NSLog(@"%@",image);
        
        [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:image]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    //if(image != NULL){
    
    
    //}
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
    [vistareloj setFrame:CGRectMake(0,416,320,416)];
    [reloj stopAnimating];
}

-(void)armoopciones
{
    NSMutableArray *opciones = array;
    NSLog(@"%@",opciones);
    float renglon=501;
    counterLabel.text = [NSString stringWithFormat:@"%i",opciones.count + 1];
    for(int i=0; i<[opciones count]; i++){
        NSMutableDictionary *opcionactual = [opciones objectAtIndex:i];
        UIView *vistablancappal = [[UIView alloc] initWithFrame:CGRectMake(7, renglon, 307, 545)];
        vistablancappal.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:vistablancappal];
    
        UILabel *opcionbold = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, 49, 19)];
        opcionbold.text = @"OPCIÓN";
        [opcionbold setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]];
        [vistablancappal addSubview:opcionbold];
        
        UILabel *posicion = [[UILabel alloc] initWithFrame:CGRectMake(58, 2, 250, 19)];
        posicion.text = [NSString stringWithFormat:@"%i - %@",i+1, [opcionactual objectForKey:@"name"]];
        [posicion setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:13]];
        posicion.textColor = [UIColor redColor];
        
        [vistablancappal addSubview:posicion];
        
        UIImageView *imageviewthumb = [[UIImageView alloc] initWithFrame:CGRectMake(10, 31, 38, 38)];
        imageviewthumb.image  = [opcionactual valueForKey:@"image"];
        
        if(![opcionactual valueForKey:@"image"])
             imageviewthumb.image  = [UIImage imageNamed:@"icono1.png"];
        
        [vistablancappal addSubview:imageviewthumb];
        
        
        UILabel *descripcionbold = [[UILabel alloc] initWithFrame:CGRectMake(55, 24, 200, 21)];
        descripcionbold.text = @"DESCRIPCIÓN:";
        [descripcionbold setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
        [vistablancappal addSubview:descripcionbold];
        
        UILabel *descripcionopcion = [[UILabel alloc] initWithFrame:CGRectMake(55, 40, 250, 17)];
        descripcionopcion.text = [opcionactual objectForKey:@"description"];
        [descripcionopcion setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        descripcionopcion.textColor = [UIColor blackColor];
        descripcionopcion.backgroundColor = [UIColor clearColor];
        
        float actualSized = 12.0;
        [[opcionactual objectForKey:@"description"] sizeWithFont:descripcionopcion.font
                                               minFontSize:12
                                            actualFontSize:&actualSized
                                                  forWidth:245
                                             lineBreakMode:descripcionopcion.lineBreakMode];
        
        CGSize sized = [[opcionactual objectForKey:@"description"] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:actualSized]];
        
        int linesd = 0;
        
        if(sized.width > descripcionopcion.frame.size.width){
            float myFloatd = sized.width / descripcionopcion.frame.size.width;
            
            linesd = (int)ceil(myFloatd);
            
            descripcionopcion.numberOfLines = linesd;
            
            
            descripcionopcion.frame = CGRectMake(descripcionopcion.frame.origin.x, descripcionopcion.frame.origin.y , descripcionopcion.frame.size.width, descripcionopcion.frame.size.height * linesd);
        }
        
        [vistablancappal addSubview:descripcionopcion];
        
        
        UILabel *webbold = [[UILabel alloc] initWithFrame:CGRectMake(55, descripcionopcion.frame.origin.y + descripcionopcion.frame.size.height + 5, 42, 21)];
        webbold.text = @"WEB:";
        [webbold setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
        [vistablancappal addSubview:webbold];
        
        UILabel *web = [[UILabel alloc] initWithFrame:CGRectMake(55, descripcionopcion.frame.origin.y + descripcionopcion.frame.size.height + 18, 200, 21)];
        web.text = [opcionactual valueForKey:@"link"];
        [web setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
        web.backgroundColor = [UIColor clearColor];
        [vistablancappal addSubview:web];
        
        UIButton *botonweb = [UIButton buttonWithType:UIButtonTypeCustom];
        botonweb.frame = web.frame;
        botonweb.tag = i;
        [botonweb addTarget:self action:@selector(gotoweb:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *botonimg = [UIButton buttonWithType:UIButtonTypeCustom];
        botonimg.frame = imageviewthumb.frame;
        botonimg.tag = i;
        [botonimg addTarget:self action:@selector(verimagen:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [vistablancappal addSubview:botonweb];
        [vistablancappal addSubview:botonimg];
        
        UIView *vistagris = [[UIView alloc] initWithFrame:CGRectMake(0, web.frame.origin.y + web.frame.size.height + 20, 307, 20)];
        vistagris.backgroundColor = [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1];
        [vistablancappal addSubview:vistagris];
        
        UILabel *modificar = [[UILabel alloc] initWithFrame:CGRectMake(209, 0, 58, 21)];
        modificar.text = @"Modificar";
        [modificar setFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
        modificar.textColor = [UIColor redColor];
        modificar.backgroundColor = [UIColor clearColor];
        [vistagris addSubview:modificar];
        
        UILabel *eliminar = [[UILabel alloc] initWithFrame:CGRectMake(267, 0, 43, 21)];
        eliminar.text = @"Borrar";
        eliminar.textColor = [UIColor redColor];
        eliminar.backgroundColor = [UIColor clearColor];
        [eliminar setFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
        [vistagris addSubview:eliminar];
        
        
        UIButton *botonmod = [UIButton buttonWithType:UIButtonTypeCustom];
        botonmod.frame = modificar.frame;
        botonmod.tag = i;
        [botonmod addTarget:self action:@selector(CallModify:) forControlEvents:UIControlEventTouchUpInside];
        [vistagris addSubview:botonmod];
        
        UIButton *botondel = [UIButton buttonWithType:UIButtonTypeCustom];
        botondel.frame = eliminar.frame;
        botondel.tag = i;
        [botondel addTarget:self action:@selector(CallDelete:) forControlEvents:UIControlEventTouchUpInside];
        [vistagris addSubview:botondel];
        
        vistablancappal.frame=CGRectMake(7, renglon, 307, vistagris.frame.origin.y + vistagris.frame.size.height);
        renglon = renglon + vistablancappal.frame.size.height;
        
        //[NSString stringWithFormat:@"%i",indexPath.row +1];
    }
    
    scrollView.contentSize = CGSizeMake(0, renglon + 10);
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    reload = YES;
    [scrollView scrollRectToVisible:CGRectMake(0,0,scrollView.frame.size.width,scrollView.frame.size.height) animated:NO];
    scrollView.contentOffset = CGPointMake(0, 0);
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    
    NSString *urlconexion = [NSString stringWithFormat:@"%@",connection.currentRequest.URL];
    if([urlconexion isEqualToString:@"http://www.womity.com/ws/getOneWomit"])
    {
        NSArray *arrayjson = json;
        NSLog(@"%@",json);
        NSDictionary *datawomity = [arrayjson objectAtIndex:0];
        datawomit2 = datawomity;
        
        
        
        NSMutableArray *opciones = [datawomit2 objectForKey:@"Opciones"];
        for (int i=0; i<opciones.count; i++) {
            NSDictionary *opciontemp = [opciones objectAtIndex:i];
            NSString *stringID = [opciontemp valueForKey:@"idOpcion"];
            
            NSString *urlimagencompleta = [NSString stringWithFormat:@"http://www.womity.com/%@", [opciontemp objectForKey:@"URLImagen"]];
            NSURL *url = [NSURL URLWithString:urlimagencompleta];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *imagenjson = [UIImage imageWithData:data];
            
            dictionary = [NSDictionary dictionaryWithObjectsAndKeys:stringID,@"idOpcion",[opciontemp valueForKey:@"Nombre"],@"name",[opciontemp valueForKey:@"Descripcion"],@"description",[opciontemp valueForKey:@"Web"],@"link",[opciontemp valueForKey:@"Web"],@"web",imagenjson,@"image",nil];
            
            [array addObject:dictionary];
            //[tableView reloadData];
            
            
            
            
            
        }
        
        NSLog(@"%@",array);
        [self armoopciones];
        counterLabel.text = [NSString stringWithFormat:@"%i",opciones.count + 1];
        tamanotable = 0;
           //[tableView reloadData];
        //[self performSelector:@selector(removeDoneReminder) withObject:nil afterDelay:5.0];
        
        [vistareloj setFrame:CGRectMake(0,416,320,416)];
        [UIView commitAnimations];
        [reloj stopAnimating];

    }else{
        NSLog(@"%@",json);
            if ([[json valueForKey:@"boolOpcion"] isEqualToString:@"true"]){
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Womity" message:@"Opción creada con éxito" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            
            [scrollView scrollRectToVisible:CGRectMake(0,0,scrollView.frame.size.width,scrollView.frame.size.height) animated:NO];
            
            [placeholder1 setHidden:NO];
            [placeholder2 setHidden:NO];
                
                
                NSString *stringID = [json valueForKey:@"idOpcion:"];
                dictionary = [NSDictionary dictionaryWithObjectsAndKeys:stringID,@"idOpcion",nombreLabel.text,@"name",descripcionLabel.text,@"description",webLabel.text,@"link",webLabel.text,@"web",imagePhoto.image,@"image",nil];
                
                NSLog(@"%@",dictionary);
                
                [array addObject:dictionary];
                 NSLog(@"%@",array);
                nombreLabel.text = @"";
                descripcionLabel.text = @"";
                otrosLabel.text = @"";
                webLabel.text = @"";
                imagePhoto.image = [UIImage imageNamed:@"icono1.png"];
                fofoOpcion.image = [UIImage imageNamed:@"icono1.png"];
                counter = [array count]+1;
                counterLabel.text = [NSString stringWithFormat:@"%i",counter];
                [tableView reloadData];
                image = NULL;
                [self armoopciones];
            //self.navigationController.view
            [vistareloj setFrame:CGRectMake(0,416,320,416)];
            [UIView commitAnimations];
            [reloj stopAnimating];
            
        }else{
            
            if ([[json valueForKey:@"strMensaje"] isEqualToString:@"OpcionEliminada"]){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Womity" message:@"Opción eliminada" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                 [self armoopciones];
            }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Womity" message:[json valueForKey:@"strMensaje"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            }
            [scrollView scrollRectToVisible:CGRectMake(0,0,scrollView.frame.size.width,scrollView.frame.size.height) animated:NO];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.25];
            [UIView setAnimationDelegate:self];
            
            
            //self.navigationController.view
            [vistareloj setFrame:CGRectMake(0,416,320,416)];
            [UIView commitAnimations];
            [reloj stopAnimating];
            
        }
        }
    
    
    
}

- (void)removeDoneReminder {
    //[remList removeObject:doneReminder];
    [tableView reloadData];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        //self uploadPhoto:
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    /*if( textField== nombreLabel)
    {
        [descripcionLabel becomeFirstResponder];
    }*/
    
    [textField resignFirstResponder];
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
                 reload = NO;
                
            }
            else {
                UIAlertView *alert;
                alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                   message:@"This device doesn't have a camera."
                                                  delegate:self cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil];
                [alert show];
                 reload = NO;
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
                 reload = NO;
            }
            else {
                UIAlertView *alert;
                alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                   message:@"This device doesn't support photo libraries."
                                                  delegate:self cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil];
                [alert show];
                 reload = NO;
            }
			break;
		}
	}
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    reload = NO;
    [self dismissModalViewControllerAnimated:YES];
    
    image = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.1);
    UIImage *imageTmp = [UIImage imageWithData:image];
    imagePhoto.image = imageTmp;
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
    scrollView.contentOffset = CGPointMake(0, 85);
    
    if(textField == webLabel)
        scrollView.contentOffset = CGPointMake(0, 100);
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    scrollView.contentOffset = CGPointMake(0, 0);
    [UIView commitAnimations];
}



- (IBAction)siguiente:(id)sender
{
    tamanotable = 0;
    siguiente = @"agregar";
    
    if([nombreLabel.text isEqualToString:@""]){
        
        [self performSegueWithIdentifier:@"crearwomity3" sender:self];
    }else{
    
    responseData = [NSMutableData data];
    
    //NSString *post = [NSString stringWithFormat:@"&idSession=%@&idWomity=%@&Nombre=%@&Descripcion=%@&Imagen=%@&Web=%@&Otros=%@",aSesion, [opcion objectForKey:@"idWomity"], nombreLabel.text, descripcionLabel.text, imagenLabel.text, webLabel.text, otrosLabel.text];
    
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistareloj setFrame:CGRectMake(0,0,320,416)];
    [UIView commitAnimations];
    [reloj startAnimating];
    
    [nombreLabel resignFirstResponder];
    [descripcionLabel resignFirstResponder];
    [webLabel resignFirstResponder];
    [otrosLabel resignFirstResponder];
    
    NSString *urlString = @"http://www.womity.com/ws/crearOpcionWomity";
    
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
    }else{
        UIImage *imagentemp = [UIImage imageWithData:image];
        
        UIImage *scaledImage = [imagentemp resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(imagentemp.size.width, imagentemp.size.height) interpolationQuality:kCGInterpolationHigh];
        image = UIImageJPEGRepresentation(scaledImage, 0.1);
    }
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"Imagen\"; filename=\".png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
       
        
    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
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

    [self performSegueWithIdentifier:@"crearwomity3" sender:self];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    NSLog(@"numero de filas %i",array.count);
    return [array count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    OptionCell *cell = (OptionCell *)[tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSDictionary *dictionary2 = [array objectAtIndex:indexPath.row];
    
    
    cell.name.text= [dictionary2 valueForKey:@"name"];
    cell.fotothumb.image = [dictionary2 valueForKey:@"image"];
    cell.cescription.text = [dictionary2 valueForKey:@"description"];
    float actualSizeop = 12.0;
    [[dictionary2 objectForKey:@"description"] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:12]
                                                minFontSize:12
                                             actualFontSize:&actualSizeop
                                                   forWidth:258
                                              lineBreakMode:UILineBreakModeTailTruncation];
    
    CGSize sizeop = [[dictionary2 objectForKey:@"description"] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:actualSizeop]];
    CGFloat height = 130;
    int linesop = 0;
    if(sizeop.width > 258){
        float myFloatop = sizeop.width / 258;
        
        linesop = (int)ceil(myFloatop);
        
        cell.cescription.frame = CGRectMake(cell.cescription.frame.origin.x, cell.cescription.frame.origin.y, 258, 20*linesop);
        height = 100 + linesop*20;
    }
    NSLog(@"%f", tableView.frame.size.height);
    tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, tableView.frame.size.height + height);
    NSLog(@"%f", tableView.frame.size.height);
    tableView.backgroundColor = [UIColor greenColor];
    cell.webtitulo.frame = CGRectMake(cell.webtitulo.frame.origin.x, cell.cescription.frame.origin.y + cell.cescription.frame.size.height + 10, cell.webtitulo.frame.size.width, cell.webtitulo.frame.size.height);
    
    cell.link.text = [dictionary2 valueForKey:@"link"];
    
    cell.link.frame = CGRectMake(cell.link.frame.origin.x, cell.webtitulo.frame.origin.y + 8, cell.link.frame.size.width, cell.link.frame.size.height);
    
    cell.gotoweb.frame = cell.link.frame;
    cell.vistagris.frame = CGRectMake(cell.vistagris.frame.origin.x, cell.webtitulo.frame.origin.y + cell.webtitulo.frame.size.height + 18, cell.vistagris.frame.size.width, cell.vistagris.frame.size.height);
    
    cell.counter.text = [NSString stringWithFormat:@"%i",indexPath.row +1];
    //cell.fecha.text = [friend objectForKey:@"Fecha"];
    [cell.modify setTitle:[NSString stringWithFormat:@"%i",indexPath.row] forState:0];
    [cell.DeleteCell setTitle:[NSString stringWithFormat:@"%i",indexPath.row] forState:0];
    
    [cell.gotoimg addTarget:self action:@selector(verimagen:) forControlEvents:UIControlEventTouchUpInside];
    cell.gotoimg.tag = indexPath.row;
    
    if(![cell.link.text isEqualToString:@""]){
    [cell.gotoweb addTarget:self action:@selector(gotoweb:) forControlEvents:UIControlEventTouchUpInside];
    cell.gotoweb.tag = indexPath.row;
    }
    //tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, [array count] * 345 + 148 + [array count] * 200);
    
        cell.viewController = self;
    
   // scrollView.contentSize = CGSizeMake(0, 500 + tableView.frame.size.height);
NSLog(@"%f", tableView.frame.size.height);
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView2 heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    NSDictionary *dictionary2 = [array objectAtIndex:indexPath.row];
    
    CGFloat height = 130;
    
    if(![[dictionary2 objectForKey:@"description"] isEqualToString:@""]){
    float actualSizeop = 12.0;
    [[dictionary2 objectForKey:@"description"] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:12]
                                      minFontSize:12
                                   actualFontSize:&actualSizeop
                                         forWidth:258
                                    lineBreakMode:UILineBreakModeTailTruncation];
    
    CGSize sizeop = [[dictionary2 objectForKey:@"description"] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:actualSizeop]];
    
    int linesop = 0;
    if(sizeop.width > 258){
        float myFloatop = sizeop.width / 258;
        
        linesop = (int)ceil(myFloatop);
        NSLog(@"%i",linesop);
        height = 100 + linesop*20;
    }

    }
    /*int numeroOpciones = opciones.count;
     int extrasize = 0;
     if(numeroOpciones > 3){
     
     extrasize = 20*numeroOpciones;
     }
     
     */
    tamanotable = tamanotable + height;
    //tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, tamanotable);
    return height;
}

-(IBAction)gotoweb:(id)sender
{
    UIButton *temporal = (UIButton *) sender;
    NSDictionary *dictionary2 = [array objectAtIndex:temporal.tag];
    
    NSURL *url = [ [ NSURL alloc ] initWithString: [NSString stringWithFormat:@"http://%@", [dictionary2 objectForKey:@"link"]]];
    NSLog(@"%@",url);
    urlfinal = url;
    //[[UIApplication sharedApplication] openURL:url];
    [self performSegueWithIdentifier:@"gotowebview" sender:self];
}

-(void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}

- (void)urlAgregar:(NSString *)idamigo{
    webLabel.text = idamigo;
    [self dismissModalViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"gotourlcrear"]){
        reload = YES;
        urlViewController *segueDestination = (urlViewController *)[segue destinationViewController];
        segueDestination.delegate = self;
        
    }
    
    if ([[segue identifier] isEqualToString:@"crearwomity3"]){
        
        [[NSUserDefaults standardUserDefaults] setValue:@"paso3" forKey:@"descripcion"];
        
        invitarViewController *segueDestination = (invitarViewController *)[segue destinationViewController];
        segueDestination.idWomit = idWomit;
        segueDestination.espasotres = YES;
        segueDestination.aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
        segueDestination.stringTitle = stringTitle;
        
    }
    
    if ([segue.identifier isEqualToString:@"vercomentarios"]){
        ComentariosViewController *controller = [segue destinationViewController];
        controller.datawomit = datawomit;
        controller.aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
        controller.comentar = YES;
        controller.idWomity = [datawomit objectForKey:@"idWomity"];
        
    }
    
    if ([segue.identifier isEqualToString:@"gotowebview"]){
        TerminosViewController *controller = [segue destinationViewController];
        controller.url = [NSString stringWithFormat:@"%@", urlfinal];
        controller.titulolabel.text = [NSString stringWithFormat:@"%@", urlfinal];
    }
    
    if ([segue.identifier isEqualToString:@"modificar"]){
        reload = YES;
        ModificarOpcionViewController *controller = [segue destinationViewController];
        controller.opcion = [array objectAtIndex:rowChange];
        controller.stringTitle = stringTitle;
        controller.idWomit = idWomit;
        controller.aSesion = aSesion;
        controller.datawomit = datawomit2;
        
    }

}


-(void)CallModify:(id)sender{
    UIButton *temporal = (UIButton *) sender;
    //UIButton *btn = (UIButton *)sender;
    rowChange = temporal.tag;
    [self performSegueWithIdentifier:@"modificar" sender:nil];
}

-(void)CallDelete:(id)sender{
    
    UIButton *temporal = (UIButton *) sender;
    //UIButton *btn = (UIButton *)sender;
    rowChange = temporal.tag;
    //rowChange = [btn.currentTitle intValue];
    NSDictionary * dictio = [array objectAtIndex:rowChange];
    //NSLog(@"%@",dictio);
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&idWomity=%@&idOpcion=%@",aSesion, idWomit, [dictio objectForKey:@"idOpcion"]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/EliminarOpcionWomity"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if(conn)
    {
        NSLog(@"Connection Successful");
        
        UIButton *btn = (UIButton *)sender;
        rowChange = temporal.tag;
    
        [array removeObjectAtIndex:rowChange];
        
        //NSLog(@"%@",array);
        siguiente = @"Borrar";
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:rowChange inSection:0]] withRowAnimation:YES];
        [tableView reloadData];
    }
    else
    {
        NSLog(@"Connection could not be made");
    }
    
    
    
    
}

- (IBAction)cerrarimagen:(id)sender
{
    vistaimagen.frame = CGRectMake(vistaimagen.frame.origin.x, vistaimagen.frame.origin.y + 480, vistaimagen.frame.size.width, vistaimagen.frame.size.height);
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
    NSDictionary *dictionary2 = [array objectAtIndex:temporal.tag];
    NSLog(@"%@",dictionary2);
    UIImage *imagenthumb = [dictionary2 objectForKey:@"image"];
    
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
    vistaimg.image = [dictionary2 objectForKey:@"image"];
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
    for(UIView *subview in [vistaimagen subviews]) {
        [subview removeFromSuperview];
    }
    [vistaimagen addSubview:botoncerrar];
    vistaimagen.frame = CGRectMake(vistaimagen.frame.origin.x, 0, vistaimagen.frame.size.width, vistaimagen.frame.size.height);
    UIButton *temporal = (UIButton *) sender;
    NSDictionary *dictionary2 = [array objectAtIndex:temporal.tag];
    NSLog(@"%@",dictionary2);
    UIImage *imagenthumb = [dictionary2 objectForKey:@"image"];
    
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
    vistaimg.image = [dictionary2 objectForKey:@"image"];
    [vistaimagen addSubview:vistaimg];
    [vistaimagen bringSubviewToFront:botoncerrar];
    //[imagengrande setImage:[UIImage imageWithData:datapic]];
    
}*/
-(void) textViewDidBeginEditing:(UITextView *)textView{
    
    scrollView.contentOffset = CGPointMake(0, 85);
    
    
}
- (void)textViewDidChange:(UITextView *)textView{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    scrollView.contentOffset = CGPointMake(0, 85);
    
    
    
    [UIView commitAnimations];
    
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
    
   
    scrollView.contentOffset = CGPointMake(0, 85);
    
    
    
    
    
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
    [[NSUserDefaults standardUserDefaults] setValue:@"crear" forKey:@"accioncrear"];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)volver:(id)sender{
    [[NSUserDefaults standardUserDefaults] setValue:@"modificar" forKey:@"accioncrear"];
    [self.navigationController popViewControllerAnimated:YES];
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
        popoverController.delegate =  self;
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
    //[viewController.navigationController popToViewController:[viewController.navigationController.viewControllers objectAtIndex:0] animated:YES];
    
    return YES;
}

@end
