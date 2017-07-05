//
//  QRController.m
//  QRK
//
//  Created by Alexei Karas on 22.06.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import "QRController.h"
#import "tableVC_QRK.h"
#import "DataManagerQRK.h"

NSString * const ScanResultStringDidChangeNotification = @"ScanResultStringDidChangeNotification";

@interface QRController ()

@property (strong, nonatomic) AVCaptureSession * captureSession;
@property (strong, nonatomic) AVCaptureDevice * device;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * videoPreviewLayer;
@property (strong, nonatomic) AVAudioPlayer * audioPlayer;
@property (strong, nonatomic) NSString * scanResult;

@property (assign, nonatomic) BOOL isFlashlightON;

@property (assign, nonatomic) BOOL isScanning;

@end

@implementation QRController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isFlashlightON = NO;
    
    [self startScanning];
    
    [self loadSound];
    
    NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(scanResultNotification) name:ScanResultStringDidChangeNotification object:nil];
    
    [self.cameraView addSubview:self.backButton];
    [self.cameraView addSubview:self.flashLightbutton];
    
    [self.cameraView bringSubviewToFront:self.backButton];
    [self.cameraView bringSubviewToFront:self.flashLightbutton];
    
}

-(void)setScanResult:(NSString *)scanResult {
    
    _scanResult = scanResult;
    [[NSNotificationCenter defaultCenter] postNotificationName:ScanResultStringDidChangeNotification object:nil];
    
}

-(void) scanResultNotification {
    
    NSDate * date = [NSDate date];
    [[DataManagerQRK sharedManager] insertNewScanObject:self.scanResult scanDate:date];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(BOOL) startScanning {
    
    self.isScanning = !self.isScanning;
    NSError * error = nil;
    
    AVCaptureDevice * captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.device = captureDevice;
    
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    self.captureSession = [[AVCaptureSession alloc] init];
    
    [self.captureSession addInput:input];
    
    AVCaptureMetadataOutput * captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [self.captureSession addOutput:captureMetadataOutput];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("Queue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    self.videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    [self.videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    self.videoPreviewLayer.frame = self.cameraView.frame;
    [self.cameraView.layer addSublayer:self.videoPreviewLayer];
    
    [self.captureSession startRunning];
    return YES;
}
-(void) loadSound {
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"accept_sound" ofType:@"wav"];
    NSURL * soundURL = [NSURL URLWithString:filePath];
    
    NSError * error = nil;
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
    if (error) {
        NSLog(@"Sound loading is failed");
        NSLog(@"%@", [error localizedDescription]);
    } else {
        [self.audioPlayer prepareToPlay];
    }
    
}

-(void) captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    if(metadataObjects != nil && [metadataObjects count] > 0) {
        
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            [self performSelectorOnMainThread:@selector (stopScanning) withObject:nil waitUntilDone:NO];
            [self performSelectorOnMainThread:@selector (setScanResult:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            
            if (self.audioPlayer) {
                [self.audioPlayer play];
            }
        }
    }
}

-(void) stopScanning {
    
    [self.captureSession stopRunning];
    self.captureSession = nil;
    
    [self.videoPreviewLayer removeFromSuperlayer];
    
}

#pragma mark - Action

-(IBAction) actionLightButton:(UIButton *)sender {
    
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    [device setTorchModeOnWithLevel:1.f error:nil];
    
    if (self.isFlashlightON) {
        [device setTorchMode:AVCaptureTorchModeOff];
        [self.flashLightbutton setImage:[UIImage imageNamed:@"FlashOff.png"] forState:UIControlStateNormal];
        NSLog(@"Выключен");
    } else {
        [device setTorchMode:AVCaptureTorchModeOn];
        [self.flashLightbutton setImage:[UIImage imageNamed:@"FlashOn.png"] forState:UIControlStateNormal];
        NSLog(@"Включен");
    }
    self.isFlashlightON = !self.isFlashlightON;
    [device unlockForConfiguration];
}
-(IBAction) actionBackButton:(UIButton *)sender{
    
    tableVC_QRK* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"tableQRK"];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

@end
