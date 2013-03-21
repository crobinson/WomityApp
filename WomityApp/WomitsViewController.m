    //
//  WomitsViewController.m
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/15/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "WomitsViewController.h"
#import "WomityViewToolsCell.h"
#import "DescripcionViewController.h"
#import "VotarViewController.h"
#import "invitarViewController.h"
#import "CustomImageView.h"
#import "popViewContainer.h"
#import "ComentariosViewController.h"
#import "FacebookViewController.h"
#import "invitar2ViewController.h"
#import "AppDelegate.h"
#import "MDMultipleMasterDetailManager.h"


@interface WomitsViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation WomitsViewController
@synthesize tipo, vistaimagen, idWomity, dataseleccionado, myTableView, responseData, womities, reloj, aSesion, datawomit, vistareloj, botoncerrar, titulo, datawomitpop;
@synthesize masterPopoverController = _masterPopoverController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Managing the detail item
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appdelegate.masterDetailManager.masterPopoverController != nil) {
        [appdelegate.masterDetailManager.masterPopoverController dismissPopoverAnimated:YES];
    }
    
}

- (void)configureView
{
    // Update the user interface for the detail item
    if (self.detailItem) {
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Taptable = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideWindow)];
    alturas = [[NSMutableArray alloc] init];
    
    myTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    responseData = [NSMutableData data];
    womities = [[NSMutableArray alloc] init];
    comentar = NO;
}

-(void) viewWillAppear:(BOOL)animated
{
    [self setDetailItem:[NSNumber numberWithInt:0]];
    self.tabBarController.delegate = self;
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"soloactivos"] isEqualToString:@"true"]){
        [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"soloactivos"];
        [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];

    }

    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"tipowomit"] isEqualToString:@"A"])
        titulo.text = @"womits activos";
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"tipowomit"] isEqualToString:@"B"])
    titulo.text = @"womits borrador";
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"tipowomit"] isEqualToString:@"F"])
        titulo.text = @"womits finalizados";
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"notificaciones"] isEqualToString:@"true"])
    {
        idWomity = [[NSUserDefaults standardUserDefaults] valueForKey:@"idWomity"];
        [self performSegueWithIdentifier:@"gotodescripcion" sender:self];
        
    }
}
- (void) viewDidAppear:(BOOL)animated
{
    ishide = YES;
    [vistareloj setHidden:NO];
    [reloj startAnimating];
    aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
    
    tipo = [[NSUserDefaults standardUserDefaults] valueForKey:@"tipowomit"];
    if(tipo==NULL){
        tipo = @"A";
    }

    NSString *post = [NSString stringWithFormat:@"&idSession=%@&tipo=%@",aSesion, [[NSUserDefaults standardUserDefaults] valueForKey:@"tipowomit"]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/getWomity"]]];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    titulo.text = @"womits activos";
    
    [self loadViewTipo];
}
- (IBAction)loadtipoB:(id)sender
{
    [self hideWindow];
    ishide = YES;
    tipo=@"B";
    [[NSUserDefaults standardUserDefaults] setValue:@"B" forKey:@"tipowomit"];
    titulo.text = @"womits borrador";
    
    [self loadViewTipo];
    
}
- (IBAction)loadtipoF:(id)sender
{
    [self hideWindow];
    ishide = YES;
    tipo=@"F";
    [[NSUserDefaults standardUserDefaults] setValue:@"F" forKey:@"tipowomit"];
    titulo.text = @"womits finalizados";
    
    [self loadViewTipo];
    
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

- (void)loadViewTipo
{
    [self hideWindow];
    ishide = YES;
    
    ishide = YES;
    [vistareloj setHidden:NO];
    [reloj startAnimating];
    aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
    tipo = [[NSUserDefaults standardUserDefaults] valueForKey:@"tipowomit"];

    if(tipo==NULL){
        tipo = @"A";
    }
    NSLog(@"%@",tipo);
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&tipo=%@",aSesion, tipo];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/getWomity"]]];
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
    [myTableView reloadData];
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
    
    [myTableView removeGestureRecognizer:Taptable];

    [myTableView setFrame:CGRectMake(0,45,320,368)];
    
    [UIView commitAnimations];
    
}

