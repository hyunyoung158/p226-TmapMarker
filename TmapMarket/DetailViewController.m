//
//  DetailViewController.m
//  TmapMarket
//
//  Created by SDT-1 on 2014. 1. 17..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DetailViewController

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //웹뷰에 뿌리기
    NSURL *url = [[NSURL alloc] initWithString:self.urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];

    [self.webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
