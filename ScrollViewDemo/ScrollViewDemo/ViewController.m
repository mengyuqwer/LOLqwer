//
//  ViewController.m
//  ScrollViewDemo
//
//  Created by student on 16/2/25.
//  Copyright © 2016年 student. All rights reserved.
//

#import "ViewController.h"
#import "LWXScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < 4;  i++) {
        
        array[i] = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"walkthrough_%ld",i+1] ofType:@"jpg"]];
    }
    
    
    
    LWXScrollView *scroll = [[LWXScrollView alloc] initWithFrame:self.view.bounds withImageArray:array];
    scroll.autoMoveEnabled = YES;
    [self.view addSubview:scroll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
