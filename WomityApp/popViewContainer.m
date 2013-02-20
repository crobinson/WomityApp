//
//  popViewContainer.m
//  WomityApp
//
//  Created by Eduardo Rodriguez Macmini on 11/30/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "popViewContainer.h"
#import "DescripcionViewController.h"

@implementation popViewContainer
@synthesize tabBarController;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    responseData = [NSMutableData data];
    
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&tipo=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"id"], @"A"];
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
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [image setImage:[UIImage imageNamed:@"notificaciones.png"]];
    [self addSubview:image];
    image = nil;
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(8, 40, rect.size.width-16, rect.size.height - 64) style:UITableViewStyleGrouped];
    tableview.dataSource = self;
    tableview.backgroundView = nil;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    [self addSubview:tableview];
    self.alpha = 1.0;
    
    loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loading.frame =CGRectMake(tableview.frame.size.width/2-10, tableview.frame.size.height/2 -10, 20, 20);
    [self addSubview:loading];
    [loading startAnimating];

}



-(void)fadeOFFEmergency{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    self.alpha = 1.0;
    
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
    //[self performSegueWithIdentifier:@"loguearse" sender:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSString *cadenarespuesta = [NSString stringWithFormat:@"%@",json];
    
    NSString *urlconexion = [NSString stringWithFormat:@"%@",connection.currentRequest.URL];
    if([urlconexion isEqualToString:@"http://www.womity.com/ws/getWomity"])
    {
        if ([cadenarespuesta rangeOfString:@"IdSesionNoValido"].location == NSNotFound) {

            if([cadenarespuesta rangeOfString:@"No hay womits en este estado"].location != NSNotFound){
                UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Aún no tienes womits activos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alerta show];
                [self kill];
                
            }else{
                
                womities = json;
                [tableview reloadData];
                [loading removeFromSuperview];
                [loading stopAnimating];
                loading = nil;

            }
                        
            
        }
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [womities count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    NSLog(@"%i",womities.count);
    
    
    if(womities.count > 0){
    datadiccionario = [womities objectAtIndex:indexPath.row];
    NSArray *comentarios = [datadiccionario objectForKey:@"Comentarios"];
   
    
    cell.textLabel.text = [[datadiccionario objectForKey:@"Titulo"] uppercaseString];
    cell.imageView.image = [UIImage imageNamed:@"mariquita1.png"];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11];
    
    if ([comentarios count] > 0){
         NSDictionary *comment;
        comment = [comentarios objectAtIndex:[comentarios count]-1];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Último Comentario: %@",[comment valueForKey:@"Comentario"]];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
    }else{
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
         cell.detailTextLabel.text = @"Sin Comentarios";
    
    }
    cell.accessoryView = [self makeCheckmarkOffAccessoryView:indexPath];
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:254/255.0 green:195/255.0 blue:181/255.0 alpha:1.0]];
    cell.selectedBackgroundView = bgColorView;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"notificaciones"];
    //[[NSUserDefaults standardUserDefaults] setValue:[[womities objectAtIndex:indexPath.row] objectForKey:@"idWomity"] forKey:@"idWomity"];
    //NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"idWomity"]);
    [self removeFromSuperview];
    selectedRow = indexPath.row;
   // tabBarController.selectedIndex = 1;
     //[self performSegueWithIdentifier:@"gotodescripcion" sender:self];
    [self.delegate popNavegar:[womities objectAtIndex:indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"vercomentarios"]){
        DescripcionViewController *controller = [segue destinationViewController];
            controller.datawomit = [womities objectAtIndex:selectedRow];
        controller.aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];        
        controller.comentar = YES;
        
    }
}

-(UIImageView *) makeCheckmarkOffAccessoryView:(NSIndexPath *)indexPath
{
    UIImageView *image =  [[UIImageView alloc] initWithImage:
                           [UIImage imageNamed:@"circunot.png"]];
    NSDictionary *datadiccionario = [womities objectAtIndex:indexPath.row];
    
    NSDictionary *comment = [datadiccionario objectForKey:@"Comentarios"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, image.frame.size.width, image.frame.size.height)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [image addSubview:label];
    label.text = [NSString stringWithFormat:@"%i",[comment count]];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
   
    return image;
}



-(void)kill{
    [tableview removeFromSuperview];
    tableview = nil;
}

@end
