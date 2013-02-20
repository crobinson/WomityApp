//
//  CustomImageView.m
//  NoName
//
//  Created by Eduardo Rodriguez on 9/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView

@synthesize receivedData,index;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.3];
    }
    return self;
}

-(id)initWithURL:(NSURL *)url{
    self = [super init];
    self.alpha = 0.0;
    self.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.3];
    
    NSString *stringurl = [url path]; 


    
    NSArray *imagenArray = [stringurl  componentsSeparatedByString:@"/"];

    NSString *imageName = [imagenArray objectAtIndex:imagenArray.count-1];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *jpegFilePath = [NSString stringWithFormat:@"%@/%@",docDir,imageName];
    
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:jpegFilePath]){
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:url
                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval:60.0];
        
        NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        if (theConnection) 
            receivedData = [NSMutableData data];
    }else{
        
        
        
        self.image =  [UIImage imageWithContentsOfFile:jpegFilePath];
    }

    
    return self;

}


+(UIImage *)getImageFromCachePath:(NSURL *)url{
    
    NSString *stringurl = [url path];
    
    NSArray *imagenArray = [stringurl  componentsSeparatedByString:@"/"];
    
    NSString *imageName = [imagenArray objectAtIndex:imagenArray.count-1];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *jpegFilePath = [NSString stringWithFormat:@"%@/%@",docDir,imageName];

    return [UIImage imageWithContentsOfFile:jpegFilePath];
}

-(NSString *)noImageSelector{
    
    NSString *s = @"";
    
    if (self.frame.size.width < self.frame.size.height){
        s= @"marca1.png";
    }else{
        if (900<self.frame.size.width && self.frame.size.width<=1024){
            s= @"marca2.png";
        }else if (500<self.frame.size.width && self.frame.size.width<=768){
            s= @"marca3.png";
        }else {
            s= @"marca4.png";
        }
    }
    

    return s;
}

-(void)setURL:(NSURL *)url{

       self.image =  [UIImage imageNamed:@""];

        self.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.3];
        
        NSString *stringurl = [url absoluteString]; 

        NSArray *imagenArray = [stringurl  componentsSeparatedByString:@"/"];
        
        NSString *imageName = [imagenArray objectAtIndex:imagenArray.count-2];
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *jpegFilePath = [NSString stringWithFormat:@"%@/%@.png",docDir,imageName];
    
    
    if (![url isEqual:NULL] && ![stringurl isEqualToString:@""] && ![stringurl isEqualToString:@"(null)"]){
    
    if (activityIndicator == nil)
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
        activityIndicator.frame = CGRectMake(self.frame.size.width / 2 - 10, self.frame.size.height / 2 - 10, 20, 20);
        [self addSubview:activityIndicator];
        [activityIndicator startAnimating];

        
        if(![[NSFileManager defaultManager] fileExistsAtPath:jpegFilePath]){
            NSURLRequest *theRequest=[NSURLRequest requestWithURL:url
                                                      cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                  timeoutInterval:60.0];
            
            NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
            [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(imageAnimation:) userInfo:nil repeats:NO];
            if (theConnection) {
                receivedData =[NSMutableData data];
                self.alpha = 0.0;
            }
            
        }else{

            NSArray *imagenArray = [stringurl  componentsSeparatedByString:@"/"];
            NSString *imageName = [imagenArray objectAtIndex:imagenArray.count-2];
            
            NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *jpegFilePath = [NSString stringWithFormat:@"%@/%@.png",docDir,imageName];
            
            NSLog(@"%@",jpegFilePath);
            
             self.image =  [UIImage imageWithContentsOfFile:jpegFilePath];
            
            [activityIndicator stopAnimating];
            [activityIndicator removeFromSuperview];


        }
    }else{
        self.image = [UIImage imageNamed:[self noImageSelector]];

    }
        
    }
    


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{

    if ([response expectedContentLength] < 0)
    {
        NSLog(@"Connection error");
        //here cancel your connection.
        [connection cancel];
        return;
    }else{
        [receivedData setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
   // if (receivedData != nil)receivedData = [[NSMutableData data] init];
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    //[connection release];
    // receivedData is declared as a method instance elsewhere
    //[receivedData release];
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",  [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    NSLog(@"Succeeded! Received %d Kb of data",[receivedData length] / 1024);
   // if (receivedData != nil)receivedData = [[NSMutableData data] init];
    
    if (activityIndicator != nil){
        [activityIndicator stopAnimating];
        [activityIndicator removeFromSuperview];
    }
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(imageAnimation:) userInfo:nil repeats:NO];
    
    
    // release the connection, and the data object
    //[connection release];
    //[receivedData release];
}

-(void)imageAnimation:(NSTimer *)timer{
    
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];
    self.image = [UIImage imageWithData:receivedData];
    self.alpha = 1.0;
    [UIView commitAnimations];

}

-(void)imageAnimationOffLine:(NSTimer *)timer{
    
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];
    self.alpha = 1.0;
    [UIView commitAnimations];
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}


- (void)endImageContext
{
    UIGraphicsEndImageContext();
}




@end
