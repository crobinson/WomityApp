//
//  emailComposerViewController.m
//  WomityApp
//
//  Created by Eduardo Rodriguez Macmini on 11/27/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "emailComposerViewController.h"
#import "popViewContainer.h"
#import "ComentariosViewController.h"

@interface emailComposerViewController ()

@end

@implementation emailComposerViewController
@synthesize vistareloj, reloj, aSesion, otrosamigos;

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
    self.tabBarController.delegate = self;
    aSesion = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
    tapScroll = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitarTeclado)];
    if(![otrosamigos isEqualToString:@""]){
        emailTextView.text = otrosamigos;
        
        float resizer = 0.0;
        CGRect rect = emailTextView.frame;
        resizer = emailTextView.contentSize.height -  rect.size.height;
        rect.size.height = emailTextView.contentSize.height;
        emailTextView.frame = rect;
        
        emailView.frame = CGRectMake(emailView.frame.origin.x, emailView.frame.origin.y, emailView.frame.size.width, emailView.frame.size.height + resizer);
        commentView.frame = CGRectMake(commentView.frame.origin.x, commentView.frame.origin.y+resizer, commentView.frame.size.width, commentView.frame.size.height);
        btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y+resizer, btn.frame.size.width, btn.frame.size.height);
        scrollView.contentSize = CGSizeMake(0, scrollView.contentSize.height + resizer);
    }
    [self.view addGestureRecognizer:tapScroll];
    emailView.layer.cornerRadius = 8;
    commentView.layer.cornerRadius = 8;
    scrollView.contentSize = CGSizeMake(0, 480);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textViewDidChange:(UITextView *)textView{
    float resizer = 0.0;
    
    if (textView == emailTextView){
  
        CGRect rect = emailTextView.frame;
        resizer = emailTextView.contentSize.height -  rect.size.height;
        rect.size.height = emailTextView.contentSize.height;
        emailTextView.frame = rect;
        
        emailView.frame = CGRectMake(emailView.frame.origin.x, emailView.frame.origin.y, emailView.frame.size.width, emailView.frame.size.height + resizer);
        commentView.frame = CGRectMake(commentView.frame.origin.x, commentView.frame.origin.y+resizer, commentView.frame.size.width, commentView.frame.size.height);
        btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y+resizer, btn.frame.size.width, btn.frame.size.height);
        scrollView.contentSize = CGSizeMake(0, scrollView.contentSize.height + resizer);
        
        
    }else  if (textView == emailTextView){
        
                
        CGRect rect = commnetTextView.frame;
        resizer = commnetTextView.contentSize.height -  rect.size.height;
        rect.size.height = commnetTextView.contentSize.height;
        commnetTextView.frame = rect;
        

        commentView.frame = CGRectMake(commentView.frame.origin.x, commentView.frame.origin.y, commentView.frame.size.width, commentView.frame.size.height+resizer);
        btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y+resizer, btn.frame.size.width, btn.frame.size.height);
        scrollView.contentSize = CGSizeMake(0, scrollView.contentSize.height + resizer);
    
    }
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    [scrollView removeGestureRecognizer:tapScroll];
    scrollView.contentSize = CGSizeMake(320, 480);
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    [scrollView addGestureRecognizer:tapScroll];
    
    if (textView == commnetTextView)
    scrollView.contentOffset = CGPointMake(0, commnetTextView.frame.origin.y - 20);
    
    scrollView.contentSize = CGSizeMake(320, 600);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        //self uploadPhoto:
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (IBAction)Done:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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

-(IBAction)enviar:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    
    //self.navigationController.view
    [vistareloj setFrame:CGRectMake(0,44,self.view.frame.size.width,460)];
    [UIView commitAnimations];
    [reloj startAnimating];
    
    [emailTextView resignFirstResponder];
    [commnetTextView resignFirstResponder];
    
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
    
    NSString * string = [emailTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
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
    NSString *post = [NSString stringWithFormat:@"&idSession=%@&Emails=%@&MensajeInvitacion=%@",aSesion, jsonstring2, commnetTextView.text];
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
    [vistareloj setFrame:CGRectMake(0,1000,self.view.frame.size.width,417)];
    
    [reloj stopAnimating];
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
        
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Tu solicitud de amistad ha sido enviada con éxito" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        [self dismissModalViewControllerAnimated:YES];
        [[NSUserDefaults standardUserDefaults] setValue:@"crear" forKey:@"accioncrear"];
        [[NSUserDefaults standardUserDefaults] setValue:@"nuevo" forKey:@"accionnavegar"];
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
        [[NSUserDefaults standardUserDefaults] setValue:@"A" forKey:@"tipowomit"];
        
        UITabBarController *tabBarController = self.tabBarController;
        tabBarController.selectedIndex = 1;
    }else if([[[NSUserDefaults standardUserDefaults] valueForKey:@"descripcion"] isEqualToString:@"invitar"]){
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Tu womit ha sido enviado a tus contactos con éxito" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    } else{
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Mensaje" message:@"Por favor, revisa los e-mails introducidos. No se pudo enviar la invitación a tus amigos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }
}

- (void)quitarTeclado
{
    // Dismiss the keyboard when the view outside the text field is touched.
    [commnetTextView resignFirstResponder];
    [emailTextView resignFirstResponder];
    // Revert the text field to the previous value.
    //palabra.text = self.string;
}

@end
