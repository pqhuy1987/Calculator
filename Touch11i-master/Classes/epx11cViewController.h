//
//  epx11cViewController.h
//  epx11c
//
//  Created by Elvis Pfützenreuter on 8/29/11.
//  Copyright 2011 Elvis Pfützenreuter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
@import GoogleMobileAds;

@interface epx11cViewController : UIViewController <UIWebViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate> {
    SystemSoundID audio_id;
    SystemSoundID audio2_id;
    IBOutlet UIWebView *html;
    NSInteger click;
    NSInteger separator;
    NSInteger fb;
    NSInteger rapid;
    NSInteger layout;
    NSInteger old_layout;
    BOOL splash_fadedout;
    NSInteger lock;
    BOOL iphone5;
    NSMutableDictionary *memories;
}

@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView2;
@property (weak, nonatomic) IBOutlet UIButton *Xbutton;
@property (weak, nonatomic) IBOutlet UIButton *Xbutton2;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentTab;
@property (nonatomic, strong) GADInterstitial *interstitial;
@property (strong, nonatomic) NSTimer *timer;

- (void) playClick;
- (BOOL) webView:(UIWebView *)view shouldStartLoadWithRequest:(NSURLRequest *)request 
  navigationType:(UIWebViewNavigationType)navigationType;

@end

