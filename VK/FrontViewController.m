//
//  FrontViewController.m
//  VK
//
//  Created by Michail on 16.09.16.
//  Copyright © 2016 Mikhail Prysiazhniy. All rights reserved.
//

#import "FrontViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"

@interface FrontViewController ()

@end

@implementation FrontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    //    SWRevealViewController *revealController = [self revealViewController];
    UIWindow *window = appDelegate.window;
    SWRevealViewController *revealController = (id)window.rootViewController;
    
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Show"
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    //
    //    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
    //                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
