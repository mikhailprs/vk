//
//  Router.m
//  VK
//
//  Created by Mikhail Prysiazhniy on 15.09.16.
//  Copyright © 2016 Mikhail Prysiazhniy. All rights reserved.
//

#import "Router.h"
#import "BaseViewController.h"
#import "RearViewControlller.h"
#import "SWRevealViewController.h"
#import "FrontViewController.h"
#import "AppDelegate.h"

@interface Router ()

@property (strong, nonatomic) SWRevealViewController *reveal;

@end

@implementation Router

#pragma mark - init

- (instancetype)init{
    self = [super init];
    if (self){
        [self setup];
    }
    return self;
}



#pragma mark - settings

- (void)setup{
    id userDef = [[NSUserDefaults standardUserDefaults] valueForKey:@"VKAccessToken"];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;

        
    //    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //    appDelegate.window = window;
        
        FrontViewController *frontViewController = [[FrontViewController alloc] init];
        RearViewControlller *rearViewController = [[RearViewControlller alloc] init];
        
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
        
        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
        _reveal = revealController;
        
        
        //revealController.bounceBackOnOverdraw=NO;
        //revealController.stableDragOnOverdraw=YES;
        
    //    self.viewController = revealController;
        
        
    

        BaseViewController *vc = [BaseViewController new];
    
        if (userDef){
            appDelegate.window.rootViewController = revealController;
        }else{
            appDelegate.window.rootViewController = vc;
        }
        [appDelegate.window makeKeyAndVisible];
}


@end
