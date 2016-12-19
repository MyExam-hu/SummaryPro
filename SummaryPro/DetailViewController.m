//
//  DetailViewController.m
//  SummaryPro
//
//  Created by huweidong on 12/12/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "DetailViewController.h"
#import "clsDogName.h"

@interface DetailViewController ()

@property (readwrite, nonatomic, assign) NSInteger activityCount;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _activityCount++;
    _activityCount = MAX(_activityCount - 1, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveClick:(UIButton *)sender {
//    [self.ocl setDogNameStr:@"blue"];
    self.ocl.dogNameStr=@"blue";
    [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
