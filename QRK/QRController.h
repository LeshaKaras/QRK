//
//  QRController.h
//  QRK
//
//  Created by Alexei Karas on 22.06.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

extern NSString * const scanResultStringDidChangeNotification;

@protocol QRViewDelegate
@optional

-(void) reloadTableViewData;

@end

@interface QRController : UIViewController <QRViewDelegate, AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) id <QRViewDelegate> delegate;

@property (strong, nonatomic) NSArray * dataArray;

@property (weak, nonatomic) IBOutlet UIButton * flashLightbutton;
@property (weak, nonatomic) IBOutlet UIButton * backButton;
@property (weak, nonatomic) IBOutlet UIView * cameraView;



-(IBAction) actionLightButton:(UIButton *)sender;
-(IBAction) actionBackButton:(UIButton *)sender;

@end