-(void)unHideWindow{
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [myTableView addGestureRecognizer:Taptable];

    [myTableView setFrame:CGRectMake(238,45,320,368)];
    
    [UIView commitAnimations];
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
    UITabBarController *tabBarController = self.tabBarController;
    tabBarController.selectedIndex = 0;
    //[self performSegueWithIdentifier:@"loguearse" sender:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    NSLog(@"%@",json);
    
    NSString *cadenarespuesta = [NSString stringWithFormat:@"%@",json];
    
    NSString *urlconexion = [NSString stringWithFormat:@"%@",connection.currentRequest.URL];
    NSLog(@"%@",urlconexion);
    if([urlconexion isEqualToString:@"http://www.womity.com/ws/getWomity"])
    {
        if ([cadenarespuesta rangeOfString:@"IdSesionNoValido"].location == NSNotFound) {
        //NSArray *arrayjson = json;
            
            if([cadenarespuesta rangeOfString:@"No hay womits en este estado"].location != NSNotFound){
                UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:[json objectForKey:@"strMensaje"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alerta show];
                
                [self hideWindow];
                ishide = YES;
                [[NSUserDefaults standardUserDefaults] setValue:@"crear" forKey:@"accioncrear"];
                UITabBarController *tabBarController = self.tabBarController;
                tabBarController.selectedIndex = 0;
                
                
            
            }else{
                
                womities = json;
                [myTableView reloadData];
            }
           
            //NSLog(@"%@",json);
        
        //self.navigationController.view
        
            [reloj stopAnimating];
            [vistareloj setHidden:YES];
        
            if(womities.count==0)
            {
            //[self performSegueWithIdentifier:@"gotocrear" sender:self];
            }
        
        }else{
            [[NSUserDefaults standardUserDefaults] setValue:NULL forKey:@"id"];
            [reloj stopAnimating];
            [vistareloj setHidden:YES];
            [self dismissModalViewControllerAnimated:YES];
        }

    }else if([urlconexion isEqualToString:@"http://www.womity.com/ws/eliminarWomity"]){
    
        if ([[json objectForKey:@"boolWomity"] isEqualToString:@"true"])
        {
            //[self dismissModalViewControllerAnimated:YES];
           /* 
            NSMutableArray *arraytemp = [(NSArray*)womities mutableCopy];
            [arraytemp removeObjectAtIndex:seleccionadoborrar];
            [myTableView reloadData];*/
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Womit eliminado correctamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alerta show];
           [vistareloj setHidden:YES];
           [reloj stopAnimating];
            
          /*  NSString *post = [NSString stringWithFormat:@"&idSession=%@&tipo=%@",aSesion, [[NSUserDefaults standardUserDefaults] valueForKey:@"tipowomit"]];
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/getWomity"]]];
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
            */
            
        }
    }else{
        if ([cadenarespuesta rangeOfString:@"IdSesionNoValido"].location == NSNotFound) {
            NSLog(@"%@",json);
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:[json objectForKey:@"strMensaje"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alerta show];
        [reloj stopAnimating];
        [vistareloj setHidden:YES];
        }else{
            
            //[self dismissModalViewControllerAnimated:YES];
        }
    }
    [myTableView reloadData];

}


