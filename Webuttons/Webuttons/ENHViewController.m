//
//  ENHViewController.m
//  Webuttons
//
//  Created by Jonathan Saggau on 6/27/12.
//  Copyright (c) 2012 Sounds Broken inc. All rights reserved.
//

#import "ENHViewController.h"

static NSString *kCustomURLPrefix = @"webuttons://button_";
static NSString *kJavascriptTrue = @"true";
static NSString *kJavascriptFalse = @"false";

@interface ENHViewController ()

@property(nonatomic, weak)IBOutlet UIWebView *webView;

@end

@implementation ENHViewController

@synthesize webView = _webView;

- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSLog(@"[%@ %@] (%@)", self, NSStringFromSelector(_cmd), request);
    NSURL *url = [request URL];
    NSString *urlStr = [[url absoluteString] lowercaseString];
    if ([urlStr rangeOfString:kCustomURLPrefix].length > 0) 
    {
        NSScanner *scanner = [NSScanner scannerWithString:urlStr];
        [scanner scanString:kCustomURLPrefix intoString:nil];
        NSInteger buttonId = NSNotFound;
        [scanner scanInteger:&buttonId];
        
        NSString *someJavascript = @"buttonIsOn('#btn_%d');";
        someJavascript = [NSString stringWithFormat:someJavascript, buttonId];
        NSString *result = [aWebView stringByEvaluatingJavaScriptFromString:someJavascript];
        NSString *buttonState = @"Unknown";
        
        if ([result isEqualToString:kJavascriptTrue])
        {
            buttonState = @"On";
        }
        if ([result isEqualToString:kJavascriptFalse])
        {
            buttonState = @"Off";
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You pushed my button!"
                                                        message:[NSString stringWithFormat:@"button number %d is %@", buttonId, buttonState]
                                                       delegate:nil 
                                              cancelButtonTitle:@"Okay" 
                                              otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    return YES;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.webView setScalesPageToFit:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self openRootHtml];
}

#pragma mark - html loading
-(void)openRootHtml
{
    NSString *mainBundlePath = [[NSBundle mainBundle] resourcePath]; 
    NSString *pth = [mainBundlePath stringByAppendingPathComponent:@"index.html"]; 
    NSURL *url = [NSURL fileURLWithPath:pth];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];    
    [self.webView loadRequest:request];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
