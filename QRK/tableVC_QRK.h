//
//  tableVC_QRK.h
//  QRK
//
//  Created by Alexei Karas on 21.06.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tableVC_QRK : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView* tableView;
@property (strong, nonatomic) IBOutlet UINavigationBar* navigBar;

@property (strong, nonatomic) NSArray* arrayData;

@property (strong, nonatomic) IBOutlet UIBarButtonItem* cancelButton;


-(IBAction)actionCancel:(UIBarButtonItem*)sender;

@end
