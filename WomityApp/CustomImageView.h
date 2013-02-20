//
//  CustomImageView.h
//  NoName
//
//  Created by Eduardo Rodriguez on 9/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>

@interface CustomImageView : UIImageView{

    NSMutableData *receivedData;
    UIActivityIndicatorView *activityIndicator;
    BOOL isAnimating;
    int index;
}

@property(nonatomic,strong) NSMutableData *receivedData;
@property(nonatomic,assign) BOOL isAnimating;
@property(nonatomic,assign)  int index;

-(id)initWithURL:(NSURL *)url;
-(void)setURL:(NSURL *)url;
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (void)beginImageContextWithSize:(CGSize)size;
+ (void)endImageContext;
+(UIImage *)getImageFromCachePath:(NSURL *)url;

@end
