//
//  WebController.h
//  QRK
//
//  Created by Alexei Karas on 30.06.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManagerQRK.h"
#import "tableVC_QRK.h"

@interface WebController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView* webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView* indicatorLoad;
@property (strong, nonatomic) IBOutlet UIBarButtonItem* buttonBack;
@property (strong, nonatomic) IBOutlet UIBarButtonItem* buttonForward;

-(IBAction)actionButtonBack:(UIBarButtonItem*)sender;
-(IBAction)actionButtonForward:(UIBarButtonItem*)sender;
-(IBAction)actionButtonRefresh:(UIBarButtonItem*)sender;

@end