// Customize the number of rows in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Database *db = [[Database alloc] init];
    //womities = [db traerWomitys];
    
	return womities.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView1  cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"womityAcess";
    
    /* WomityViewToolsCell *cell = [tableView1  dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {*/
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
    // }
    // WomityViewToolsCell *cell = (WomityViewToolsCell *)[tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
    WomityViewToolsCell * cell = [[WomityViewToolsCell alloc]  initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    //NSLog(@"%f",cell.frame.size.height);
    isHidePrincipal = NO;
    NSLog(@"%@",[alturas objectAtIndex:indexPath.row]);
    NSDictionary *datadiccionario = [womities objectAtIndex:indexPath.row];
    
    
    [cell.boton1 addTarget:self action:@selector(navegar:) forControlEvents:UIControlEventTouchUpInside];
    [cell.boton2 addTarget:self action:@selector(navegar2:) forControlEvents:UIControlEventTouchUpInside];
    
    if([[datadiccionario objectForKey:@"PermisoOpciones"]isEqualToString:@"S"] || [[datadiccionario objectForKey:@"soyCreador"]isEqualToString:@"TRUE"])
        [cell.boton3 addTarget:self action:@selector(navegar3:) forControlEvents:UIControlEventTouchUpInside];
    else
        [cell.boton3 addTarget:self action:@selector(navegarAlerta:) forControlEvents:UIControlEventTouchUpInside];
        
        
    [cell.boton4 addTarget:self action:@selector(navegar4:) forControlEvents:UIControlEventTouchUpInside];
    [cell.boton5 addTarget:self action:@selector(navegar5:) forControlEvents:UIControlEventTouchUpInside];
  
    

    
    cell.boton1.tag = indexPath.row;
    cell.boton2.tag = [[datadiccionario objectForKey:@"idWomity"] intValue];
    cell.boton3.tag = [[datadiccionario objectForKey:@"idWomity"] intValue];
    cell.boton4.tag = [[datadiccionario objectForKey:@"idWomity"] intValue];
    cell.boton5.tag = indexPath.row;
    
	cell.nameLabel.text = [[datadiccionario objectForKey:@"Titulo"] uppercaseString];
    NSMutableArray *opciones = [datadiccionario objectForKey:@"Opciones"];
    

    
    
    cell.View2.frame = CGRectMake(cell.View2.frame.origin.x, cell.View2.frame.origin.y, cell.View2.frame.size.width, 120);
    cell.View1.frame = CGRectMake(-320, cell.View2.frame.origin.y, cell.View2.frame.size.width, 100);
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        cell.View2.frame = CGRectMake(cell.View2.frame.origin.x, cell.View2.frame.origin.y, cell.View2.frame.size.width, 195);
        cell.View1.frame = CGRectMake(-768, cell.View2.frame.origin.y, cell.View2.frame.size.width, 175);
    }
    
    
    if([tipo isEqualToString:@"B"]){
        cell.vistagris.frame = CGRectMake(cell.vistagris.frame.origin.x, cell.View2.frame.size.height - 20, 0, 0);
        cell.View3.frame = cell.View1.frame;
        cell.View2.frame = CGRectMake(cell.View2.frame.origin.x, cell.View2.frame.origin.y, cell.View1.frame.size.width, cell.View1.frame.size.height);
        cell.View1 = cell.View3;
    }
    
    
    
    if([tipo isEqualToString:@"F"]){
        int linesop = 0;
        
            
            float actualSizeop = 10.0;
            [[NSString stringWithFormat:@"%@ inició el womit %@ y votaron %@ de %@ las que participaron", [datadiccionario objectForKey:@"Creador"], [datadiccionario objectForKey:@"Titulo"],[datadiccionario objectForKey:@"Votaron"], [datadiccionario objectForKey:@"TotalVotaron"]] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10]
                                                                                                                                                                                                                                                                                          minFontSize:10
                                                                                                                                                                                                                                                                                       actualFontSize:&actualSizeop
                                                                                                                                                                                                                                                                                             forWidth:298
                                                                                                                                                                                                                                                                                        lineBreakMode:UILineBreakModeWordWrap];
            
            CGSize sizeop = [[NSString stringWithFormat:@"%@ inició el womit %@ y votaron %@ de %@ las que participaron", [datadiccionario objectForKey:@"Creador"], [datadiccionario objectForKey:@"Titulo"],[datadiccionario objectForKey:@"Votaron"], [datadiccionario objectForKey:@"TotalVotaron"]] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:actualSizeop]];
            
            
            if(sizeop.width > 290){
                float myFloatop = sizeop.width / 290;
                
                linesop = (int)ceil(myFloatop);
                
                
                
                
            }
        
        float altura = 130 + (linesop-1)*10;
        
        cell.vistagris.frame = CGRectMake(cell.vistagris.frame.origin.x, cell.frame.size.height - 20, 0, 0);
        cell.View3.frame = CGRectMake(cell.View1.frame.origin.x, cell.View1.frame.origin.y, cell.frame.size.width, cell.View1.frame.size.height + (linesop-1)*17);
        cell.View2.frame = CGRectMake(cell.View2.frame.origin.x, cell.View2.frame.origin.y, cell.View1.frame.size.width, cell.View1.frame.size.height);
        cell.View1 = cell.View3;
    }
   
    
    if([tipo isEqualToString:@"A"]){
    
        cell.vistagris.frame = CGRectMake(cell.vistagris.frame.origin.x, cell.View2.frame.size.height - 20, cell.vistagris.frame.size.width, cell.vistagris.frame.size.height);
    
    
    
        UILabel *votado = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 10)];
        votado.backgroundColor = [UIColor clearColor];
        //votado.text = @"Votado: %i de 3";
        votado.text = [NSString stringWithFormat:@"Votado: %i de %i",[[datadiccionario objectForKey:@"Votaron"] intValue], [[datadiccionario objectForKey:@"TotalVotaron"] intValue]];
        [votado setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10]];
        [cell.vistagris addSubview:votado];
    
        // Fecha actual
        NSDate *date = [NSDate date];
        int secondsNow =(int)[date timeIntervalSince1970];
    
        // Convierto el string hasta
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *hastaDate = [dateFormat dateFromString:[datadiccionario objectForKey:@"FechaCaducidad"]];
    
        int secondsTarget=(int)[hastaDate timeIntervalSince1970];
        int differenceSeconds=secondsTarget-secondsNow;
        int days=(int)((double)differenceSeconds/(3600.0*24.00));
        int diffDay=differenceSeconds-(days*3600*24);
        int hours=(int)((double)diffDay/3600.00);
        int diffMin=diffDay-(hours*3600);
        int minutes=(int)(diffMin/60.0);
        //int seconds=diffMin-(minutes*60);
    
        UILabel *tiempo = [[UILabel alloc] initWithFrame:CGRectMake(180, 5, 50, 10)];
        tiempo.backgroundColor = [UIColor clearColor];
        tiempo.text =[NSString stringWithFormat:@"TIEMPO "];
        [tiempo setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10]];
        [cell.vistagris addSubview:tiempo];
    
        UILabel *tiempodata = [[UILabel alloc] initWithFrame:CGRectMake(230, 5, 180, 10)];
        tiempodata.backgroundColor = [UIColor clearColor];
        tiempodata.text =[NSString stringWithFormat:@"%id | %ih | %im",days, hours, minutes];
        [tiempodata setFont:[UIFont fontWithName:@"HelveticaNeue" size:10]];
        [cell.vistagris addSubview:tiempodata];
    }
    
    if(![tipo isEqualToString:@"F"]){
    
    for (int i=0; i<opciones.count; i++) {
        if(i<3){
            NSDictionary *opcion = [opciones objectAtIndex:i];
            UILabel *numeral = [[UILabel alloc] initWithFrame:CGRectMake(60, 35 + (i*20), 58, 12)];
            numeral.text = [NSString stringWithFormat:@"%iº ",i+1];
            numeral.textColor = [UIColor redColor];
            [numeral setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            [cell.View2 addSubview:numeral];
            
            UILabel *tituloOpcion = [[UILabel alloc] initWithFrame:CGRectMake(80, 35 + (i*20), 130, 12)];
            tituloOpcion.text = [NSString stringWithFormat:@"- %@",[opcion objectForKey:@"Nombre"]];
            [tituloOpcion setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
            [cell.View2 addSubview:tituloOpcion];
            if(![tipo isEqualToString:@"B"]){
            UIImageView *imagenfondo = [[UIImageView alloc] initWithFrame:CGRectMake(213, 34 + (i*20), 42,10)];
            imagenfondo.image = [UIImage imageNamed:@"bg-menuprincipal"];
            [cell.View2 addSubview:imagenfondo];
            
            UIImageView *imagenporcentaje = [[UIImageView alloc] initWithFrame:CGRectMake(213, 34 + (i*20), [[opcion objectForKey:@"Porcentaje"] intValue] * 42/100,10)];
            imagenporcentaje.image = [UIImage imageNamed:@"bg-menucrear"];
            [cell.View2 addSubview:imagenporcentaje];
            
            UILabel *porcentaje = [[UILabel alloc] initWithFrame:CGRectMake(263, 35 + (i*20), 42, 10)];
            NSString *separador = @"%";
            porcentaje.text = [NSString stringWithFormat:@"%i %@",[[opcion objectForKey:@"Porcentaje"] integerValue], separador];
            porcentaje.textColor = [UIColor redColor];
            porcentaje.backgroundColor = [UIColor clearColor];
            [porcentaje setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]];
            [cell.View2 addSubview:porcentaje];
            }
            
        }
    }
        
        
    }else{
       
        UILabel *opcionganadora = [[UILabel alloc] initWithFrame:CGRectMake(60, 40, 125, 12)];
        opcionganadora.backgroundColor = [UIColor clearColor];
        opcionganadora.text = @"Opción ganadora:";
        [opcionganadora setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]];
        
        [cell.View2 addSubview:opcionganadora];
        
        UILabel *tiempof = [[UILabel alloc] initWithFrame:CGRectMake(60, 55, 125, 12)];
        tiempof.backgroundColor = [UIColor clearColor];
        tiempof.text = @"TIEMPO";
        [tiempof setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]];
        [cell.View2 addSubview:tiempof];
        
        
        UILabel *tiempof2 = [[UILabel alloc] initWithFrame:CGRectMake(106, 55, 190, 12)];
        tiempof2.backgroundColor = [UIColor clearColor];
        
        //NSDate *tmpDate = [NSDate date]; // today
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[dateFormat dateFromString:[datadiccionario objectForKey:@"FechaCaducidad"]]];
        
        int day = [comp day];
        int month = [comp month];
        int year = [comp year];
        
        
        NSDictionary *meses = self.createMonths;
        
        
        tiempof2.text = [NSString stringWithFormat:@"Finalizado: %i de %@ de %i", day,[meses objectForKey:[NSNumber numberWithInt:month]], year];
        [tiempof2 setFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
        
        [cell.View2 addSubview:tiempof2];
        
        if(opciones.count>0){
        NSDictionary *opcion = [opciones objectAtIndex:0];
            
            
            if([[opcion objectForKey:@"Porcentaje"] integerValue] !=0 ){
            
            UILabel *tituloOpcion = [[UILabel alloc] initWithFrame:CGRectMake(158, 40, 100, 12)];
            tituloOpcion.text = [NSString stringWithFormat:@"%@",[opcion objectForKey:@"Nombre"]];
            [tituloOpcion setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]];
            tituloOpcion.textColor = [UIColor redColor];
            [cell.View2 addSubview:tituloOpcion];
            
            UILabel *porcentaje = [[UILabel alloc] initWithFrame:CGRectMake(263, 40, 42, 10)];
            NSString *separador = @"%";
            porcentaje.text = [NSString stringWithFormat:@"%i %@",[[opcion objectForKey:@"Porcentaje"] integerValue], separador];
            porcentaje.textColor = [UIColor redColor];
            porcentaje.backgroundColor = [UIColor clearColor];
            [porcentaje setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]];
            [cell.View2 addSubview:porcentaje];
            }
            
        }
    UIWebView *creador = [[UIWebView alloc] initWithFrame:CGRectMake(0, 75, 300, 10)];
        [creador loadHTMLString:[NSString stringWithFormat:@"<html><body style=\"font-family:Helvetica; font-size:10px; background-color: transparent; color:black;\"><span style=\"color:red;\">%@</span> inició el womit <span style=\"color:red;\">%@</span> y votaron <span style=\"color:red;\">%@</span> de las <span style=\"color:red;\">%@</span> que participaron</body></html>", [datadiccionario objectForKey:@"Creador"], [datadiccionario objectForKey:@"Titulo"], [datadiccionario objectForKey:@"Votaron"], [datadiccionario objectForKey:@"TotalVotaron"]] baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
        creador.delegate = self;
        creador.opaque = NO;
        creador.backgroundColor = [UIColor clearColor];
        
        UIView *minilineagris = [[UIView alloc] initWithFrame:CGRectMake(creador.frame.origin.x, cell.View3.frame.size.height, creador.frame.size.width, 2)];
        minilineagris.backgroundColor = [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1];
        
        cell.View2.frame = CGRectMake(cell.View2.frame.origin.x, cell.View2.frame.origin.y, cell.View2.frame.size.width, cell.View1.frame.size.height );
        
        [cell.View2 addSubview:creador];
        [cell.View2 addSubview:minilineagris];
           }
    
    if(opciones.count>0){
        
        dataopciones = opciones;
        CustomImageView *imagenthumb = [[CustomImageView alloc] initWithFrame:CGRectMake(8, 35, 45, 45)];
        
        
        NSDictionary *opcion = [opciones objectAtIndex:0];
        NSString *urlimagencompleta = [NSString stringWithFormat:@"http://www.womity.com/%@", [opcion objectForKey:@"URLImagenThumb"]];
        /*NSURL *url = [NSURL URLWithString:urlimagencompleta];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        imagenthumb.image = image;
        [cell.View2 addSubview:imagenthumb];*/
        
        [imagenthumb setURL:[NSURL URLWithString:urlimagencompleta]];
         [cell.View2 addSubview:imagenthumb];
        
        UIButton *gotoimg = [UIButton buttonWithType:UIButtonTypeCustom];
        gotoimg.frame = imagenthumb.frame;
        [gotoimg addTarget:self action:@selector(verimagen:) forControlEvents:UIControlEventTouchUpInside];
        gotoimg.tag = indexPath.row;
        [cell.View2 addSubview:gotoimg];
    }

