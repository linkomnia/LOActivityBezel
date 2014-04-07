//
// LOActivityBezel.m
//
// Copyright 2011 LinkOmnia Limited.
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation files
// (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software,
// and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
// BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

#import "LOActivityBezel.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat LOActivityBezelLabelMargin = 20.f;
static const CGFloat LOActivityBezelLabelHeight = 20.f;

@interface LOActivityBezelViewController : UIViewController
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
- (void)setMessage:(NSString *)message;
@end

@implementation LOActivityBezelViewController

- (void)loadView
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIView *v = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    v.backgroundColor = [UIColor clearColor];
    self.view = v;

    CGSize bezelSize = CGSizeMake(160.f, 160.f);
    CGRect frame = CGRectMake((screenSize.width - bezelSize.width)/2.f, (screenSize.height - bezelSize.height)/2.f, bezelSize.width, bezelSize.height);
    UIView *bg = [[UIView alloc] initWithFrame:frame];
    bg.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.75f];
    bg.layer.cornerRadius = 20.0f;
    bg.tag = 1;
    [v addSubview:bg];

    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    CGRect bezelBounds = bg.bounds;
    activityIndicator.center = CGPointMake(bezelBounds.size.width/2.f, bezelBounds.size.height/2.f);
    [activityIndicator startAnimating];
    [bg addSubview:activityIndicator];

    CGRect labelRect = CGRectMake(LOActivityBezelLabelMargin, bezelBounds.size.height-LOActivityBezelLabelMargin-LOActivityBezelLabelHeight, 
                                  bezelBounds.size.width-LOActivityBezelLabelMargin*2, LOActivityBezelLabelHeight);
    UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
    [label setTextColor:[UIColor lightTextColor]];
    [label setFont:[UIFont systemFontOfSize:[UIFont labelFontSize]-2.f]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    label.tag = 0xBEEF;
    [bg addSubview:label];
}

- (void)setMessage:(NSString *)message
{
    UILabel *label = (UILabel *)[self.view viewWithTag:0xBEEF];
    label.text = message;
    label.hidden = (message == nil);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return _statusBarStyle;
}

@end

@interface LOActivityBezel ()
@property (nonatomic, strong) UIWindow *window;
@end

@implementation LOActivityBezel

- (id)init
{
    self = [super init];
    return self;
}

#pragma mark -
#pragma mark instance methods

- (void)present
{
    [self presentWithMessage:nil];
}

- (void)presentWithMessage:(NSString *)message
{
    LOActivityBezelViewController *vc;
    if (_window == nil) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        vc = [[LOActivityBezelViewController alloc] init];
        _window.rootViewController = vc;
    } else {
        vc = (LOActivityBezelViewController *)_window.rootViewController;
    }
    [vc setMessage:message];

    // get the current status bar style
    UIStatusBarStyle sbs = [UIApplication sharedApplication].statusBarStyle;
    UIViewController *currentRoot = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([currentRoot respondsToSelector:@selector(preferredStatusBarStyle)]) {
        sbs = currentRoot.preferredStatusBarStyle;
    }
    vc.statusBarStyle = sbs;

    _window.windowLevel = 1.f;
    _window.opaque = NO;
    _window.hidden = NO;
}

- (void)dismiss
{
    [UIView animateWithDuration:0.25f
                     animations:^{
                         self.window.rootViewController.view.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         self.window.hidden = YES;
                         self.window = nil;
                     }];
}

#pragma mark -
#pragma mark Singleton methods

+ (id)sharedBezel
{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
