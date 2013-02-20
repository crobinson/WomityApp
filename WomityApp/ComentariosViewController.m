//
//  ComentariosViewController.m
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 12/3/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "ComentariosViewController.h"
#import "VotarViewController.h"
#import "ModificarWomityViewController.h"
#import "invitarViewController.h"
#import "CrearOpcionViewController.h"
#import "ModificarOpcionViewController.h"
#import "CustomImageView.h"
#import "TerminosViewController.h"
#import "popViewContainer.h"

@interface ComentariosViewController ()

@end

@implementation ComentariosViewController
@synthesize datawomit, myView, myscrollView, responseData, idWomity, aSesion, vistareloj, reloj, botonVotar, comentar, campocomentario, vistaimagen, titulo;

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
    
    tipo = [[NSUserDefaults standardUserDefaults] valueForKey:@"tipowomit"];
    
    
    myView.backgroundColor = [UIColor colorWithRed:(243/255.0) green:(245/255.0) blue:(247/255.0) alpha:1];
    myscrollView.backgroundColor = [UIColor colorWithRed:(243/255.0) green:(245/255.0) blue:(247/255.0) alpha:1];
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarTeclado)];
    
    [myscrollView addGestureRecognizer:tapScroll];
}

- (void) viewWillAppear:(BOOL)animated
{
    //[self actualizo];
    aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
    self.tabBarController.delegate = self;
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"soloactivos"] isEqualToString:@"true"]){
        [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"soloactivos"];
        [self.navigationController popViewControllerAnimated:NO];
        
    }
    
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"accionppal"] isEqualToString:@"ppal"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
    //[[NSUserDefaults standardUserDefaults] setValue:[datadiccionario objectForKey:@"idWomity"] forKey:@"idWomit"];
    
    for(UIView *subview in [myscrollView subviews]) {
        [subview removeFromSuperview];
    }
    //[vistareloj setFrame:CGRectMake(0, 0, 320, 440)];
    //[reloj startAnimating];
    yahevotado = NO;
}

- (IBAction)gotomodificaropcion:(id)sender{
    UIButton *temporal = (UIButton *) sender;
    modificarTag = temporal.tag;
    [self performSegueWithIdentifier:@"gotomodificaropcion" sender:self];
}

-(IBAction)borrarComentario:(id)sender
{
    UIButton *temporal = (UIButton *) sender;
    //modificarTag = temporal.tag;
    [vistareloj setFrame:CGRectMake(0, 44, 320, 440)];
    [reloj startAnimating];
    responseData = [NSMutableData data];
    idWomity = [datawomit objectForKey:@"idWomity"];
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&idWomity=%@&idComentario=%@",aSesion, idWomity, [NSString stringWithFormat:@"%i",temporal.tag]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/eliminarComentario"]]];
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


- (IBAction)eliminaropcion:(id)sender{
    //[self performSegueWithIdentifier:@"gotomodificaropcion" sender:self];
    UIButton *temporal = (UIButton *) sender;
    modificarTag = temporal.tag;
    NSMutableDictionary  *opciondiccionario = [[datawomit objectForKey:@"Opciones"] objectAtIndex:modificarTag];
    [vistareloj setFrame:CGRectMake(0, 44, 320, 440)];
    [reloj startAnimating];
    responseData = [NSMutableData data];
    idWomity = [datawomit objectForKey:@"idWomity"];
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&idWomity=%@&idOpcion=%@",aSesion, idWomity, [opciondiccionario objectForKey:@"idOpcion"]];
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
    }
    else
    {
        NSLog(@"Connection could not be made");
    }
    
    
    
    
}

- (IBAction)gotomodificar:(id)sender{
    
    [self performSegueWithIdentifier:@"gotomodificar" sender:self];
}

- (IBAction)gotoinvitar:(id)sender{
    [self performSegueWithIdentifier:@"gotoinvitardesc" sender:self];
}

- (IBAction)gotocreaopcion:(id)sender{
    [self performSegueWithIdentifier:@"gotocreaopcion" sender:self];
}


- (IBAction)gotovotar:(id)sender{
    [self performSegueWithIdentifier:@"gotovotar" sender:self];
}

-(void) actualizo
{
    [vistareloj setFrame:CGRectMake(0, 44, 320, 440)];
    [reloj startAnimating];
    responseData = [NSMutableData data];
    
     NSLog(idWomity);
          
    if(idWomity == NULL)
        idWomity = [datawomit objectForKey:@"idWomity"];
    
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&womit_id=%@",aSesion, idWomity];
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
}


-(void)eliminarFinalizar:(id) sender{
    UIButton *temporal = (UIButton *) sender;
    
    
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&idWomity=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"id"], [NSString stringWithFormat:@"%i", temporal.tag]];
    
    NSLog(@"%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/eliminarWomity"]]];
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

-(void)eliminarBorrador:(id) sender{
    UIButton *temporal = (UIButton *) sender;
    
    
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&idWomity=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"id"], [NSString stringWithFormat:@"%i", temporal.tag]];
    
    NSLog(@"%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/eliminarWomity"]]];
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