if([tipo isEqualToString:@"B"]){
    UIView *minilineagris = [[UIView alloc] initWithFrame:CGRectMake(0, cell.View2.frame.size.height - 2, cell.View2.frame.size.width, 2)];
    minilineagris.backgroundColor = [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1];
    [cell.View2 addSubview:minilineagris];
}

    return cell;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGRect rect = webView.frame;
    UIScrollView *scrollHeight = (UIScrollView *)[webView.subviews objectAtIndex:0];
    scrollHeight.scrollEnabled = NO;
    scrollHeight.pagingEnabled = NO;
    rect.size.height = scrollHeight.contentSize.height;
    webView.frame = rect;
}
-(NSDictionary *)createMonths{
    
    NSArray *arrayDate = [NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3],[NSNumber numberWithInt:4],[NSNumber numberWithInt:5],[NSNumber numberWithInt:6],[NSNumber numberWithInt:7],[NSNumber numberWithInt:8],[NSNumber numberWithInt:9],[NSNumber numberWithInt:10],[NSNumber numberWithInt:11],[NSNumber numberWithInt:12],nil];
    NSArray *arrayMonth = [NSArray arrayWithObjects:@"Enero",@"Febrero",@"Marzo",@"Abril",@"Mayo",@"Junio",@"Julio",@"Agosto",@"Septiembre",@"Octubre",@"Noviembre",@"Diciembre",nil];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:arrayMonth forKeys:arrayDate];
    return dictionary;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    //WomityViewToolsCell *nombrecelda = (WomityViewToolsCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    NSDictionary *datadiccionario = [womities objectAtIndex:indexPath.row];
    NSMutableArray *opciones = [datadiccionario objectForKey:@"Opciones"];
    CGFloat height = 130.0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        height = 200.0;
    
    
    if([tipo isEqualToString:@"B"] ){
        height = 110.0;
        //int linesop = 1;
    }
    /*int numeroOpciones = opciones.count;
    int extrasize = 0;
    if(numeroOpciones > 3){
        
        extrasize = 20*numeroOpciones;
    }
    
    */
    int linesop = 1;
     
    if([tipo isEqualToString:@"F"]){
    linesop = 0;
        float actualSizeop = 10.0;
        [[NSString stringWithFormat:@"%@ inició el womit %@ y votaron %@ de %@ las que participaron", [datadiccionario objectForKey:@"Creador"], [datadiccionario objectForKey:@"Titulo"],[datadiccionario objectForKey:@"Votaron"], [datadiccionario objectForKey:@"TotalVotaron"]] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10]
                                      minFontSize:10
                                   actualFontSize:&actualSizeop
                                         forWidth:299
                                    lineBreakMode:UILineBreakModeWordWrap];
    
        CGSize sizeop = [[NSString stringWithFormat:@"%@ inició el womit %@ y votaron %@ de %@ las que participaron", [datadiccionario objectForKey:@"Creador"], [datadiccionario objectForKey:@"Titulo"],[datadiccionario objectForKey:@"Votaron"], [datadiccionario objectForKey:@"TotalVotaron"]] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:actualSizeop]];
    
   
        if(sizeop.width > 290){
            float myFloatop = sizeop.width / 290;
        
            linesop = (int)ceil(myFloatop);
        
        
           
       
    }
        
    }
    
    [alturas addObject:[NSString stringWithFormat:@"%f",height+ (linesop-1)*10]];
    return height + (linesop-1)*10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults] setValue:@"desc" forKey:@"accionppal"];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    [myTableView setFrame:CGRectMake(0,45,myTableView.frame.size.width,myTableView.frame.size.height)];
    
    [UIView commitAnimations];
    
    //self.navigationController.view
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    selectedRow = indexPath.row;
    comentar = NO;
    [self performSegueWithIdentifier:@"gotodescripcion" sender:self];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gotodescripcion"]){
        DescripcionViewController *controller = [segue destinationViewController];
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"notificaciones"] isEqualToString:@"true"]){
            controller.idWomity = idWomity;
        }else{
        controller.datawomit = [womities objectAtIndex:selectedRow];
        }
        controller.aSesion = aSesion;
        
        if(comentar){
            controller.comentar = YES;
        }
    }
    
    if ([segue.identifier isEqualToString:@"vercomentarios"]){
        ComentariosViewController *controller = [segue destinationViewController];
        controller.datawomit = datawomitnew;
        controller.aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
        controller.comentar = YES;
        controller.idWomity = [datawomitnew objectForKey:@"idWomity"];
        
    }
    
    if ([segue.identifier isEqualToString:@"direcvotar"]){
        VotarViewController *controller = [segue destinationViewController];
        controller.datawomit = datawomit;
        controller.aSesion = aSesion;
        
        
    }
    
    if ([segue.identifier isEqualToString:@"invitarcelda"]){
        [[NSUserDefaults standardUserDefaults] setValue:@"invitar" forKey:@"descripcion"];
        invitar2ViewController *controller = [segue destinationViewController];
        controller.espasotres = NO;
        //    tipo=@"B"
        if([tipo isEqualToString:@"B"])
            controller.espasotres = YES;
        NSDictionary *datawomit = [womities objectAtIndex:selectedRow];
        controller.idWomit = [datawomit objectForKey:@"idWomity"];
        controller.aSesion = aSesion;
        controller.stringTitle = [datawomit objectForKey:@"Titulo"];
        controller.notscroll = YES;
        
        
    }
    
    if ([segue.identifier isEqualToString:@"facebook"]){
        
        FacebookViewController *facebook = [segue destinationViewController];
        facebook.isFacebook = YES;
        
        
    }
}


