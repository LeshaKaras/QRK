//
//  WebController.m
//  QRK
//
//  Created by Alexei Karas on 30.06.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import "WebController.h"

@implementation WebController

- (void) loadView {
    [super loadView];
    
    [self.webView loadRequest:[self parsingString:[[DataManagerQRK sharedManager] objectLoadWebView]]];
}


#pragma mark - Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.indicatorLoad startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.indicatorLoad stopAnimating];
    [self stateButton];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.indicatorLoad stopAnimating];
    [self stateButton];
    
    [self showAlerErrorLoad];
}

#pragma mark - Action

-(IBAction)actionButtonBack:(UIBarButtonItem*)sender {
    if ([self.webView canGoBack]) {
        [self.indicatorLoad stopAnimating];
        [self.webView goBack];
    }
}
-(IBAction)actionButtonForward:(UIBarButtonItem*)sender{
    if ([self.webView canGoForward]) {
        [self.indicatorLoad stopAnimating];
        [self.webView goForward];
    }
}
-(IBAction)actionButtonRefresh:(UIBarButtonItem*)sender{
    [self.webView stopLoading];
    [self.webView reload];
}

#pragma  mark - Methods

-(void) stateButton{
    
    self.buttonBack.enabled = [self.webView canGoBack];
    self.buttonForward.enabled = [self.webView canGoForward];
    
}
- (NSURLRequest*) parsingString:(NSString*) string {
    
    NSURLRequest* request = [[NSURLRequest alloc]init];
    
    if ([string hasPrefix:@"http"]) {
        
        NSURL* urlString = [NSURL URLWithString:string];
        
        request = [NSURLRequest requestWithURL:urlString];
        
    } else if ([string hasPrefix:@"https"]) {
        
        NSURL* urlString = [NSURL URLWithString:string];
        
        request = [NSURLRequest requestWithURL:urlString];
        
    } else {
        
        NSString* stringSearchGoogle = [NSString stringWithFormat:@"http://www.google.com/search?q=%@",string];
        
        NSURL* urlString = [NSURL URLWithString:stringSearchGoogle];
        
        request = [NSURLRequest requestWithURL:urlString];
        
    }
    
    return request;
}

- (void) showAlerErrorLoad {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"Sorry, there are problems with the load on this request."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* buttonOk = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                        
                                                         tableVC_QRK* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"tableQRK"];
                                                         
                                                         [self presentViewController:vc animated:YES completion:nil];
                                                         
                                                     }];
    
    [alert addAction:buttonOk];
    
    [self presentViewController:alert animated:YES completion:nil];

}
@end
