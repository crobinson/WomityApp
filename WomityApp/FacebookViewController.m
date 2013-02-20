//
//  FacebookViewController.m
//  WomityApp
//
//  Created by Eduardo Rodriguez Macmini on 11/20/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import "FacebookViewController.h"

@interface FacebookViewController ()

@end

@implementation FacebookViewController
@synthesize responseData,isFacebook;
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
	// Do any additional setup after loading the view.
    
    [self login];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)login{
    
    counter = 0;
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    
    NSString *authFormatString = @"https://graph.facebook.com/oauth/authorize?client_id=%@&redirect_uri=%@&scope=%@&type=user_agent&display=touch";
    
    NSString *urlString = [NSString stringWithFormat:authFormatString, @"257558020986115", @"http://www.facebook.com/connect/login_success.html", @"publish_stream,email"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"%i",counter);
    
    NSString *urlString = request.URL.absoluteString;
    if (counter == 3 || counter == 4){
        [loading stopAnimating];
        [loading setHidden:YES];
    }else if (counter == 6 || counter == 7){
        [loading stopAnimating];
        [loading setHidden:YES];
    }else{
        [loading startAnimating];
        [loading setHidden:NO];
    }
    
    
    counter ++;
    [self checkForAccessToken:urlString];
    [self checkLoginRequired:urlString];
    
    return TRUE;
}

#pragma mark Helper functions

-(void)checkForAccessToken:(NSString *)urlString {
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"access_token=(.*)&" options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:urlString options:0 range:NSMakeRange(0, [urlString length])];
        if (firstMatch) {
            NSRange accessTokenRange = [firstMatch rangeAtIndex:1];
            NSString *accessToken = [urlString substringWithRange:accessTokenRange];
            accessToken = [accessToken stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [self accessTokenFound:accessToken];
        }
    }
}



