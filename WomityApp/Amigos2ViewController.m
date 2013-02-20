//
//  Amigos2ViewController.m
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/20/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "Amigos2ViewController.h"
#import "popViewContainer.h"

@interface Amigos2ViewController ()

@end

@implementation Amigos2ViewController
@synthesize reloj, vistareloj, myTableView;
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
     [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"soloactivos"];
    [super viewDidLoad];
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

// Customize the number of rows in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Database *db = [[Database alloc] init];
    //womities = [db traerWomitys];
	return amigos.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AmigoCell"];
    
    NSDictionary *datadiccionario = [amigos objectAtIndex:indexPath.row];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:301];
    UIButton *descipcionLabel = (UIButton *)[cell viewWithTag:302];
    UIImageView *imagenPpal = (UIImageView *)[cell viewWithTag:300];
    NSURL *url = [NSURL URLWithString:[datadiccionario objectForKey:@"URLImagen"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    [descipcionLabel setHidden:YES];
    
    UIImage *image = [UIImage imageWithData:data];
    nameLabel.text = [datadiccionario objectForKey:@"NombreAmigo"];
    
    
    imagenPpal.image = image;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",[amigos objectAtIndex:indexPath.row]);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *datadiccionario = [amigos objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
	{
		cell.accessoryType = UITableViewCellAccessoryNone;
        [idamigos removeObject:[datadiccionario objectForKey:@"Id"]];
	}else {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [idamigos addObject:[datadiccionario objectForKey:@"Id"]];
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
   
   // [self performSegueWithIdentifier:@"loguearse" sender:self];
    
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          options:kNilOptions
                          error:&error];
    
    amigos = [json objectForKey:@"Contactos"];
    
    NSLog(@"%@",amigos);
    
    
    //self.navigationController.view
    [reloj stopAnimating];
    [vistareloj setHidden: YES];
    
    
    [myTableView reloadData];
    
    
}

-(IBAction)buscar:(id)sender{
    [self performSegueWithIdentifier:@"gotobuscar" sender:self];
}

-(IBAction)eliminarcontacto:(id)sender{
    UIButton *temporal = (UIButton *) sender;
    NSString *idContacto = [NSString stringWithFormat:@"%i",temporal.tag];
    
    
    /*responseData = [NSMutableData data];
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
    }*/
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

-(IBAction)cancel:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

@end
