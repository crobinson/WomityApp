//
//  AmigosViewController.m
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/19/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "AmigosViewController.h"
#import "CustomImageView.h"
#import "popViewContainer.h"
#import "ComentariosViewController.h"

@interface AmigosViewController ()

@end

@implementation AmigosViewController
@synthesize reloj, vistareloj, myTableView, myview;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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


-(void)hideWindow{
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    [myview setFrame:CGRectMake(0,44,320,368)];
    
    [UIView commitAnimations];
    
}

-(void)unHideWindow{
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [myview setFrame:CGRectMake(238,44,320,368)];
    
    [UIView commitAnimations];
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
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    //[[NSUserDefaults standardUserDefaults] valueForKey:@"friends"]
  
 [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"soloactivos"];
    ishide = YES;
    self.tabBarController.delegate = self;
    responseData = [NSMutableData data];
    aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
    [vistareloj setHidden:NO];
    [reloj startAnimating];
    NSString *post = [NSString stringWithFormat:@"&idSession=%@",aSesion];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/getContactos"]]];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrayLetter = [[NSMutableArray alloc] init];
    
    [arrayLetter addObject:@"aA"];
    [arrayLetter addObject:@"bB"];
    [arrayLetter addObject:@"cC"];
    [arrayLetter addObject:@"dD"];
    [arrayLetter addObject:@"eE"];
    [arrayLetter addObject:@"fF"];
    [arrayLetter addObject:@"gG"];
    [arrayLetter addObject:@"hH"];
    [arrayLetter addObject:@"iI"];
    [arrayLetter addObject:@"jJ"];
    [arrayLetter addObject:@"kK"];
    [arrayLetter addObject:@"lL"];
    [arrayLetter addObject:@"mM"];
    [arrayLetter addObject:@"nN"];
    [arrayLetter addObject:@"oO"];
    [arrayLetter addObject:@"pP"];
    [arrayLetter addObject:@"qQ"];
    [arrayLetter addObject:@"rR"];
    [arrayLetter addObject:@"sS"];
    [arrayLetter addObject:@"tT"];
    [arrayLetter addObject:@"uU"];
    [arrayLetter addObject:@"vV"];
    [arrayLetter addObject:@"wW"];
    [arrayLetter addObject:@"xX"];
    [arrayLetter addObject:@"yY"];
    [arrayLetter addObject:@"zZ"];
    
    arrayChekList = [[NSMutableArray alloc] init];
   
    
    ishide = YES;
    responseData = [NSMutableData data];
    aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
    [reloj startAnimating];
    NSString *post = [NSString stringWithFormat:@"&idSession=%@",aSesion];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/getContactos"]]];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return [dictionaryData count];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"5. Index = %i of %i",section,[dictionaryData count]);
    NSDictionary * dictio = [dictionaryData objectAtIndex:section];
    NSArray *array = [dictio objectForKey:@"contacts"];

    return [array count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSLog(@"3. Index = %i of %i",section,[arraySection count]);
    if(section < [arraySection count])
        return [arraySection objectAtIndex:section];
    else
        return @"";
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return arraySection;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AmigoCell"];
    
    NSLog(@"1. Index = %i of %i",indexPath.section,[dictionaryData count]);
    NSDictionary *dictionaryAll = [dictionaryData objectAtIndex:indexPath.section];
    
    NSArray *array = [dictionaryAll objectForKey:@"contacts"];
    if (indexPath.row < [array count]){
        NSLog(@"2. Index = %i of %i",indexPath.row,[array count]);
    NSDictionary *datadiccionario = [array objectAtIndex:indexPath.row];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:301];
    UIButton *descipcionLabel = (UIButton *)[cell viewWithTag:302];
    CustomImageView *imagenPpal = (CustomImageView *)[cell viewWithTag:300];
    NSURL *url = [NSURL URLWithString:[datadiccionario objectForKey:@"URLImagenThumb"]];
    [imagenPpal  setURL:url];
    descipcionLabel.tag = [[datadiccionario objectForKey:@"Id"] intValue];
    [descipcionLabel addTarget:self action:@selector(eliminarcontacto:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *gotoimg = [UIButton buttonWithType:UIButtonTypeCustom];
    gotoimg.frame = imagenPpal.frame;
    [gotoimg addTarget:self action:@selector(verimagen:) forControlEvents:UIControlEventTouchUpInside];
    gotoimg.tag = [[datadiccionario objectForKey:@"Id"] integerValue];
        if(![[datadiccionario objectForKey:@"URLImagen"] isEqualToString:@""])
            [cell addSubview:gotoimg];
    
    
    //UIImage *image = [UIImage imageWithData:data];
    nameLabel.text = [datadiccionario objectForKey:@"NombreAmigo"];
    }
    
   // imagenPpal.image = image;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    NSString *urlconexion = [NSString stringWithFormat:@"%@",connection.currentRequest.URL];
    
    if([urlconexion isEqualToString:@"http://www.womity.com/ws/getContactos"])
    {
        amigos = [json objectForKey:@"Contactos"];
        NSLog(@"%@",amigos);
    
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"name"  ascending:YES];
    [amigos sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    NSArray * recent = [amigos copy];
    
    arraySection  = [[NSMutableArray alloc] init];
     dictionaryData = [[NSMutableArray alloc] init];
    for (NSString * letters in arrayLetter){
        NSMutableArray * array = [[NSMutableArray alloc] init];
        NSString *min = [NSString stringWithFormat:@"%c",[letters characterAtIndex:0]];
        NSString *max = [NSString stringWithFormat:@"%c",[letters characterAtIndex:1]];
        for(NSDictionary *dictionary in recent){
            
            
            NSString *string = [dictionary valueForKey:@"NombreAmigo"];
            NSString *firstletter = [NSString stringWithFormat:@"%c",[string characterAtIndex:0]];
            
            if ([firstletter isEqualToString:max] || [firstletter isEqualToString:min]){
                [array addObject:dictionary];
            }
        }
        if ([array count] > 0){
            [dictionaryData addObject:[NSDictionary dictionaryWithObjectsAndKeys:array,@"contacts",max,@"letter",nil]];
            [arraySection addObject:max];
        }
        array = nil;
    }
        NSString *post = [NSString stringWithFormat:@"&idSession=%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"id"]];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/SolicitudAmistadCount"]]];
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

    
    //self.navigationController.view
    [reloj stopAnimating];
    [vistareloj setHidden: YES];
    [myTableView reloadData];
    }else if ([urlconexion isEqualToString:@"http://www.womity.com/ws/eliminarContacto"]){
        //
        [vistareloj setHidden:NO];
        [reloj startAnimating];
        NSString *post = [NSString stringWithFormat:@"&idSession=%@",aSesion];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/getContactos"]]];
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
        [myTableView reloadData];
    }else{
        
        NSString *total = [NSString stringWithFormat:@"%@",[json objectForKey:@"0"]];
        
        [[NSUserDefaults standardUserDefaults] setValue:total forKey:@"friends"];
        UITabBarController *tabBarController = self.tabBarController;
        UIViewController *requiredViewController = [tabBarController.viewControllers objectAtIndex:2];
        UITabBarItem *item = requiredViewController.tabBarItem;
        if([total isEqualToString:@"0"]){
            solicitudescont.text = @"";
            [item setBadgeValue:nil];
        }else{
            solicitudescont.text = total;
            [item setBadgeValue:total];
        }
        
        
        
        
    }
    
    
    
}

