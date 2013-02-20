//
//  participantesViewController.m
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 12/13/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "participantesViewController.h"

@interface participantesViewController ()

@end

@implementation participantesViewController
@synthesize mytableview, datawomit;
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
    [vistareloj setHidden:YES];
    [reloj stopAnimating];
    
    participantes = [[NSMutableArray alloc] init];
    NSLog(@"%@",datawomit);
    participantes = [datawomit objectForKey:@"Usuarios"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMytableview:nil];
    [super viewDidUnload];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Database *db = [[Database alloc] init];
    //womities = [db traerWomitys];
    
	return participantes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"participanteCell"];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
    NSArray *datadiccionario = [participantes objectAtIndex:indexPath.row];
    nameLabel.text = [datadiccionario objectAtIndex:1];
    
    UILabel *accionlabel = (UILabel *)[cell viewWithTag:101];
    NSLog(@"%@",[datadiccionario objectAtIndex:2]);
    NSString *boolString = [NSString stringWithFormat:@"%@",[datadiccionario objectAtIndex:2]];
    if([boolString isEqualToString:@"1"]){
        [accionlabel setHidden:YES];
        nameLabel.frame = CGRectMake(nameLabel.frame.origin.x, 24, nameLabel.frame.size.width, nameLabel.frame.size.height);
    }
    
    UIButton *aceptar = [UIButton buttonWithType:UIButtonTypeCustom];
    aceptar.frame = accionlabel.frame;
    [aceptar addTarget:self action:@selector(aceptar:) forControlEvents:UIControlEventTouchUpInside];
    NSString *Iusuario = [NSString stringWithFormat:@"%@",[datadiccionario objectAtIndex:0]];
    aceptar.tag = indexPath.row;
    [cell addSubview:aceptar];
    
   
    
    return cell;
}

- (IBAction)aceptar:(id)sender{
    responseData = [NSMutableData data];
    [vistareloj setHidden:NO];
    [reloj startAnimating];
    
    UIButton *temporal = (UIButton *) sender;
    NSArray *datadiccionario = [participantes objectAtIndex:temporal.tag];
    //NSLog(@"%@",datadiccionario);
    
    //NSMutableArray *arraytemporal = [(NSMutableArray*)participantes mutableCopy];
    participantes = [(NSArray*)participantes mutableCopy];
    //[participantes removeObjectAtIndex:temporal.tag];
    NSMutableArray *arraytemporal = [(NSArray*)[participantes objectAtIndex:temporal.tag] mutableCopy];
    [arraytemporal replaceObjectAtIndex:2 withObject:@"1"];
    [participantes removeObjectAtIndex:temporal.tag];
    [participantes insertObject:arraytemporal atIndex:temporal.tag];

   [mytableview reloadData];
    NSMutableArray *arrayChekList = [[NSMutableArray alloc] init];
    [arrayChekList addObject:[datadiccionario objectAtIndex:0]];
    
    NSMutableString *jsonstring2 = [[NSMutableString alloc] initWithString:@"{"];
    
    for (int i=0; i<arrayChekList.count; i++) {
        // NSLog(@"%@",[[json objectForKey:[llaves objectAtIndex:i]] objectForKey:@"idOpcion"]);
        [jsonstring2 appendString:[NSString stringWithFormat:@"\"%i\":\"%@\"",i, [arrayChekList objectAtIndex:i]]];
        if(i<arrayChekList.count - 1)
        {
            [jsonstring2 appendString:[NSString stringWithFormat:@", "]];
        }
        //[jsonstring stringByAppendingString:[NSString stringWithFormat:@"%i ",i]];
    }
    [jsonstring2 appendString:[NSString stringWithFormat:@"}"]];
    NSLog(@"%@", jsonstring2);
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&Contactos=%@&MensajeInvitacion=",[[NSUserDefaults standardUserDefaults] valueForKey:@"id"], jsonstring2];
    NSLog(@"%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/agregarContactoWomity"]]];
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (IBAction)cancel:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
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
    
    [vistareloj setFrame:CGRectMake(0,480,320,480)];
    //[self performSegueWithIdentifier:@"loguearse" sender:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    if ([[json objectForKey:@"boolAgregarContactoWomity"] isEqualToString:@"true"]) {
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Tu solicitud de amistad ha sido enviada con éxito" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //[self dismissModalViewControllerAnimated:YES];
        [alerta show];
        
    }
    
    [vistareloj setHidden:YES];
    [reloj stopAnimating];
    
}

@end
