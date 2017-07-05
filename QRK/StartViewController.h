//
//  StartViewController.h
//  QRK
//
//  Created by Alexei Karas on 21.06.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton* start;
@property (strong, nonatomic) IBOutlet UIButton* byKaras;

-(IBAction)actionStartQRK:(UIButton*)sender;
-(IBAction)actionByKaras:(UIButton*)sender;

@end
