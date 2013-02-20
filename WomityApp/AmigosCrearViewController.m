//
//  AmigosCrearViewController.m
//  Womity
//
//  Created by Carlos Andres Robinson Lara on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AmigosCrearViewController.h"
#import "popViewContainer.h"
#import "CustomImageView.h"

@interface AmigosCrearViewController ()

@end

@implementation AmigosCrearViewController
@synthesize myTableView;
@synthesize vistareloj;
@synthesize reloj, delegate, vistarelopj;

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
     [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"soloactivos"];
    responseData = [NSMutableData data];
    [reloj startAnimating];
    [super viewDidLoad];
    idamigos = [[NSMutableArray alloc] init];
    mailamigos = [[NSMutableArray alloc] init];
    tableData = [[NSMutableDictionary alloc] init];
    dictionaryData= [[NSMutableArray alloc] init];
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
    
    NSString *post = [NSString stringWithFormat:@"&idSession=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"id"]];
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
    
myTableView.frame = CGRectMake(0, 44, 320, 410);

    
}


- (void)viewDidUnload
{
    [self setMyTableView:nil];
    relojimagen = nil;
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
// Customize the number of rows in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dictionaryData count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary * dictio = [dictionaryData objectAtIndex:section];
    NSArray *array = [dictio objectForKey:@"contacts"];
    return [array count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [arraySection objectAtIndex:section];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AmigoCell"];
    
    NSDictionary *dictionaryAll = [dictionaryData objectAtIndex:indexPath.section];
    NSArray *array = [dictionaryAll objectForKey:@"contacts"];
    NSDictionary *datadiccionario = [array objectAtIndex:indexPath.row];
    
    for (id view in cell.subviews){
        if ([view isKindOfClass:[CustomImageView class]]){
            CustomImageView *image = (CustomImageView *)view;
            [image removeFromSuperview];
        }
    }
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:301];
    UILabel *descipcionLabel = (UILabel *)[cell viewWithTag:302];
    /*UIImageView *imagenPpal = (UIImageView *)[cell viewWithTag:300];
    NSURL *url = [NSURL URLWithString:[datadiccionario objectForKey:@"URLImagen"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:data];*/
    nameLabel.text = [datadiccionario objectForKey:@"NombreAmigo"];
    descipcionLabel.text = [datadiccionario objectForKey:@"EmailAmigo"];
    
    //imagenPpal.image = image;
    CustomImageView *imagenthumb = [[CustomImageView alloc] initWithFrame:CGRectMake(4, 4, 56, 56)];
    [imagenthumb setImage:[UIImage imageNamed:@""]];
    [imagenthumb setURL:[NSURL URLWithString:[datadiccionario objectForKey:@"URLImagenThumb"]]];
    [cell addSubview:imagenthumb];
    UIButton *gotoimg = [UIButton buttonWithType:UIButtonTypeCustom];
    gotoimg.frame = CGRectMake(4, 4, 56, 56);
    [gotoimg addTarget:self action:@selector(verimagen:) forControlEvents:UIControlEventTouchUpInside];
    gotoimg.tag = [[datadiccionario objectForKey:@"Id"] integerValue]; 
    if(![[datadiccionario objectForKey:@"URLImagen"] isEqualToString:@""])
        [cell addSubview:gotoimg];
    
    for (NSString * string in idamigos){
        if ([string isEqualToString:[datadiccionario objectForKey:@"Id"]]){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
   /* if([[tableData objectForKey:[NSString stringWithFormat:@"%i",indexPath.row]] isEqualToString:@"Checked"]){
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.selectionStyle = UITableViewCellEditingStyleNone;*/
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",[amigos objectAtIndex:indexPath.row]);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dictionaryAll = [dictionaryData objectAtIndex:indexPath.section];
    NSArray *array = [dictionaryAll objectForKey:@"contacts"];
    NSDictionary *datadiccionario = [array objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
	{
		cell.accessoryType = UITableViewCellAccessoryNone;
        [idamigos removeObject:[datadiccionario objectForKey:@"Id"]];
        [mailamigos removeObject:[datadiccionario objectForKey:@"EmailAmigo"]];
        [tableData setValue:@"unChecked" forKey:[NSString stringWithFormat:@"%i",indexPath.row]];
        
	}else {
        [tableData setValue:@"Checked" forKey:[NSString stringWithFormat:@"%i",indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [idamigos addObject:[datadiccionario objectForKey:@"Id"]];
        [mailamigos addObject:[datadiccionario objectForKey:@"EmailAmigo"]];
    }
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSLog(@"%@",arraySection);
    return arraySection;
}

-(void)removeFromCheckList:(NSString *)iden{
    for (int i = 0; i < [idamigos count]; i++){
        NSString *s = [idamigos objectAtIndex:i];
        if ([s isEqualToString:iden]){
            [idamigos removeObjectAtIndex:i];
        }
    }
    
    //[self removeAllCheckList];
    // [tableView reloadData];
}

-(void)removeAllCheckList{
    for (int i = [idamigos count] -1; i >=0 ; i--){
        [idamigos removeObjectAtIndex:i];
    }
    [myTableView reloadData];
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
    [vistareloj setFrame:CGRectMake(0,self.view.frame.size.height,self.view.frame.size.width,self.view.frame.size.height)];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    
    NSLog(@"%@",responseData);
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          options:kNilOptions
                          error:&error];
    
    amigos = [json objectForKey:@"Contactos"];
    
    for(int i= 0; i<amigos.count; i++){
        [tableData setValue:@"unChecked" forKey:[NSString stringWithFormat:@"%i",i]];
    }
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"name"  ascending:YES];
    [amigos sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    NSArray * recent = [amigos copy];
    
    arraySection  = [[NSMutableArray alloc] init];
    
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
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistareloj setFrame:CGRectMake(0,self.view.frame.size.height,self.view.frame.size.width,self.view.frame.size.height)];
    [UIView commitAnimations];
    [reloj stopAnimating];
    
    myTableView.reloadData;
    
    
}

- (IBAction)cancel:(id)sender
{
	[self.delegate AmigosCrearViewControllerDidCancel:self];
}

- (IBAction)agregar:(id)sender
{
    NSLog(@"%@", mailamigos);
	[self.delegate AmigosViewControllerAgregar:idamigos deAmigos:mailamigos];
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
    
    NSDictionary *datadiccionario = [[NSDictionary alloc] init];
    
    
    
    for(int i=0; i<amigos.count;i++){
        
        NSDictionary *datadiccionariotemp = [amigos objectAtIndex:i];
        NSLog(@"%@", amigos);
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
        [self.view addSubview:popoverController];
    }else{
        [popoverController fadeOFFEmergency];
        [popoverController removeFromSuperview];
        popoverController = nil;
    }
    
}

@end