-(IBAction)buscar:(id)sender{
    [self performSegueWithIdentifier:@"gotobuscar" sender:self];
}
-(IBAction)cancel:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)eliminarcontacto:(id)sender{
    UIButton *temporal = (UIButton *) sender;
    NSString *idContacto = [NSString stringWithFormat:@"%i",temporal.tag];
    responseData = [NSMutableData data];
    aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
    [reloj startAnimating];
    [vistareloj setHidden: NO];
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&idContacto=%@",aSesion, idContacto];
    NSLog(@"%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/eliminarContacto"]]];
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

/*- (IBAction)verimagen:(id)sender
{
    for(UIView *subview in [vistaimagen subviews]) {
        [subview removeFromSuperview];
    }
    
    [vistaimagen addSubview:botoncerrar];
    vistaimagen.frame = CGRectMake(vistaimagen.frame.origin.x, 0, vistaimagen.frame.size.width, vistaimagen.frame.size.height);
    UIButton *temporal = (UIButton *) sender;
    NSLog(@"4. Index = %i of %i",temporal.tag,[amigos count]);
    NSDictionary *datadiccionario = [amigos objectAtIndex:temporal.tag];
   // dataopciones = [datadiccionario objectForKey:@"Opciones"];
   // NSDictionary *dictionary2 = [dataopciones objectAtIndex:0];
   // NSLog(@"%@",dictionary2);

    NSString *urlimagencompleta = [NSString stringWithFormat:@"%@", [datadiccionario objectForKey:@"URLImagen"]];
    NSLog(@"%@", urlimagencompleta);
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
    
    NSDictionary *datadiccionario = [[NSDictionary alloc] init];
    
    
    
    for(int i=0; i<amigos.count;i++){
        
        NSDictionary *datadiccionariotemp = [amigos objectAtIndex:i];
        
        if([[datadiccionariotemp objectForKey:@"Id"] integerValue] == temporal.tag)
            
            datadiccionario = datadiccionariotemp;
        
    }
    
    
    
    
    
    
    
    
    
    // dataopciones = [datadiccionario objectForKey:@"Opciones"];
    
    // NSDictionary *dictionary2 = [dataopciones objectAtIndex:0];
    
    // NSLog(@"%@",dictionary2);
    
    
    
    NSString *urlimagencompleta = [NSString stringWithFormat:@"http://www.womity.com%@", [datadiccionario objectForKey:@"URLImagen"]];
    
    NSLog(@"%@", urlimagencompleta);
    
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
            alto = temporalimg.frame.size.height;
            ancho = temporalimg.frame.size.width;
        }
    }
        
    
    
    
    
    UIImageView *vistaimg = [[UIImageView alloc] initWithFrame:CGRectMake((320-ancho)/2, (430-alto)/2, ancho, alto)];
    
    NSLog(@"%f, %f, %f, %f",vistaimg.frame.origin.x, vistaimg.frame.origin.y, vistaimg.frame.size.width, vistaimg.frame.size.height);
    
    vistaimg.image = imagenthumb;
    
    [vistaimagen addSubview:vistaimg];
    
    [vistaimagen bringSubviewToFront:botoncerrar];
    
    [relojimagen stopAnimating];
    
    
    
    [UIView commitAnimations];
    
    
    
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

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    //NSLog(@"%@",viewController);
    [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
    [[NSUserDefaults standardUserDefaults] setValue:@"ppal" forKey:@"accionppal"];
    [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"soloactivos"];
    //[viewController.navigationController popToViewController:[viewController.navigationController.viewControllers objectAtIndex:0] animated:YES];
    
    return YES;
}


- (void)viewDidUnload {
    relojimagen = nil;
    solicitudescont = nil;
    [super viewDidUnload];
}
@end
