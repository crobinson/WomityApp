//
//  FacebookViewController.h
//  WomityApp
//
//  Created by Eduardo Rodriguez Macmini on 11/20/12.
//  Copyright (c) 2012 Carlos Andres Robinson Lara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacebookViewController : UIViewController<UIWebViewDelegate,UIAlertViewDelegate>{
    
    IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *loading;
    int counter;
     BOOL isFacebook;
    UIAlertView *alertView;
}
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, assign) BOOL isFacebook;
- (IBAction)cancel:(id)sender;
-(NSString *)connectionFacebook:(NSMutableString *) jsonRequest:(NSURL *)url;
@end
