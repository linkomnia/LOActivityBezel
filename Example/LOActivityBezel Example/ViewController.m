//
//  ViewController.m
//  LOActivityBezel Example
//
//  Created by Roger So on 7/4/14.
//  Copyright (c) 2014 LinkOmnia Limited. All rights reserved.
//

#import "ViewController.h"
#import <LOActivityBezel.h>

@interface ViewController ()
@property (nonatomic, strong) NSTimer *dismissTimer;
@end

@implementation ViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];

    CGRect vb = self.view.bounds;

    UIButton *presentBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    presentBtn.frame = CGRectMake((vb.size.width - 200.f)/2.f, 40.f, 200.f, 44.f);
    presentBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [presentBtn setTitle:@"Present Bezel" forState:UIControlStateNormal];
    [presentBtn addTarget:self action:@selector(didTapPresentButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentBtn];

    UIButton *presentWithMsgBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    presentWithMsgBtn.frame = CGRectMake((vb.size.width - 200.f)/2.f, 40.f + 44.f + 20.f, 200.f, 44.f);
    presentWithMsgBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [presentWithMsgBtn setTitle:@"Present Bezel with Message" forState:UIControlStateNormal];
    [presentWithMsgBtn addTarget:self action:@selector(didTapPresentWithMessageButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentWithMsgBtn];
}

#pragma mark -

- (void)didTapPresentButton:(id)sender
{
    [[LOActivityBezel sharedBezel] present];
    self.dismissTimer = [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(dismissTimerDidFire:) userInfo:nil repeats:NO];
}

- (void)didTapPresentWithMessageButton:(id)sender
{
    [[LOActivityBezel sharedBezel] presentWithMessage:@"Some message"];
    self.dismissTimer = [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(dismissTimerDidFire:) userInfo:nil repeats:NO];
}

#pragma mark -

- (void)dismissTimerDidFire:(NSTimer *)timer
{
    self.dismissTimer = nil;
    [[LOActivityBezel sharedBezel] dismiss];
}

@end