-(void)navegarAlerta:(id) sender{
  
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"Este womit es cerrado. Sólo puede añadir invitados su creador" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    
}
-(void)navegar:(id) sender{
    UIButton *temporal = (UIButton *) sender;
     datawomit = [womities objectAtIndex:temporal.tag];
    
    if (![tipo isEqualToString:@"F"]) {
        [self performSegueWithIdentifier:@"direcvotar" sender:self];
    }else {
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"No se pueden ejecutar acciones en los womits Finalizados" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }
}
-(void)navegar2:(id) sender{
    UIButton *temporal = (UIButton *) sender;
    comentar = YES;
    idWomity = [NSString stringWithFormat:@"%i",temporal.tag];
    //[self performSegueWithIdentifier:@"votarsegue" sender:self];
    if (![tipo isEqualToString:@"F"]) {
        [self performSegueWithIdentifier:@"gotodescripcion" sender:self];
    }else {
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"No se pueden ejecutar acciones en los womits Finalizados" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }
}
-(void)navegar3:(id) sender{
    UIButton *temporal = (UIButton *) sender;
    
    idWomity = [NSString stringWithFormat:@"%i",temporal.tag];
    if (![tipo isEqualToString:@"F"]) {
        [self performSegueWithIdentifier:@"invitarcelda" sender:self];
    }else {
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"No se pueden ejecutar acciones en los womits Finalizados" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }
}
-(void)navegar4:(id) sender{
    UIButton *temporal = (UIButton *) sender;
    
    
    for (NSDictionary *dictionary in womities){
        if ([[dictionary valueForKey:@"idWomity"] isEqualToString:[NSString stringWithFormat:@"%i",temporal.tag]]){
            datawomit = dictionary;
        }
    }
    
    NSLog(@"%@",datawomit);
    UIActionSheet *  action=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"E-mail" ,@"Facebook",@"Twitter", nil];
    action.delegate = self;
    [action showInView:[[UIApplication sharedApplication] keyWindow]];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSString *urlAddress = @"";
    
    NSString *nameUser = @"";
    
    
    if (buttonIndex==0)
    {
        
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"IDRegistro"]);
        
        MFMailComposeViewController *tempMailCompose = [[MFMailComposeViewController alloc] init];
        
        tempMailCompose.mailComposeDelegate = self;
        [tempMailCompose setSubject:@"Womity"];
        [tempMailCompose setMessageBody:[NSString stringWithFormat:@"%@ ha participado en el womit creado por %@ en www.womity.com ",[[NSUserDefaults standardUserDefaults] valueForKey:@"NombreUsuario"],[datawomit valueForKey:@"Creador"]] isHTML:NO];
        
        [self presentModalViewController:tempMailCompose animated:YES];
        
    }else if (buttonIndex==1)
    {
        
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"token"] == nil){
            
            UIAlertView *alertView1 = [[UIAlertView alloc] initWithTitle:@"Womity" message:@"Inicia sesión en facebook e intenta compartir nuevamente" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView1 show];
            [self performSegueWithIdentifier:@"facebook" sender:nil];
            
        }else{
            
            alertView = [[UIAlertView alloc] initWithTitle:@"Womity" message:@"Un momento ...\n" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
            UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 70, 30, 30)];
            progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
            [alertView addSubview:progress];
            [progress startAnimating];
            
            [alertView show];
            
            
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendFacebook) userInfo:nil repeats:NO];
            
        }
        
    }else if(buttonIndex==2)
    {
        
        TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
        
        [twitter setInitialText:[NSString stringWithFormat:@"%@ ha participado en el womit creado por %@ en www.womity.com",[[NSUserDefaults standardUserDefaults] valueForKey:@"NombreUsuario"],[datawomit valueForKey:@"Creador"]]];
        [self presentViewController:twitter animated:YES completion:nil];
        twitter.completionHandler = ^(TWTweetComposeViewControllerResult res) {
            [self dismissModalViewControllerAnimated:YES];
        };
        
    }
    
}

