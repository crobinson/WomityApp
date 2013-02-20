//
//  ContactsViewController.m
//  WomityApp
//
//  Created by Eduardo Rodriguez Macmini on 11/29/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "ContactsViewController.h"
#import "popViewContainer.h"
#import "emailComposerViewController.h"



@interface ContactsViewController ()

@end

@implementation ContactsViewController
@synthesize vistareloj, reloj, aSesion, bandera;

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
	// Do any additional setup after loading the view.
    UITabBarController *tabBarController = self.tabBarController;
    aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
    
    dictionaryData= [[NSMutableArray alloc] init];
    otrosamigos = [[NSMutableString alloc] init];
    mailamigos = [[NSMutableArray alloc] init];
    NSMutableArray*   arrayLetter = [[NSMutableArray alloc] init];
    
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
    
    ABAddressBookRef addressBook = ABAddressBookCreate();
      NSLog(@"%@",addressBook);
    CFErrorRef error = nil;
    if (ABAddressBookCreateWithOptions != NULL) {
        addressBook = ABAddressBookCreateWithOptions(NULL,&error);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            // callback can occur in background, address book must be accessed on thread it was created on
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                // access granted
                //   AddressBookUpdated(addressBook, nil, self);
                // CFRelease(addressBook);
                
            });
        });
    }
    
   
    
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    NSLog(@"%@",people);
    contactnumberArray = [[NSMutableArray alloc] init];
    CFIndex lTotalContactsCount = ABAddressBookGetPersonCount(addressBook);
    
    for (CFIndex i = 0; i < lTotalContactsCount; i++) {
        ABRecordRef person = CFArrayGetValueAtIndex(people, i);
        
        NSString* name = (__bridge_transfer NSString*)ABRecordCopyValue(person,
                                                                        kABPersonFirstNameProperty);
        NSString *lastname = (__bridge_transfer NSString*)ABRecordCopyValue(person,
                                                                            kABPersonLastNameProperty);
        ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
         NSArray* allemails = (__bridge NSArray*)ABMultiValueCopyArrayOfAllValues(emails);
        for (CFIndex j=0; j < ABMultiValueGetCount(emails); j++) {
            NSString* email = (__bridge NSString*)ABMultiValueCopyValueAtIndex(emails, j);
            NSString * realname = [NSString stringWithFormat:@"%@ %@",name,(lastname==NULL)?@"":lastname];
            [contactnumberArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:realname,@"name",email,@"email",nil]];
            
        }
        CFRelease(emails);
        
        
    }
    CFRelease(addressBook);
    CFRelease(people);
    
    
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"name"  ascending:YES];
    [contactnumberArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    NSArray * recent = [contactnumberArray copy];
    
    arraySection  = [[NSMutableArray alloc] init];
    
    for (NSString * letters in arrayLetter){
        NSMutableArray * array = [[NSMutableArray alloc] init];
        NSString *min = [NSString stringWithFormat:@"%c",[letters characterAtIndex:0]];
        NSString *max = [NSString stringWithFormat:@"%c",[letters characterAtIndex:1]];
        for(NSDictionary *dictionary in recent){
            
            
            NSString *string = [dictionary valueForKey:@"name"];
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
    NSDictionary * dictio = [dictionaryData objectAtIndex:section];
    NSArray *array = [dictio objectForKey:@"contacts"];
    return [array count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [arraySection objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CountryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    NSDictionary *dictionaryAll = [dictionaryData objectAtIndex:indexPath.section];
    NSArray *array = [dictionaryAll objectForKey:@"contacts"];
    NSDictionary *dictionary = [array objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dictionary valueForKey:@"name"];
    cell.detailTextLabel.text = [dictionary valueForKey:@"email"];
    
    for (NSString * string in arrayChekList){
        if ([string isEqualToString:[dictionary valueForKey:@"email"]]){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *tableviewcell = [tableView1 cellForRowAtIndexPath:indexPath];
    if (tableviewcell.accessoryType == UITableViewCellAccessoryNone){
        tableviewcell.accessoryType = UITableViewCellAccessoryCheckmark;
        [arrayChekList addObject:tableviewcell.detailTextLabel.text];
        [mailamigos addObject:tableviewcell.detailTextLabel.text];
    }else{
        tableviewcell.accessoryType = UITableViewCellAccessoryNone;
        [self removeFromCheckList:tableviewcell.detailTextLabel.text];
        [mailamigos removeObject:tableviewcell.detailTextLabel.text];
    }
    
    NSLog(@"%@",mailamigos);
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

-(void)removeAllCheckList{
    for (int i = [arrayChekList count] -1; i >=0 ; i--){
        [arrayChekList removeObjectAtIndex:i];
    }
    [tableView reloadData];
}

- (IBAction)Done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *)getEmailFromNamesChekList{
    NSMutableArray *arrau = [[NSMutableArray alloc] init];
    
    for (int i  = 0; i< [contactnumberArray count];i++){
        NSDictionary * dictionary  = [contactnumberArray objectAtIndex:i];
        for (NSString *name in arrayChekList){
            if ([[dictionary valueForKey:@"name"] isEqualToString:name]){
                [arrau  addObject:[dictionary valueForKey:@"email"]];
            }
        }
    }
    
    NSString *string = @"";
    for (int i = 0; i<[arrau count];i++){
        if (i == [arrau count]-1){
            string = [NSString stringWithFormat:@"%@%@",string,[arrau objectAtIndex:i]];
        }else{
            string = [NSString stringWithFormat:@"%@%@,",string,[arrau objectAtIndex:i]];
        }
    }
    
    
    return string;
}

-(IBAction)enviar:(id)sender
{
    
    //NSLog(@"%@",[self getEmailFromNamesChekList]);
    if (bandera){
        otrosamigos = [[NSMutableString alloc] initWithString:@""];
        
        for(int i=0; i<mailamigos.count; i++){
            if([otrosamigos isEqualToString:@""]){
                [otrosamigos appendString:[NSString stringWithFormat:@"%@", [mailamigos objectAtIndex:i]]];
            }else {
                [otrosamigos appendString:[NSString stringWithFormat:@", %@", [mailamigos objectAtIndex:i]]];
            }
            
        }
        NSLog(@"%@ eduardo texto",otrosamigos);
        
        [self.delegate ContactsAgregar:otrosamigos deAmigos:otrosamigos];
    }else{
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        [UIView setAnimationDelegate:self];
        
        //self.navigationController.view
        [vistareloj setFrame:CGRectMake(0,44,self.view.frame.size.width,460)];
        [UIView commitAnimations];
        [reloj startAnimating];
        
        
        
        //NSArray *llaves = [json allKeys];
        NSMutableString *jsonstring = [[NSMutableString alloc] initWithString:@""];
        /*NSMutableString *jsonstring = [[NSMutableString alloc] initWithString:@"{"];
         for (int i=0; i<idsamigos.count; i++) {
         // NSLog(@"%@",[[json objectForKey:[llaves objectAtIndex:i]] objectForKey:@"idOpcion"]);
         [jsonstring appendString:[NSString stringWithFormat:@"\"%i\":%@",i, [idsamigos objectAtIndex:i]]];
         if(i<idsamigos.count - 1)
         {
         [jsonstring appendString:[NSString stringWithFormat:@", "]];
         }
         //[jsonstring stringByAppendingString:[NSString stringWithFormat:@"%i ",i]];
         }
         [jsonstring appendString:[NSString stringWithFormat:@"}"]];
         NSLog(@"%@", jsonstring);
         */
        
        //NSArray *myWords = [correosLabel.text componentsSeparatedByString:@", "];
        otrosamigos = [[NSMutableString alloc] initWithString:@""];
        
        for(int i=0; i<mailamigos.count; i++){
            if([otrosamigos isEqualToString:@""]){
                [otrosamigos appendString:[NSString stringWithFormat:@"%@", [mailamigos objectAtIndex:i]]];
            }else {
                [otrosamigos appendString:[NSString stringWithFormat:@", %@", [mailamigos objectAtIndex:i]]];
            }
            
        }
        NSLog(@"%@",otrosamigos);
        NSString * string = [otrosamigos stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSArray *myWords2 = [string componentsSeparatedByString:@","];
        
        
        
        NSMutableString *jsonstring2 = [[NSMutableString alloc] initWithString:@"{"];
        /* for (int i=0; i<myWords.count; i++) {
         // NSLog(@"%@",[[json objectForKey:[llaves objectAtIndex:i]] objectForKey:@"idOpcion"]);
         [jsonstring2 appendString:[NSString stringWithFormat:@"\"%i\":\"%@\"",i, [myWords objectAtIndex:i]]];
         if(i<myWords.count - 1)
         {
         [jsonstring2 appendString:[NSString stringWithFormat:@", "]];
         }
         //[jsonstring stringByAppendingString:[NSString stringWithFormat:@"%i ",i]];
         }*/
        /*
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
        
        
        responseData = [NSMutableData data];
        NSString *post = [NSString stringWithFormat:@"&idSession=%@&Emails=%@&MensajeInvitacion=%@",aSesion, jsonstring2, @""];
        NSLog(@"%@",post);
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/agregarContactoEmail"]]];
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
    //[self dismissViewControllerAnimated:YES completion:nil];
        
    
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
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSLog(@"%@",json);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistareloj setFrame:CGRectMake(0,1000,self.view.frame.size.width,417)];
    
    [reloj stopAnimating];
    [UIView commitAnimations];
    
    
    if([[json objectForKey:@"boolContactos"] isEqualToString:@"true"]){
        /* UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:[json objectForKey:@"strMensaje"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alerta show];
         [self performSegueWithIdentifier:@"terminado" sender:self];*/
        
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Tus contactos han sido invitados con éxito" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"crear" forKey:@"accioncrear"];
        [[NSUserDefaults standardUserDefaults] setValue:@"nuevo" forKey:@"accionnavegar"];
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
        [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
        
        UITabBarController *tabBarController = self.tabBarController;
        tabBarController.selectedIndex = 1;
    }else if([[[NSUserDefaults standardUserDefaults] valueForKey:@"descripcion"] isEqualToString:@"invitar"]){
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Tus contactos han sido invitados con éxito" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    } else{
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"No se pudo enviar la invitación a tus amigos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"desdelib"])
	{
		emailComposerViewController  *emailComposerViewController =  [segue destinationViewController];
        NSLog(@"%@",otrosamigos);
		emailComposerViewController.otrosamigos = otrosamigos;
        
	}
    
}



@end