- (void) viewDidAppear:(BOOL)animated
{
    //   [super viewDidLoad];
    yahevotado = NO;
    responseData = [NSMutableData data];
    
    if(reloadPage){
        [self actualizo];
        
    }else{
        ishide = YES;
        NSLog(@"%@",datawomit);
        
        [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
        
        if([[datawomit objectForKey:@"Estado"] isEqualToString:@"borrador"])
            [[NSUserDefaults standardUserDefaults] setValue:@"B" forKey:@"tipowomit"];
        
        if([[datawomit objectForKey:@"Estado"] isEqualToString:@"finalizado"])
            [[NSUserDefaults standardUserDefaults] setValue:@"F" forKey:@"tipowomit"];
        
        
        
               
        UILabel *titulo = [[UILabel alloc] initWithFrame:CGRectMake(11, 5, 217, 25)];
        titulo.text = [[datawomit objectForKey:@"Titulo"]uppercaseString];
        
        [titulo setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
        titulo.backgroundColor = [UIColor clearColor];
        NSString* yourString = [datawomit objectForKey:@"Titulo"];
        float actualSize = 18.0;
        [yourString sizeWithFont:titulo.font
                     minFontSize:18
                  actualFontSize:&actualSize
                        forWidth:217
                   lineBreakMode:titulo.lineBreakMode];
        
        CGSize size = [yourString sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:actualSize]];
        
        int lines = 0;
        if(size.width > titulo.frame.size.width){
            float myFloat = size.width / titulo.frame.size.width;
            NSLog(@"%f",myFloat);
            lines = (int)ceil(myFloat);
            NSLog(@"%i",lines);
            titulo.numberOfLines = lines;
            titulo.frame = CGRectMake(titulo.frame.origin.x, titulo.frame.origin.y, titulo.frame.size.width, titulo.frame.size.height * lines);
        }
        
        int ancho = 298;
        if(lines<2){
            ancho =  217;
        }
        
        NSLog(@"%@",titulo.text);
        [myscrollView addSubview:titulo];
        
       
        
        UILabel *descripcion = [[UILabel alloc] initWithFrame:CGRectMake(titulo.frame.origin.x, titulo.frame.origin.y + titulo.frame.size.height - 7, ancho, 21)];
        
        
        
        descripcion.text = [datawomit objectForKey:@"Descripcion"];
        descripcion.backgroundColor = [UIColor clearColor];
        [descripcion setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:11]];
        descripcion.textColor = [UIColor redColor];
        
        float actualSize2 = 13.0;
        [[datawomit objectForKey:@"Descripcion"] sizeWithFont:descripcion.font
                                                  minFontSize:13
                                               actualFontSize:&actualSize2
                                                     forWidth:ancho
                                                lineBreakMode:descripcion.lineBreakMode];
        
        CGSize size2 = [[datawomit objectForKey:@"Descripcion"] sizeWithFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:actualSize2]];
        
        
        int lines2 = 0;
        if(size2.width > descripcion.frame.size.width){
            float myFloat = size2.width / descripcion.frame.size.width;
            
            lines2 = (int)ceil(myFloat);
            
            descripcion.numberOfLines = lines2;
            descripcion.frame = CGRectMake(descripcion.frame.origin.x, descripcion.frame.origin.y, descripcion.frame.size.width, descripcion.frame.size.height * lines2);
        }
        
        [myscrollView addSubview:descripcion];
        
        UIView *vistagris = [[UIView alloc] initWithFrame:CGRectMake(descripcion.frame.origin.x, descripcion.frame.origin.y + descripcion.frame.size.height + 2, 0, 8)];
        
        if([tipo isEqualToString:@"A"]){
            vistagris.frame = CGRectMake(descripcion.frame.origin.x, descripcion.frame.origin.y + descripcion.frame.size.height + 2, 140, 22);
            vistagris.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            
            [myscrollView addSubview:vistagris];
            // Fecha actual
            NSDate *date = [NSDate date];
            int secondsNow =(int)[date timeIntervalSince1970];
            
            // Convierto el string hasta
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *hastaDate = [dateFormat dateFromString:[datawomit objectForKey:@"FechaCaducidad"]];
            
            int secondsTarget=(int)[hastaDate timeIntervalSince1970];
            int differenceSeconds=secondsTarget-secondsNow;
            int days=(int)((double)differenceSeconds/(3600.0*24.00));
            int diffDay=differenceSeconds-(days*3600*24);
            int hours=(int)((double)diffDay/3600.00);
            int diffMin=diffDay-(hours*3600);
            int minutes=(int)(diffMin/60.0);
            int seconds=diffMin-(minutes*60);
            
            UILabel *tiempo = [[UILabel alloc] initWithFrame:CGRectMake(5, 6, 60, 10)];
            tiempo.backgroundColor = [UIColor clearColor];
            tiempo.text =[NSString stringWithFormat:@"TIEMPO "];
            [tiempo setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10]];
            [vistagris addSubview:tiempo];
            
            UILabel *tiempodata = [[UILabel alloc] initWithFrame:CGRectMake(65, 6, 180, 10)];
            tiempodata.backgroundColor = [UIColor clearColor];
            tiempodata.text =[NSString stringWithFormat:@"%id | %ih | %im",days, hours, minutes];
            [tiempodata setFont:[UIFont fontWithName:@"HelveticaNeue" size:10]];
            [vistagris addSubview:tiempodata];
            
            
        }
        UIImageView *botonesimg = [[UIImageView alloc] initWithFrame:CGRectMake(vistagris.frame.origin.x, vistagris.frame.origin.y + vistagris.frame.size.height + 10, 300, 0)];
        
        
        NSMutableArray *opciones = [datawomit objectForKey:@"Opciones"];
        dataopciones = opciones;
        CGFloat renglon = botonesimg.frame.origin.y + botonesimg.frame.size.height + 5;
        CGFloat totalopcionessize = 0.0;
        for (int i=0; i<opciones.count; i++) {
            NSDictionary *opcion = [opciones objectAtIndex:i];
            
            if(yahevotado==NO){
                NSLog(@"%i",[[opcion objectForKey:@"VotoUsuario"] intValue]);
                if ([[opcion objectForKey:@"VotoUsuario"] intValue]!=0) {
                    yahevotado = YES;
                }
            }
            
            UIView *vistablanca = [[UIView alloc] initWithFrame:CGRectMake(botonesimg.frame.origin.x, renglon, 300, 100)];
            vistablanca.backgroundColor = [UIColor whiteColor];
            [myscrollView addSubview:vistablanca];
            
            CustomImageView *thumbopcion = [[CustomImageView alloc] initWithFrame:CGRectMake(5, 12, 45, 45)];
            UIButton *gotoimg = [UIButton buttonWithType:UIButtonTypeCustom];
            gotoimg.frame = CGRectMake(thumbopcion.frame.origin.x, 12, 45, 45);
            [gotoimg addTarget:self action:@selector(verimagen:) forControlEvents:UIControlEventTouchUpInside];
            gotoimg.tag = i;
            [myscrollView addSubview:gotoimg];
            
            
            NSString *urlimagencompleta = [NSString stringWithFormat:@"http://www.womity.com/%@", [opcion objectForKey:@"URLImagenThumb"]];
            /*NSURL *url = [NSURL URLWithString:urlimagencompleta];
             NSData *data = [NSData dataWithContentsOfURL:url];
             UIImage *image = [UIImage imageWithData:data];
             thumbopcion.image = image;
             */
            [thumbopcion setURL:[NSURL URLWithString:urlimagencompleta]];
            [vistablanca addSubview:thumbopcion];
            
            
            UILabel *tituloopcion = [[UILabel alloc] initWithFrame:CGRectMake(5 + thumbopcion.frame.size.width + 7, 10, 200, 15)];
            tituloopcion.text = [opcion objectForKey:@"Nombre"];
            [tituloopcion setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
            tituloopcion.textColor = [UIColor redColor];
            
            float actualSizeop = 14.0;
            [[opcion objectForKey:@"Nombre"] sizeWithFont:tituloopcion.font
                                              minFontSize:14
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
            
            UILabel *descripciontitulo = [[UILabel alloc] initWithFrame:CGRectMake(5 + thumbopcion.frame.size.width + 7, 8 + tituloopcion.frame.size.height + 5, 64, 15)];
            descripciontitulo.text = @"Descripción: ";
            [descripciontitulo setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10]];
            
            
            
            UILabel *descripcionopcion = [[UILabel alloc] initWithFrame:CGRectMake(descripciontitulo.frame.origin.x, descripciontitulo.frame.origin.y + 13, 230, 15)];
            descripcionopcion.text = [opcion objectForKey:@"Descripcion"];
            [descripcionopcion setFont:[UIFont fontWithName:@"HelveticaNeue" size:10]];
            descripcionopcion.textColor = [UIColor blackColor];
            descripcionopcion.backgroundColor = [UIColor clearColor];
            
            float actualSized = 11.0;
            [[opcion objectForKey:@"Descripcion"] sizeWithFont:descripcionopcion.font
                                                   minFontSize:11
                                                actualFontSize:&actualSized
                                                      forWidth:230
                                                 lineBreakMode:descripcionopcion.lineBreakMode];
            
            CGSize sized = [[opcion objectForKey:@"Descripcion"] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:actualSized]];
            
            int linesd = 0;
            
            if(sized.width > descripcionopcion.frame.size.width){
                float myFloatd = sized.width / descripcionopcion.frame.size.width;
                
                linesd = (int)ceil(myFloatd);
                
                descripcionopcion.numberOfLines = linesd;
                
                
                descripcionopcion.frame = CGRectMake(descripcionopcion.frame.origin.x, descripcionopcion.frame.origin.y , descripcionopcion.frame.size.width, descripcionopcion.frame.size.height * linesd);
            }
            
            [vistablanca addSubview:descripcionopcion];
            [vistablanca addSubview:descripciontitulo];
            
            
            UILabel *webtitulo = [[UILabel alloc] initWithFrame:CGRectMake(5 + thumbopcion.frame.size.width + 7, descripcionopcion.frame.origin.y + descripcionopcion.frame.size.height + 1, 64, 15)];
            webtitulo.text = @"Web: ";
            [webtitulo setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10]];
            
            [vistablanca addSubview:webtitulo];
            
            UILabel *web = [[UILabel alloc] initWithFrame:CGRectMake(descripcionopcion.frame.origin.x, webtitulo.frame.origin.y + 13, descripcionopcion.frame.size.width, 15)];
            web.text = [opcion objectForKey:@"Web"];
            //web.text = @"www.google.com";
            [web setFont:[UIFont fontWithName:@"HelveticaNeue" size:10]];
            web.backgroundColor = [UIColor clearColor];
            [vistablanca addSubview:web];
            
            UILabel *porcentaje = [[UILabel alloc] initWithFrame:CGRectMake(5 + thumbopcion.frame.size.width + 210, 10, 40, 10)];
            NSString *porcentajesimbolo = @"%";
            porcentaje.text = [NSString stringWithFormat:@"%@%@",[opcion objectForKey:@"Porcentaje"], porcentajesimbolo];
            [porcentaje setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
            porcentaje.textColor = [UIColor redColor];
            porcentaje.backgroundColor = [UIColor clearColor];
            
            if([tipo isEqualToString:@"A"])
                [vistablanca addSubview:porcentaje];
            
            vistablanca.frame = CGRectMake(vistablanca.frame.origin.x, vistablanca.frame.origin.y, vistablanca.frame.size.width,10 + tituloopcion.frame.size.height + 5 + descripcionopcion.frame.size.height + 5 + web.frame.size.height + 32);
            
            UIView *minilineagris = [[UIView alloc] initWithFrame:CGRectMake(0, vistablanca.frame.size.height-2, vistablanca.frame.size.width, 2)];
            minilineagris.backgroundColor = [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1];
            [vistablanca addSubview:minilineagris];
            
           
            
            
            renglon = renglon + vistablanca.frame.size.height + 10;
        }
        
        
        if(![tipo isEqualToString:@"B"]){
            
            
            UILabel *mensaje1 = [[UILabel alloc] initWithFrame:CGRectMake(botonesimg.frame.origin.x, renglon, botonesimg.frame.size.width, 13)];
            NSMutableArray *usuarios = [datawomit objectForKey:@"Usuarios"];
            mensaje1.text = [NSString stringWithFormat:@"En este womit participan %i personas",usuarios.count];
            [mensaje1 setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            mensaje1.backgroundColor = [UIColor clearColor];
            
            if(![tipo isEqualToString:@"F"]){
                [myscrollView addSubview:mensaje1];
            }
            UILabel *mensaje2 = [[UILabel alloc] initWithFrame:CGRectMake(botonesimg.frame.origin.x, renglon + mensaje1.frame.size.height , botonesimg.frame.size.width, 13)];
            
            if([[datawomit objectForKey:@"Votaron"] intValue]==0)
                mensaje2.text = [NSString stringWithFormat:@"Nadie ha votado aún"];
            else if([[datawomit objectForKey:@"Votaron"] intValue]==1)
                mensaje2.text = [NSString stringWithFormat:@"Ha votado 1 persona"];
            else
                mensaje2.text = [NSString stringWithFormat:@"Han votado %i personas",[[datawomit objectForKey:@"Votaron"] intValue]];
            [mensaje2 setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            mensaje2.backgroundColor = [UIColor clearColor];
            
            if(![tipo isEqualToString:@"F"]){
                [myscrollView addSubview:mensaje2];
            }
            float actualSized = 11.0;
            [[NSString stringWithFormat:@"Este womit ha sido creado por %@", [datawomit objectForKey:@"Creador"]] sizeWithFont:mensaje2.font
                                                                                                                   minFontSize:11
                                                                                                                actualFontSize:&actualSized
                                                                                                                      forWidth:299
                                                                                                                 lineBreakMode:mensaje2.lineBreakMode];
            
            CGSize sized = [[NSString stringWithFormat:@"Este womit ha sido creado por %@", [datawomit objectForKey:@"Creador"]] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:actualSized]];
            
            int linesd = 2;
            
            if(sized.width > 300){
                float myFloatd = sized.width / 300;
                
                linesd = (int)ceil(myFloatd);
                
            }
            
            UIWebView *creador = [[UIWebView alloc] initWithFrame:CGRectMake(botonesimg.frame.origin.x - 8, renglon + mensaje1.frame.size.height + 3, 300, 20*linesd)];
            
            [creador loadHTMLString:[NSString stringWithFormat:@"<html><body style=\"font-family:Helvetica; font-size:12px; background-color: transparent; color:black;\"><strong>Este womit ha sido creado por <span style=\"color:red;\">%@</span></strong></body></html>", [datawomit objectForKey:@"Creador"]] baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
            creador.delegate = self;
            creador.opaque = NO;
            creador.backgroundColor = [UIColor clearColor];
            creador.scrollView.scrollEnabled = NO;
            
            if(![tipo isEqualToString:@"F"]){
                [myscrollView addSubview:creador];
            }
            NSLog(@"%f",creador.frame.size.height);
            
            UIView *vistagris2 = [[UIView alloc] initWithFrame:CGRectMake(descripcion.frame.origin.x, renglon + mensaje1.frame.size.height + mensaje2.frame.size.height + creador.frame.size.height -10, 300, 25)];
            
            if([tipo isEqualToString:@"F"]){
                vistagris2.frame = CGRectMake(descripcion.frame.origin.x, renglon, 300, 25);
            }
            
            vistagris2.backgroundColor = [UIColor colorWithRed:184/255.0 green:184/255.0 blue:184/255.0 alpha:1];
            
            [myscrollView addSubview:vistagris2];
            
            UILabel *comentariotitulo = [[UILabel alloc] initWithFrame:CGRectMake(vistagris2.frame.origin.x,vistagris2.frame.origin.y, vistagris2.frame.size.width, 25)];
            comentariotitulo.text = @"Comentarios";
            [comentariotitulo setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
            comentariotitulo.textColor = [UIColor whiteColor];
            comentariotitulo.backgroundColor = [UIColor clearColor];
            comentariotitulo.textAlignment = UITextAlignmentCenter;
            
            UIImageView *flechita = [[UIImageView alloc] initWithFrame:CGRectMake(vistagris2.frame.origin.x + 200,vistagris2.frame.origin.y + 9, 12, 7)];
            flechita.image = [UIImage imageNamed:@"Polygon"];
            
            [myscrollView addSubview:comentariotitulo];
            [myscrollView addSubview:flechita];
            
            NSMutableArray *comentarios = [datawomit objectForKey:@"Comentarios"];
            
            if(![tipo isEqualToString:@"F"])
                renglon = renglon + comentariotitulo.frame.size.height + 5 + mensaje1.frame.size.height + creador.frame.size.height;
            else
                renglon = renglon + comentariotitulo.frame.size.height + 5;
            
            for (int i=0; i<comentarios.count; i++) {
                
                UIImageView *iconocontacto = [[UIImageView alloc] initWithFrame:CGRectMake(vistagris.frame.origin.x, renglon + 10, 58, 58)];
                iconocontacto.image = [UIImage imageNamed:@"fotoperfil"];
                
                
                
                
                [myscrollView addSubview:iconocontacto];
                /*
                 UIButton *gotoimg = [UIButton buttonWithType:UIButtonTypeCustom];
                 gotoimg.frame = CGRectMake(iconocontacto.frame.origin.x, renglon + 10, 58, 58);
                 [gotoimg addTarget:self action:@selector(verimagen:) forControlEvents:UIControlEventTouchUpInside];
                 gotoimg.tag = i;
                 [myscrollView addSubview:gotoimg];
                 */
                NSDictionary *comentario = [comentarios objectAtIndex:i];
                
                if(![[comentario objectForKey:@"Foto"] isEqualToString:@""]){
                    NSString *urlimagencompleta = [NSString stringWithFormat:@"http://www.womity.com/%@", [comentario objectForKey:@"Foto"]];
                    NSURL *url = [NSURL URLWithString:urlimagencompleta];
                    NSData *data = [NSData dataWithContentsOfURL:url];
                    UIImage *image = [UIImage imageWithData:data];
                    
                    iconocontacto.image = image;
                }
                UILabel *comentariousuario = [[UILabel alloc] initWithFrame:CGRectMake(vistagris.frame.origin.x + iconocontacto.frame.size.width + 10, renglon + 10, 200, 11)];
                comentariousuario.text =[NSString stringWithFormat:@"%@",[comentario objectForKey:@"idContacto"]];
                [comentariousuario setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]];
                comentariousuario.backgroundColor = [UIColor clearColor];
                
                
                UILabel *comentariotexto = [[UILabel alloc] initWithFrame:CGRectMake(vistagris.frame.origin.x + iconocontacto.frame.size.width + 10, renglon + 17, 210, 20)];
                comentariotexto.text =[NSString stringWithFormat:@"%@",[comentario objectForKey:@"Comentario"]];
                [comentariotexto setFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
                comentariotexto.backgroundColor = [UIColor clearColor];
                
                float actualSizecom = 11.0;
                [comentariotexto.text sizeWithFont:comentariotexto.font
                                       minFontSize:11
                                    actualFontSize:&actualSizecom
                                          forWidth:200
                                     lineBreakMode:comentariotexto.lineBreakMode];
                
                CGSize sized = [comentariotexto.text sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:actualSizecom]];
                
                int linescom = 0;
                
                if(sized.width > comentariotexto.frame.size.width){
                    float myFloatd = sized.width / comentariotexto.frame.size.width;
                    
                    linescom = (int)ceil(myFloatd);
                    
                    comentariotexto.numberOfLines = linescom;
                    comentariotexto.frame = CGRectMake(comentariotexto.frame.origin.x, comentariotexto.frame.origin.y, comentariotexto.frame.size.width, comentariotexto.frame.size.height * linescom);
                }
                
                UILabel *comentariofecha = [[UILabel alloc] initWithFrame:CGRectMake(vistagris.frame.origin.x + iconocontacto.frame.size.width + 10 , renglon + 15 + comentariotexto.frame.size.height, 220, 12)];
                
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[dateFormat dateFromString:[comentario objectForKey:@"Fecha"]]];
                
                int day = [comp day];
                int month = [comp month];
                int year = [comp year];
                NSInteger hora = [comp hour];
                NSInteger minutos = [comp minute];
                NSDictionary *meses = self.createMonths;
                
                NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
                [dateFormat2 setDateFormat:@"HH:mm"];
                NSDate *hastaDate2 = [dateFormat dateFromString:[comentario objectForKey:@"Fecha"]];
                
                
                
                comentariofecha.text = [NSString stringWithFormat:@"%i de %@ de %i %@ - Borrar", day,[meses objectForKey:[NSNumber numberWithInt:month]], year,[dateFormat2 stringFromDate:hastaDate2]];
                

                [comentariofecha setFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
                comentariofecha.backgroundColor = [UIColor clearColor];
                
                /*  UILabel *comentarioborrar = [[UILabel alloc] initWithFrame:CGRectMake(comentariofecha.frame.origin.x + comentariofecha.frame.size.width + 5, renglon + 15 + comentariotexto.frame.size.height, 200, 12)];
                 comentarioborrar.text = @" - Borrar";
                 [comentarioborrar setFont:[UIFont fontWithName:@"HelveticaNeue" size:10]];
                 comentarioborrar.backgroundColor = [UIColor clearColor];UIButtonTypeCustom
                 */
                UIButton *botonBorrar = [UIButton buttonWithType:UIButtonTypeCustom];
                botonBorrar.frame = CGRectMake(comentariofecha.frame.origin.x + comentariofecha.frame.size.width -58, renglon + 15 + comentariotexto.frame.size.height, 50, 12);
                botonBorrar.tag = [[comentario objectForKey:@"idComentario"] intValue];
                [botonBorrar addTarget:self action:@selector(borrarComentario:) forControlEvents:UIControlEventTouchUpInside];
                
                [myscrollView addSubview:comentariousuario];
                [myscrollView addSubview:comentariotexto];
                [myscrollView addSubview:comentariofecha];
                //[myscrollView addSubview:comentarioborrar];
                [myscrollView addSubview:botonBorrar];

                [myscrollView addSubview:botonBorrar];
                if(comentariotexto.frame.size.height > iconocontacto.frame.size.height){
                    renglon = renglon + 10 + comentariotexto.frame.size.height + 20;
                }else{
                    renglon = renglon + 10 + iconocontacto.frame.size.height;
                    
                }
            }
            
            campocomentario.frame = CGRectMake(vistagris.frame.origin.x, renglon + 10, campocomentario.frame.size.width, campocomentario.frame.size.height);
            campocomentario.delegate = self;
            
            renglon = renglon + 30 + campocomentario.frame.size.height + 20;
            
            [myscrollView addSubview:campocomentario];
        }
        
        myscrollView.contentSize = CGSizeMake(myscrollView.frame.size.width, renglon);
        if(comentar){
            [myscrollView scrollRectToVisible:CGRectMake(0,myscrollView.frame.size.height,myscrollView.frame.size.width,myscrollView.frame.size.height) animated:NO];
            //[campocomentario becomeFirstResponder];
        }
        
        vistareloj.frame = CGRectMake(0, 480, vistareloj.frame.size.width, vistareloj.frame.size.height);
        [reloj stopAnimating];
        // Do any additional setup after loading the view.
    }
    
    if(yahevotado==YES && [tipo isEqualToString:@"A"]){
        botonVotar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cambiarVoto"]];
    }
}