- (void)accessTokenFound:(NSString *)apiKey {
    
    
    
    NSLog(@"Access token found: %@", apiKey);
    [webView loadHTMLString:@"" baseURL:nil]; 
    [[NSUserDefaults standardUserDefaults] setValue:apiKey forKey:@"token"];
    NSDictionary *dictionary = nil;
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"idFacebook"] == NULL){
        
        NSError *error = nil;
        NSData *string = [[NSData alloc ] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"token"]]]];
        
        dictionary = [NSJSONSerialization JSONObjectWithData:string options:NSJSONReadingAllowFragments error:&error];
        
        [[NSUserDefaults standardUserDefaults] setValue:[dictionary valueForKey:@"id"] forKey:@"idFacebook"];
        [[NSUserDefaults standardUserDefaults] setValue:[dictionary valueForKey:@"name"] forKey:@"name"];
        [[NSUserDefaults standardUserDefaults] setValue:[dictionary valueForKey:@"first_name"] forKey:@"first_name"];
        [[NSUserDefaults standardUserDefaults] setValue:[dictionary valueForKey:@"last_name"] forKey:@"last_name"];
        [[NSUserDefaults standardUserDefaults] setValue:[dictionary valueForKey:@"email"] forKey:@"email"];
         [[NSUserDefaults standardUserDefaults] setValue:[dictionary objectForKey:@"name"] forKey:@"NombreUsuario"];
        [[NSUserDefaults standardUserDefaults] setValue:[dictionary valueForKey:@"link"] forKey:@"last_name"];
        
        
        
        NSData *dataPicture = [[NSData alloc ] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture",[[NSUserDefaults standardUserDefaults] valueForKey:@"id"]]]];
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        
        [dataPicture writeToFile:[documentsDir stringByAppendingString:@"pictureUser.png"] atomically:YES];
        
        
    }
    
    if (isFacebook == true){
        [self dismissModalViewControllerAnimated:YES];
    }else{
    
    responseData = [NSMutableData data];
        
        //******** Facebook **********//
        //******** Facebook **********//
        //******** Facebook **********//
        //******** Facebook **********//
        //******** Facebook **********//
        
    
       /* UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"WOMITY\nFelicidades" message:@"Acabas de iniciar sesion en Facebook, deseas publicar esto en tu muro?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        [alert2 show];*/
        
        
        //******** Facebook **********//
        //******** Facebook **********//
        //******** Facebook **********//
        //******** Facebook **********//
        
    NSArray *getToken = [apiKey componentsSeparatedByString:@"&"];
    NSString *token = [getToken objectAtIndex:0];
    
    NSString *stringFormat = [NSString stringWithFormat:@"{ \"id\": \"%@\",   \"name\": \"%@\",   \"first_name\": \"%@\",   \"last_name\": \"%@\",   \"link\": \"%@\",   \"username\": \"%@\",   \"gender\": \"%@\",   \"email\": \"%@\",   \"timezone\": %@,   \"locale\": \"%@\",   \"verified\": %@,   \"updated_time\": \"%@\" }",[dictionary valueForKey:@"id"],[dictionary valueForKey:@"name"],[dictionary valueForKey:@"first_name"],[dictionary valueForKey:@"last_name"],[dictionary valueForKey:@"link"],[dictionary valueForKey:@"username"],[dictionary valueForKey:@"gender"],[dictionary valueForKey:@"email"],[dictionary valueForKey:@"timezone"],[dictionary valueForKey:@"locale"],([[dictionary valueForKey:@"verified"] intValue] == 1)?@"true":@"false",[dictionary valueForKey:@"updated_time"]];
    
    NSString *post = [NSString stringWithFormat:@"&fb_id=%@&fb_token=%@&fb_user_profile=%@&deviceToken=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"idFacebook"] , token,stringFormat,[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"]];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.womity.com/ws/loginFB"]]];
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        alertView = [[UIAlertView alloc] initWithTitle:@"Womity" message:@"Un momento ...\n" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 70, 30, 30)];
        progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [alertView addSubview:progress];
        [progress startAnimating];
        
        [alertView show];
        
        
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendFacebook) userInfo:nil repeats:NO];
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
    
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"No hemos logrado conectarnos con el servidor. Revisa tu conexión" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alerta show];
    [self performSegueWithIdentifier:@"loguearse" sender:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    //{"boolLogin":"true","strMensaje":"loginOk","idSession":"2136418ad3534c6dae8e6dc6a9b59732"}
    
    [[NSUserDefaults standardUserDefaults] setValue:[json objectForKey:@"idSession"] forKey:@"id"];
    
    NSLog(@"%@",json);
    
    if ([[json objectForKey:@"boolLoginFb"] isEqualToString:@"true"])
	{
        //[self dismissModalViewControllerAnimated:YES];
        [[NSUserDefaults standardUserDefaults] setValue:[json objectForKey:@"idSession"] forKey:@"id"];
        [self performSegueWithIdentifier:@"logueado" sender:self];
       
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Womity" message:[json valueForKey:@"mensaje"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }else{
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Womity" message:[json valueForKey:@"mensaje"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(NSString *)sendingDataSyncronicString:(NSString *)jsonRequest andjsonURL:(NSURL *)url
{
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    NSString*post = [NSString stringWithFormat:@"%@", jsonRequest];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if(urlData !=nil)
    {
        NSString * result = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",result);
        return result;
    }
    else
        return [error localizedDescription];
    
    return nil;
    
}

-(void)sendFacebook{
    NSString *string = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"token"] componentsSeparatedByString:@"="] objectAtIndex:0];
    [self connectionFacebook:[NSString stringWithFormat:@"&picture=http://www.grupo318.com/images/dapp/thumbs/womity.jpg&message= Descubre lo divertido que es tomar deciciones en grupo con WOMITY de forma fácil y divertida.&link=http://www.womity.com&access_token=%@", string]:[NSURL URLWithString:@"https://graph.facebook.com/me/feed"]];
    
    [alertView dismissWithClickedButtonIndex:-1 animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Womity" message:@"Tu ingreso a Womity a sido publicado en tu facebook" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(NSString *)connectionFacebook:(NSMutableString *) jsonRequest:(NSURL *)url
{
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    NSString*post = [NSString stringWithFormat:@"%@", jsonRequest];
    //   //NSLog(@"%@",post);
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if(urlData !=nil)
    {
        NSString * result = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
        ////NSLog(@"%@",result);
        return result;
    }
    else
        return [error localizedDescription];
    
    return nil;
    
}

-(void)checkLoginRequired:(NSString *)urlString {
    if ([urlString rangeOfString:@"login.php"].location != NSNotFound) {
        // [_delegate displayRequired];
    }
}

- (IBAction)cancel:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}



@end
