//
//  solicitudesViewController.m
//  WomityApp
//
//  Created by Eduardo Rodriguez Macmini on 12/7/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "solicitudesViewController.h"

@interface solicitudesViewController ()

@end

@implementation solicitudesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
  //  [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"friends"];
    
array = [[NSMutableArray alloc] init];
    responseData = [NSMutableData data];
    aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
    [vistareloj setHidden:NO];
    [reloj startAnimating];
    NSString *post = [NSString stringWithFormat:@"&idSession=%@",aSesion];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/solicitudAmistadList"]]];
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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotAmigoCell"];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
    NSDictionary *datadiccionario = [array objectAtIndex:indexPath.row];
    nameLabel.text = [datadiccionario objectForKey:@"nombre"];
    
    UIButton *aceptar = [UIButton buttonWithType:UIButtonTypeCustom];
    aceptar.frame = CGRectMake(20, 34, 62, 31);
    [aceptar addTarget:self action:@selector(aceptar:) forControlEvents:UIControlEventTouchUpInside];
    aceptar.tag = indexPath.row;
    [cell addSubview:aceptar];
    
    UIButton *rechazar = [UIButton buttonWithType:UIButtonTypeCustom];
    rechazar.frame = CGRectMake(222, 34, 73, 31);
    [rechazar addTarget:self action:@selector(rechazar:) forControlEvents:UIControlEventTouchUpInside];
    rechazar.tag = indexPath.row;
    [cell addSubview:rechazar];
    
     return cell;
}

- (IBAction)aceptar:(id)sender{
     UIButton *temporal = (UIButton *) sender;
NSDictionary *datadiccionario = [array objectAtIndex:temporal.tag];
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&idSolicitud=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"id"], [datadiccionario objectForKey:@"id"]];
    
    NSLog(@"%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/solicitudAmistadAceptar"]]];
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
   
    array = [(NSArray*)array mutableCopy];
    [array removeObjectAtIndex:temporal.tag];
    [mytableview reloadData];
    
    
    
}

- (IBAction)rechazar:(id)sender{
    UIButton *temporal = (UIButton *) sender;
    NSDictionary *datadiccionario = [array objectAtIndex:temporal.tag];
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&idSolicitud=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"id"], [datadiccionario objectForKey:@"id"]];
    
    NSLog(@"%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/solicitudAmistadRechazar"]]];
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
    
    array = [(NSArray*)array mutableCopy];
    [array removeObjectAtIndex:temporal.tag];
    [mytableview reloadData];
    
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
    if([urlconexion isEqualToString:@"http://www.womity.com/ws/solicitudAmistadRechazar"] || [urlconexion isEqualToString:@"http://www.womity.com/ws/solicitudAmistadAceptar"])
    {
        //NSString *newvalue = [NSString stringWithFormat:@"%i",   [[[NSUserDefaults standardUserDefaults] valueForKey:@"friends"] integerValue] - 1];
        //[[NSUserDefaults standardUserDefaults] setValue:newvalue forKey:@"friends"];
        
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:[json objectForKey:@"strMensaje"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }else{
        array = json;
        
        NSLog(@"%@",json);
        if (array.count) {
            [mytableview reloadData];
        }else{
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"No tienes solicitudes de amistad pendientes" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alerta show];
        }
        
    }
    [reloj stopAnimating];
    [vistareloj setHidden:YES];
        
}
- (void)viewDidUnload {
    vistareloj = nil;
    reloj = nil;
    mytableview = nil;
    [super viewDidUnload];
}

- (IBAction)cancel:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}
@end