-(void)sendFacebook{
    NSString *string = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"token"] componentsSeparatedByString:@"="] objectAtIndex:0];
    [self connectionFacebook:[NSString stringWithFormat:@"&picture=http://www.grupo318.com/images/dapp/thumbs/womity.jpg&message= %@ ha participado en el womit creado por %@ en www.womity.com &description=Womity, la herramienta para la toma de decisiones en grupo, fácil y divertida.&link=http://www.womity.com&access_token=%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"NombreUsuario"],[datawomit valueForKey:@"Creador"],string]:[NSURL URLWithString:@"https://graph.facebook.com/me/feed"]];
    
    [alertView dismissWithClickedButtonIndex:-1 animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Womity" message:@"Has publicado el actual womit en tu cuenta de Facebook" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(NSString *)connectionFacebook:(NSMutableString *) jsonRequest:(NSURL *)url
{
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    NSString*post = [NSString stringWithFormat:@"%@", jsonRequest];
    //   //NSLog(@"%@",post);
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if(urlData !=nil)
    {
        NSString * result = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
        ////NSLog(@"%@",result);
        return result;
    }
    else
        return [error localizedDescription];
    
    return nil;
    
    
}

// Displays an email composition interface inside the application. Populates all the Mail fields.
- (void) displayComposerSheet:(NSString *)body {
    
    
    
	MFMailComposeViewController *tempMailCompose = [[MFMailComposeViewController alloc] init];
    
	tempMailCompose.mailComposeDelegate = self;
	[tempMailCompose setSubject:@"Womity"];
	[tempMailCompose setMessageBody:body isHTML:NO];
    
	[self presentModalViewController:tempMailCompose animated:YES];

}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Result: canceled");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Result: saved");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Result: sent");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Result: failed");
			break;
		default:
			NSLog(@"Result: not sent");
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}

