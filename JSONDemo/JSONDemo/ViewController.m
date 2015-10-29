//
//  ViewController.m
//  JSONDemo
//
//  Created by 杨晓晨 on 15/10/29.
//  Copyright © 2015年 杨晓晨. All rights reserved.
//

#import "ViewController.h"
#import "WeData.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WeData *weData = [[WeData alloc] init];
    [weData loadData];
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