-(NSDictionary *)createMonths{
    
    NSArray *arrayDate = [NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3],[NSNumber numberWithInt:4],[NSNumber numberWithInt:5],[NSNumber numberWithInt:6],[NSNumber numberWithInt:7],[NSNumber numberWithInt:8],[NSNumber numberWithInt:9],[NSNumber numberWithInt:10],[NSNumber numberWithInt:11],[NSNumber numberWithInt:12],nil];
    NSArray *arrayMonth = [NSArray arrayWithObjects:@"Enero",@"Febrero",@"Marzo",@"Abril",@"Mayo",@"Junio",@"Julio",@"Agosto",@"Septiembre",@"Octubre",@"Noviembre",@"Diciembre",nil];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:arrayMonth forKeys:arrayDate];
    return dictionary;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)ShowSettings{
    
    
    
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
    
    [myView setFrame:CGRectMake(0,45,320,368)];
    
    [UIView commitAnimations];
    
}

-(void)unHideWindow{
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [myView setFrame:CGRectMake(230,45,320,368)];
    
    [UIView commitAnimations];
}

-(IBAction)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Dismiss the keyboard when the view outside the text field is touched.
    [campocomentario resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
}

- (void)quitarTeclado
{
    // Dismiss the keyboard when the view outside the text field is touched.
    [campocomentario resignFirstResponder];
    // Revert the text field to the previous value.
    //palabra.text = self.string;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.view.frame.size.width == 320){
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.frame = CGRectMake(0,-165,self.view.frame.size.width,self.view.frame.size.height);
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [campocomentario resignFirstResponder];
    [self comentar];
}
-(void)comentar{
    [vistareloj setFrame:CGRectMake(0, 44, 320, 440)];
    [reloj startAnimating];
    responseData = [NSMutableData data];
    idWomity = [datawomit objectForKey:@"idWomity"];
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&idWomity=%@&Comentario=%@",aSesion, idWomity, campocomentario.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/agregarComentario"]]];
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
    
    campocomentario.text = @"";
    
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
    [vistareloj setFrame:CGRectMake(0, 480, 320, 440)];
    [reloj stopAnimating];
    //[self performSegueWithIdentifier:@"loguearse" sender:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSLog(@"%@",json);
    
    
    for(UIView *subview in [myscrollView subviews]) {
        [subview removeFromSuperview];
    }
    
    
    
    NSLog(@"%@", connection.currentRequest.URL);
    NSString *urlconexion = [NSString stringWithFormat:@"%@",connection.currentRequest.URL];
    
    
    if([urlconexion isEqualToString:@"http://www.womity.com/ws/agregarComentario"] || [urlconexion isEqualToString:@"http://www.womity.com/ws/EliminarOpcionWomity"] || [urlconexion isEqualToString:@"http://www.womity.com/ws/eliminarComentario"])
    {
        
        
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:[json objectForKey:@"strMensaje"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        if([[json objectForKey:@"strMensaje"] isEqualToString:@"OK"] && [urlconexion isEqualToString:@"http://www.womity.com/ws/agregarComentario"])
            alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Comentario enviado" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        if([[json objectForKey:@"strMensaje"] isEqualToString:@"OpcionEliminada"])
            alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Opción Eliminada" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        if([[json objectForKey:@"strMensaje"] isEqualToString:@"ComentarioEliminado"])
            alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Comentario Eliminado" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        
        [alerta show];
        
        [vistareloj setFrame:CGRectMake(0, 44, 320, 440)];
        [reloj startAnimating];
        responseData = [NSMutableData data];
        idWomity = [datawomit objectForKey:@"idWomity"];
        NSString *post = [NSString stringWithFormat:@"&idSession=%@&womit_id=%@",aSesion, idWomity];
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
    }else if([urlconexion isEqualToString:@"http://www.womity.com/ws/eliminarWomity"]){
        if ([[json objectForKey:@"boolWomity"] isEqualToString:@"true"])
        {
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Womit eliminado correctamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alerta show];
            
            //tipo=@"B";
            //[[NSUserDefaults standardUserDefaults] setValue:@"B" forKey:@"tipowomit"];
            [[NSUserDefaults standardUserDefaults] setValue:@"ppal" forKey:@"accionppal"];
            [self.navigationController popViewControllerAnimated:NO];
        }else{
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:[json objectForKey:@"strMensaje"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            if([[json objectForKey:@"strMensaje"] isEqualToString:@"WomitNoPerteneceAUsuario"])
                alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"No tienes permiso para eliminar la opción" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alerta show];
            
            [vistareloj setFrame:CGRectMake(0, 44, 320, 440)];
            [reloj startAnimating];
            responseData = [NSMutableData data];
            idWomity = [datawomit objectForKey:@"idWomity"];
            NSString *post = [NSString stringWithFormat:@"&idSession=%@&womit_id=%@",aSesion, idWomity];
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
            
        }
    }else{
        [vistareloj setFrame:CGRectMake(0, 480, 320, 440)];
        [reloj startAnimating];
        
        reloadPage = NO;
        NSArray *arrayjson = json;
        datawomit = [arrayjson objectAtIndex:0];
        
        NSLog(@"%@",[datawomit objectForKey:@"Estado"]);
        [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
        
        if([[datawomit objectForKey:@"Estado"] isEqualToString:@"borrador"])
            [[NSUserDefaults standardUserDefaults] setValue:@"B" forKey:@"tipowomit"];
        
        if([[datawomit objectForKey:@"Estado"] isEqualToString:@"finalizado"])
            [[NSUserDefaults standardUserDefaults] setValue:@"F" forKey:@"tipowomit"];
        
        [self viewDidAppear:YES];
    }
    myscrollView.contentOffset = CGPointMake(0, 0);
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"notificaciones"] isEqualToString:@"true"]){
        //myscrollView.contentOffset = CGPointMake(0, 10);
        [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"notificaciones"];
    }
    
}

