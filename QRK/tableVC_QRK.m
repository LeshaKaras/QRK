//
//  tableVC_QRK.m
//  QRK
//
//  Created by Alexei Karas on 21.06.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import "tableVC_QRK.h"
#import "StartViewController.h"
#import "QRController.h"
#import "DataManagerQRK.h"
#import "WebController.h"

@interface tableVC_QRK ()

@end

@implementation tableVC_QRK

-(void) loadView {
    [super loadView];
    
    self.arrayData = [[DataManagerQRK sharedManager] dataQRK];
    self.navigBar.topItem.title = @"My scans";
    
    [self loadImages];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buttonScan];
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data Sourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.arrayData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString* reuse = @"reuse";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if(!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuse];
    }
    
    ScanEntity* object = [self.arrayData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = object.stringName;
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"dd/MM HH:mm";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Scan date: %@",
                                 [dateFormatter stringFromDate:object.dateCriatedObject]];
    return cell;
    
}

#pragma mark - Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ScanEntity* object = [self.arrayData objectAtIndex:indexPath.row];
    
    [self alert:object];
}

#pragma mark - Action

-(IBAction)actionCancel:(UINavigationBar*)sender {
    
    StartViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"startQRK"];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void) actionButtonScan:(UIButton*) sender {

    QRController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"cameraQRK"];
    
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Button

-(void) alert:(ScanEntity*) object {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"What do?"
                                                                   message:@"сhoose"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* copy = [UIAlertAction actionWithTitle:@"Copy buffer"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                     
                                                     UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                                                     [pasteboard setString:object.stringName];
                                                     
                                                     [alert dismissViewControllerAnimated:YES
                                                                               completion:nil];
                                                 }];
    
    UIAlertAction* browser = [UIAlertAction actionWithTitle:@"Show in browser"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        
                [[DataManagerQRK sharedManager] loadObjectSelected:object.stringName];
                                                        
                WebController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WebVC"];
                [self presentViewController:vc animated:YES completion:nil];
                                    
                                                    }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleDestructive
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       [alert dismissViewControllerAnimated:YES
                                                                                 completion:nil];
                                                   }];
    
    
    [alert addAction:copy];
    [alert addAction:browser];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void) buttonScan {
    
    UIButton* scan = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.bounds)-90,
                                                                CGRectGetMaxY(self.view.bounds)-90,
                                                                100,
                                                                100)];
    UIImage* imgN = [UIImage imageNamed:@"ButtonScanNormal.png"];
    UIImage* imgS = [UIImage imageNamed:@"ButtonScanSelected.png"];
    
    [scan setImage:imgN forState:UIControlStateNormal];
    [scan setImage:imgS forState:UIControlStateSelected];
    
    
    [scan addTarget:self action:@selector(actionButtonScan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:scan aboveSubview:self.tableView];
}

- (void) loadImages {
    
    UIImageView*  backgroundImageTable= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgraungImageTable.png"]];
    self.tableView.backgroundView = backgroundImageTable;
    
    UIImage*  img = [UIImage imageNamed:@"Bar.png"];
    [self.navigBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    
}
@end