-(void)navegar5:(id) sender{
    [vistareloj setHidden:NO];
    [reloj startAnimating];
    UIButton *temporal = (UIButton *) sender;
    
    NSDictionary *datadiccionario = [womities objectAtIndex:temporal.tag];
    idWomity = [datadiccionario objectForKey:@"idWomity"];
    seleccionadoborrar = temporal.tag;
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&idWomity=%@",aSesion, idWomity];
    
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
    
    NSLog(@"%i",temporal.tag);
    //[myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:temporal.tag inSection:0]] withRowAnimation:YES];
    womities = [(NSArray*)womities mutableCopy];
    [womities removeObjectAtIndex:temporal.tag];
    [myTableView reloadData];
}

-(void)animationLeftTool:(UISwipeGestureRecognizer *)recognizer{
    
    if (isHidePrincipal){
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        
        CGRect rectViewUp = View2.frame;
        rectViewUp.origin = CGPointMake(0, 0);
        View2.frame = rectViewUp;
        
        CGRect rectViewUp2 = View3.frame;
        rectViewUp2.origin = CGPointMake(0, 0);
        View3.frame = rectViewUp2;
        
        isHidePrincipal = NO;
        [UIView commitAnimations];
        
    }else{
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        
        CGRect rectViewUp = View3.frame;
        rectViewUp.origin = CGPointMake(-320, 0);
        View3.frame = rectViewUp;
        isHidePrincipal = YES;
        [UIView commitAnimations];
        
        
        
    }
    
}

