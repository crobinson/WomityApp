//
//  buscarAmigosViewController.m
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/20/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "buscarAmigosViewController.h"
#import "CustomImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "popViewContainer.h"

@interface buscarAmigosViewController ()

@end

@implementation buscarAmigosViewController
@synthesize mytableview, responseData, vistacell, textoBuscar, aSesion, myscrollview, vistareloj, reloj;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    NSLog(@"%@",viewController);
    [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"soloactivos"];
    [viewController.navigationController popToViewController:[viewController.navigationController.viewControllers objectAtIndex:0] animated:YES];
    
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.delegate = self;
 [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"soloactivos"];
    aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
    arrayseleccionados = [[NSMutableArray alloc] init];
    idstring = @"";
    /*UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarTeclado)];
    
    [myscrollview addGestureRecognizer:tapScroll];
    */
    vistacell.layer.cornerRadius = 10;
    
    [mytableview setHidden:YES];
    [contador setHidden:YES];
    [resut setHidden:YES];
	// Do any additional setup after loading the view.
    
    
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
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buscar:(id)sender
{
    [textoBuscar resignFirstResponder];
    
    [reloj startAnimating];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistareloj setFrame:CGRectMake(0,44,320,480)];
    [UIView commitAnimations];
    
    responseData = [NSMutableData data];
    
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&qryString=%@",aSesion, self.textoBuscar.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/buscarContactoWomity"]]];
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


