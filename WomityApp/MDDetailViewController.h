//
//  MDDetailViewController.h
//  MultipleMasterDetailViews
//
//  Created by Todd Bates on 11/14/11.
//  Copyright (c) 2011 Science At Hand LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<AddressBook/AddressBook.h>


@class Noticia;

@interface MDDetailViewController : UIViewController <UISplitViewControllerDelegate,UIGestureRecognizerDelegate>{
    
        NSMutableData *responseData;
}

@property (strong, nonatomic) id detailItem;

@end
