//
//  StartViewController.m
//  QRK
//
//  Created by Alexei Karas on 21.06.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import "StartViewController.h"
#import "tableVC_QRK.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)actionStartQRK:(UIButton*)sender {
    
    tableVC_QRK* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"tableQRK"];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}
-(IBAction)actionByKaras:(UIButton*)sender {
    
    NSLog(@"by Alekseii Karas");
}

@end