- (void)quitarTeclado
{
    // Dismiss the keyboard when the view outside the text field is touched.
    [textoBuscar resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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
    
    NSString *urlconexion = [NSString stringWithFormat:@"%@",connection.currentRequest.URL];
    if([urlconexion isEqualToString:@"http://www.womity.com/ws/buscarContactoWomity"])
    {
        arraycontactos = [json objectForKey:@"Contactos"];
        dictionaryData= [[NSMutableArray alloc] init];
        arrayChekList = [[NSMutableArray alloc] init];
        
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"Nombre"  ascending:YES];
        [arraycontactos sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
        NSArray * recent = [arraycontactos copy];
        
        NSLog(@"%@",arraycontactos);
        
        arraySection  = [[NSMutableArray alloc] init];
        
        for (NSString * letters in arrayLetter){
            NSMutableArray * array = [[NSMutableArray alloc] init];
            NSString *min = [NSString stringWithFormat:@"%c",[letters characterAtIndex:0]];
            NSString *max = [NSString stringWithFormat:@"%c",[letters characterAtIndex:1]];
            for(NSDictionary *dictionary in recent){
                
                
                NSString *string = [dictionary valueForKey:@"Nombre"];
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
        
        
        
        [reloj stopAnimating];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        [UIView setAnimationDelegate:self];
        [vistareloj setFrame:CGRectMake(0,480,320,480)];
        [UIView commitAnimations];
        
        //myscrollview.contentSize =CGSizeMake(320, 160 + arraycontactos.count*63);
        
        contador.text = [NSString stringWithFormat:@"%i",arraycontactos.count];
        [mytableview reloadData];
        
        //mytableview.frame = CGRectMake(mytableview.frame.origin.x, mytableview.frame.origin.y, mytableview.frame.size.width, arraycontactos.count*63);
        
        [mytableview setHidden:NO];
        [contador setHidden:NO];
        [resut setHidden:NO];
    }else{
        NSLog(@"%@",json);
        if ([[json objectForKey:@"boolAgregarContactoWomity"] isEqualToString:@"true"]) {
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Tu solicitud de amistad ha sido enviada con éxito" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [self dismissModalViewControllerAnimated:YES];
            [alerta show];
            
        }
        
        
        
        [reloj stopAnimating];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        [UIView setAnimationDelegate:self];
        [vistareloj setFrame:CGRectMake(0,480,320,480)];
        [UIView commitAnimations];
    }
}


/*

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Dismiss the keyboard when the view outside the text field is touched.
    [textoBuscar resignFirstResponder];
    // Revert the text field to the previous value.
    //palabra.text = self.string;
    [super touchesBegan:touches withEvent:event];
}
*/
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictionaryAll = [dictionaryData objectAtIndex:indexPath.section];
    NSArray *array = [dictionaryAll objectForKey:@"contacts"];
    NSDictionary *datadiccionario = [array objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celdaresult"];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:121];
    CustomImageView *imagenPpal = (CustomImageView *)[cell viewWithTag:120];
    NSString *urlimagencompleta = [NSString stringWithFormat:@"http://www.womity.com%@", [datadiccionario objectForKey:@"URLImagen"]];
    
    UILabel *eliminarLabel = (UILabel *)[cell viewWithTag:122];
    
    nameLabel.text = [datadiccionario objectForKey:@"Nombre"];
    [imagenPpal setURL:[NSURL URLWithString:urlimagencompleta]];
    
    for (NSString * string in arrayChekList){
        if ([string isEqualToString:[datadiccionario objectForKey:@"idContacto"]]){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            UILabel *eliminarLabel = (UILabel *)[cell viewWithTag:122];
            [eliminarLabel setHidden:YES];
            break;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
            UILabel *eliminarLabel = (UILabel *)[cell viewWithTag:122];
            [eliminarLabel setHidden:NO];
        }
    }
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dictionaryAll = [dictionaryData objectAtIndex:indexPath.section];
    NSArray *array = [dictionaryAll objectForKey:@"contacts"];
    NSDictionary *datadiccionario = [array objectAtIndex:indexPath.row];

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
	{
		cell.accessoryType = UITableViewCellAccessoryNone;
        UILabel *eliminarLabel = (UILabel *)[cell viewWithTag:122];
        [eliminarLabel setHidden:NO];
        [self removeFromCheckList:[datadiccionario objectForKey:@"idContacto"]];
        [arrayseleccionados removeObject:[datadiccionario objectForKey:@"idContacto"]];
    
	}else {
         UILabel *eliminarLabel = (UILabel *)[cell viewWithTag:122];
         [eliminarLabel setHidden:YES];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [arrayChekList addObject:[datadiccionario objectForKey:@"idContacto"]];
        [arrayseleccionados addObject:[datadiccionario objectForKey:@"idContacto"]];
    }

    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return arraySection;
}

-(void)removeFromCheckList:(NSString *)iden{
    for (int i = 0; i < [arrayChekList count]; i++){
        NSString *s = [arrayChekList objectAtIndex:i];
        if ([s isEqualToString:iden]){
            [arrayChekList removeObjectAtIndex:i];
        }
    }
    
    //[self removeAllCheckList];
    // [tableView reloadData];
}


-(IBAction)enviar:(id)sender
{
    [self done];
}
-(void)done
{
    
    [reloj startAnimating];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistareloj setFrame:CGRectMake(0,44,320,480)];
    [UIView commitAnimations];
    
    responseData = [NSMutableData data];
    
    //NSLog(@"%@",arrayseleccionados);
    idstring = [[NSMutableString alloc] init];
    for (int i=0; i<arrayseleccionados.count; i++) {
        if([idstring isEqualToString:@""]){
            [idstring appendString:[NSString stringWithFormat:@"%@", [arrayseleccionados objectAtIndex:i]]];
        }else {
            [idstring appendString:[NSString stringWithFormat:@", %@", [arrayseleccionados objectAtIndex:i]]];
        }
    }
    
    NSString * string = [idstring stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSArray *myWords2 = [string componentsSeparatedByString:@","];
    NSMutableString *jsonstring2 = [[NSMutableString alloc] initWithString:@"{"];

    for (int i=0; i<myWords2.count; i++) {
        // NSLog(@"%@",[[json objectForKey:[llaves objectAtIndex:i]] objectForKey:@"idOpcion"]);
        [jsonstring2 appendString:[NSString stringWithFormat:@"\"%i\":\"%@\"",i, [myWords2 objectAtIndex:i]]];
        if(i<myWords2.count - 1)
        {
            [jsonstring2 appendString:[NSString stringWithFormat:@", "]];
        }
        //[jsonstring stringByAppendingString:[NSString stringWithFormat:@"%i ",i]];
    }
    [jsonstring2 appendString:[NSString stringWithFormat:@"}"]];
    NSLog(@"%@", jsonstring2);

    
    
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&Contactos=%@&MensajeInvitacion=",aSesion, jsonstring2];
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

-(IBAction)volver:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
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