-(IBAction) Loadcrear:(id)sender{
    [self hideWindow];
    ishide = YES;
    [[NSUserDefaults standardUserDefaults] setValue:@"crear" forKey:@"accioncrear"];
    UITabBarController *tabBarController = self.tabBarController;
    tabBarController.selectedIndex = 0;
}

- (IBAction)loadtipoA:(id)sender
{
    [self hideWindow];
    ishide = YES;
    tipo=@"A";
    [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
    [[NSUserDefaults standardUserDefaults] setValue:@"ppal" forKey:@"accionppal"];
    
    //UITabBarController *tabBarController = self.tabBarController;
    //tabBarController.selectedIndex = 1;
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)loadtipoB:(id)sender
{
    [self hideWindow];
    ishide = YES;
    tipo=@"B";
    [[NSUserDefaults standardUserDefaults] setValue:@"B" forKey:@"tipowomit"];
    [[NSUserDefaults standardUserDefaults] setValue:@"ppal" forKey:@"accionppal"];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)loadtipoF:(id)sender
{
    [self hideWindow];
    ishide = YES;
    tipo=@"F";
    [[NSUserDefaults standardUserDefaults] setValue:@"F" forKey:@"tipowomit"];
    [[NSUserDefaults standardUserDefaults] setValue:@"ppal" forKey:@"accionppal"];
    [self.navigationController popViewControllerAnimated:YES];
    
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gotovotar"]){
        reloadPage = YES;
        VotarViewController *controller = [segue destinationViewController];
        controller.datawomit = datawomit;
        controller.aSesion = aSesion;
    }
    
    if ([segue.identifier isEqualToString:@"gotowebview"]){
        TerminosViewController *controller = [segue destinationViewController];
        controller.url = [NSString stringWithFormat:@"%@", urlfinal];
        controller.titulolabel.text = [NSString stringWithFormat:@"%@", urlfinal];
    }
    
    if ([segue.identifier isEqualToString:@"gotomodificar"]){
        reloadPage = YES;
        ModificarWomityViewController *controller = [segue destinationViewController];
        controller.datawomit = datawomit;
        controller.aSesion = aSesion;
    }
    
    if ([segue.identifier isEqualToString:@"gotoinvitardesc"]){
        reloadPage = YES;
        
        [[NSUserDefaults standardUserDefaults] setValue:@"invitar" forKey:@"descripcion"];
        
        invitarViewController *controller = [segue destinationViewController];
        
        controller.idWomit = [datawomit objectForKey:@"idWomity"];
        controller.stringTitle = [datawomit objectForKey:@"Titulo"];
        
        controller.aSesion = aSesion;
        controller.notscroll = YES;
        
        
    }
    
    if ([segue.identifier isEqualToString:@"gotocreaopcion"]){
        reloadPage = YES;
        CrearOpcionViewController *controller = [segue destinationViewController];
        controller.datawomit = datawomit;
        controller.idWomit = [datawomit objectForKey:@"idWomity"];
        controller.aSesion = aSesion;
        
        
    }
    
    if ([segue.identifier isEqualToString:@"gotomodificaropcion"]){
        reloadPage = YES;
        ModificarOpcionViewController *controller = [segue destinationViewController];
        controller.datawomit = datawomit;
        controller.opcion = [[datawomit objectForKey:@"Opciones"] objectAtIndex:modificarTag];
        controller.idWomit = [datawomit objectForKey:@"idWomity"];
        controller.aSesion = aSesion;
        
        
    }
    
}


