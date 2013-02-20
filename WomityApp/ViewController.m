//
//  ViewController.m
//  WomityApp
//
//  Created by Carlos Andres Robinson Lara on 11/9/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize responseData;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated
{
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
    
    
    [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
    [[NSUserDefaults standardUserDefaults] setValue:@"crear" forKey:@"accioncrear"];
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"id"] == NULL){
        [self performSegueWithIdentifier:@"gotoLogin" sender:self];
     /*}else if([[NSUserDefaults standardUserDefaults] valueForKey:@"idfacebook"] != NULL) {
       responseData = [NSMutableData data];
        
        NSString *post = [NSString stringWithFormat:@"&email=%@&contrasena=%@",self.emailTextField.text, self.paswordTextField.text];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/login"]]];
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

    }else{
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"id"]);
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
    //  [self performSegueWithIdentifier:@"loguearse" sender:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSString *cadenarespuesta = [NSString stringWithFormat:@"%@",json];
    if ([cadenarespuesta rangeOfString:@"IdSesionNoValido"].location == NSNotFound) {
        //NSArray *arrayjson = json;
       [self performSegueWithIdentifier:@"gotoWomits" sender:self];        
    }else{
        [self performSegueWithIdentifier:@"gotoLogin" sender:self];
    }
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