-(void)animationRightKill:(UISwipeGestureRecognizer *)recognizer{
    
    if (isHidePrincipal){
        
        
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        
        CGRect rectViewUp = View3.frame;
        rectViewUp.origin = CGPointMake(0, 0);
        View3.frame = rectViewUp;
        
        isHidePrincipal = NO;
        
        [UIView commitAnimations];
        
        
        
    }else{
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        
        CGRect rectViewUp = View2.frame;
        rectViewUp.origin = CGPointMake(320, 0);
        View2.frame = rectViewUp;
        
        CGRect rectViewUp2 = View3.frame;
        rectViewUp2.origin = CGPointMake(320, 0);
        View3.frame = rectViewUp2;
        
        isHidePrincipal = YES;
        
        [UIView commitAnimations];
        
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
    NSDictionary *datadiccionario = [womities objectAtIndex:temporal.tag];
    NSMutableArray *opciones = [datadiccionario objectForKey:@"Opciones"];
   
        NSDictionary * dictionary2 = [opciones objectAtIndex:0];
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
    for(UIView *subview in [vistaimagen subviews]) {
        [subview removeFromSuperview];
    }
    
    [vistaimagen addSubview:botoncerrar];
    vistaimagen.frame = CGRectMake(vistaimagen.frame.origin.x, 0, vistaimagen.frame.size.width, vistaimagen.frame.size.height);
    UIButton *temporal = (UIButton *) sender;
    NSDictionary *datadiccionario = [womities objectAtIndex:temporal.tag];
    dataopciones = [datadiccionario objectForKey:@"Opciones"];
    NSDictionary *dictionary2 = [dataopciones objectAtIndex:0];
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
    
}*/

- (IBAction)cerrarimagen:(id)sender
{
    vistaimagen.frame = CGRectMake(vistaimagen.frame.origin.x, vistaimagen.frame.origin.y + 480, vistaimagen.frame.size.width, vistaimagen.frame.size.height);
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
    datawomitnew = womit;
    [self performSegueWithIdentifier:@"vercomentarios" sender:self];
    
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    
    
    [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"soloactivos"];
    [viewController.navigationController popToViewController:[viewController.navigationController.viewControllers objectAtIndex:0] animated:YES];
    
    if([viewController isEqual:self.navigationController]){
        [self hideWindow];
        ishide = YES;
        tipo=@"A";
        [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
        [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"soloactivos"];
        titulo.text = @"womits activos";
        
        [self loadViewTipo];
        
    }
    
    return YES;
}

- (void)viewDidUnload {
    relojimagen = nil;
    [super viewDidUnload];
}

/*
 Delegate del SplitView, permite cambiar el boton del menu por imagenes o dejarse.
 */
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    
    
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}
@end