- (IBAction)gotourlweb:(id)sender{
    UIButton *temporal = (UIButton *) sender;
    NSDictionary *dictionary2 = [dataopciones objectAtIndex:temporal.tag];
    NSLog(@"%@",dictionary2);
    NSURL *url = [ [ NSURL alloc ] initWithString: [NSString stringWithFormat:@"http://%@", [dictionary2 objectForKey:@"Web"]]];
    NSLog(@"%@",url);
    urlfinal = url;
    // [[UIApplication sharedApplication] openURL:url];
    [self performSegueWithIdentifier:@"gotowebview" sender:self];
}

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
    NSDictionary *dictionary2 = [dataopciones objectAtIndex:temporal.tag];
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

- (IBAction)cerrarimagen:(id)sender
{
    vistaimagen.frame = CGRectMake(vistaimagen.frame.origin.x, vistaimagen.frame.origin.y + 480, vistaimagen.frame.size.width, vistaimagen.frame.size.height);
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

- (IBAction)gobackbaby:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)closebaby:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    
    
    [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"soloactivos"];
    [viewController.navigationController popToViewController:[viewController.navigationController.viewControllers objectAtIndex:0] animated:YES];
    
    if([viewController isEqual:self.navigationController]){
        [self hideWindow];
        ishide = YES;
        tipo=@"A";
        [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
        [[NSUserDefaults standardUserDefaults] setValue:@"ppal" forKey:@"accionppal"];
        
        //UITabBarController *tabBarController = self.tabBarController;
        //tabBarController.selectedIndex = 1;
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    return YES;
}

- (void)popNavegar:(NSMutableDictionary *)womit{
    datawomit = womit;
    //[self performSegueWithIdentifier:@"vercomentarios" sender:self];
     idWomity = [womit objectForKey:@"idWomity"];
    NSLog(idWomity);
    [self actualizo];
    comentar = YES;
}

@end
